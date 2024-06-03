import 'dart:math'; // Dart math library
import 'package:flutter/foundation.dart'; // Flutter foundation package
import 'package:flutter/material.dart'; // Flutter material package
import 'package:provider/provider.dart'; // Provider package for state management
import 'package:test_app/models/case.dart'; // Importing the Case model
import 'package:test_app/providers/user_provider.dart'; // Importing the UserProvider
import 'package:test_app/screens/case_selection_screens.dart'; // Importing the CaseSelectionScreen
import 'package:test_app/screens/inventory_screen.dart'; // Importing the InventoryScreen
import 'package:test_app/screens/settings_screen.dart'; // Importing the SettingsScreen

class CaseOpeningScreen extends StatefulWidget {
  final Case caseItem; // The Case object for which the screen is opened
  final VoidCallback? onThemeToggle; // Callback function for toggling theme

  const CaseOpeningScreen({super.key, required this.caseItem, this.onThemeToggle});

  @override
  // ignore: library_private_types_in_public_api
  _CaseOpeningScreenState createState() => _CaseOpeningScreenState();
}

class _CaseOpeningScreenState extends State<CaseOpeningScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController(); // Scroll controller for the case opening animation
  late AnimationController _animationController; // Animation controller for the case opening animation
  late Animation<double> _animation; // Animation for scrolling through items
  String? currentItem; // Currently selected item's name
  String? currentItemImage; // Currently selected item's image path
  Color currentColor = Colors.grey; // Currently selected item's rarity color
  bool isOpening = false; // Flag to indicate if the case is being opened
  bool isOpened = false; // Flag to indicate if the case has been opened
  late int selectedItemIndex; // Index of the selected item in the case
  List<Map<String, dynamic>> displayedItems = []; // List of displayed items during case opening

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Longer animation duration
    );
  }

  // Method to start the case opening animation
  void startAnimation() {
    double initialOffset = 5000.0; // Start with a large offset for longer animation
    double targetOffset = initialOffset + (selectedItemIndex + 1) * 200.0; // Offset for the selected item

    const fastStartSlowEndCurve = Cubic(0.1, 0.9, 0.2, 1.0); // Animation curve

    _animation = Tween<double>(
      begin: 0,
      end: targetOffset,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: fastStartSlowEndCurve,
    ))
      ..addListener(() {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_animation.value); // Scroll to the animated position
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isOpening = false;
            isOpened = true;
            // Ensure the current item and image are updated to match the final scroll position
            int displayedItemIndex = (_scrollController.offset + MediaQuery.of(context).size.width / 2) ~/ 200 % displayedItems.length;
            currentItem = displayedItems[displayedItemIndex]['name'];
            currentItemImage = displayedItems[displayedItemIndex]['image'];
            currentColor = rarityColors[displayedItems[displayedItemIndex]['rarity']]!;
          });
          Provider.of<UserProvider>(context, listen: false).increaseXp(10); // Increase user's XP
        }
      });

    _animationController.forward(); // Start the animation
  }

  // Method to initiate case opening process
  void openCase() {
    setState(() {
      isOpening = true; // Set the opening flag
      isOpened = false; // Reset the opened flag
      displayedItems = List.generate(widget.caseItem.items.length * 50, (index) {
        final item = widget.caseItem.items[index % widget.caseItem.items.length];
        final image = item['images'][Random().nextInt(item['images'].length)];
        return {
          'id': item['id'],
          'name': item['name'],
          'rarity': item['rarity'],
          'image': image,
        };
      });
    });

    int index = Random().nextInt(widget.caseItem.items.length); // Randomly select an item index
    selectedItemIndex = index;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration.zero);

      if (_scrollController.hasClients) {
        startAnimation(); // Start the animation if scroll controller is attached
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        if (_scrollController.hasClients) {
          startAnimation(); // Start the animation with a slight delay if scroll controller is attached
        } else {
          if (kDebugMode) {
            print('ScrollController is still not attached to any scroll views.'); // Log a debug message if scroll controller is not attached
          }
        }
      }
    });
  }

  // Method to save the selected item to user's inventory
  void saveToInventory() {
    if (currentItem != null && currentItemImage != null) {
      final item = {
        'name': currentItem,
        'image': currentItemImage,
        'rarity': rarityColors.keys.firstWhere((k) => rarityColors[k] == currentColor),
      };
      Provider.of<UserProvider>(context, listen: false).addToInventory(item); // Add item to inventory
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$currentItem saved to inventory!')), // Show a snackbar message
      );
      reset(); // Reset the case opening process
    }
  }

  // Method to sell the selected item for coins
  void sellForCoins() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$currentItem sold for coins!')), // Show a snackbar message
    );
    reset(); // Reset the case opening process
  }

  // Method to reset the case opening process
  void reset() {
    setState(() {
      currentItem = null;
      currentItemImage = null;
      isOpening = false;
      isOpened = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0); // Jump scroll position to the beginning
      }
      _animationController.reset(); // Reset the animation controller
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose animation controller
    _scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user; // Get current user from provider

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.caseItem.name} '), // Display case name in app bar title
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer on menu icon press
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle, // Toggle theme on brightness icon press
          ),
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()), // Navigate to inventory screen
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CaseSelectionScreen()), // Navigate to case selection screen
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()), // Navigate to settings screen
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) // Display user info if logged in
              Column(
                children: [
                  Text('Logged in as: ${user.username}'),
                  Text('XP: ${user.xp}'),
                  Text('Rank: ${user.rank}'),
                ],
              ),
            const SizedBox(height: 20),
            if (!isOpening && !isOpened) // Only display button if not opening or opened
              ElevatedButton(
                onPressed: openCase, // Handle case opening button press
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text(
                  'Open Case',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            const SizedBox(height: 20),
            if (!isOpening && !isOpened) // Display case items grid if not opening or opened
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget.caseItem.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.caseItem.items[index];
                    final image = item['images'][0];
                    return GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(item['name']),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: rarityColors[item['rarity']]!),
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (isOpening) // Display case opening animation if opening
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: displayedItems.length,
                          itemBuilder: (context, index) {
                            final item = displayedItems[index];
                            return Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: rarityColors[item['rarity']]!),
                              ),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        Center(
                          child: Container(
                            height: 200,
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opening case...',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              )
            else if (isOpened) // Display opened case result if opened
              Column(
                children: [
                  Text(
                    'You got:',
                    style: TextStyle(fontSize: 24, color: currentColor),
                  ),
                  Text(
                    currentItem!,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: currentColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  currentItemImage != null
                      ? Image.asset(currentItemImage!)
                      : const Text('Error loading image'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: saveToInventory, // Handle save to inventory button press
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Save to Inventory'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: sellForCoins, // Handle sell for coins button press
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Sell for Coins'),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Map of rarity colors
  final Map<String, Color> rarityColors = {
  'Consumer Grade': Colors.white,
  'Industrial Grade': Colors.lightBlue,
  'Mil-Spec': Colors.blue,
  'Restricted': Colors.purple,
  'Classified': Colors.pink,
  'Covert': Colors.red,
  'Extraordinary': Colors.yellow, // Gold
  'Contraband': Colors.orange,
};


  // Method to get the probability of getting an item based on its index
 String getProbability(String rarity) {
  switch (rarity) {
    case 'Consumer Grade':
      return '50%'; // Common
    case 'Industrial Grade':
      return '30%'; // Uncommon
    case 'Mil-Spec':
      return '15%'; // Rare
    case 'Restricted':
      return '4%'; // Epic
    case 'Classified':
      return '1%'; // Legendary
    case 'Covert':
      return '0%'; // No Covert in your rarityColors map
    case 'Extraordinary':
      return '0%'; // No Extraordinary in your rarityColors map
    case 'Contraband':
      return '0%'; // No Contraband in your rarityColors map
    default:
      return '0%'; // Default to 0% for any unknown rarity
    }
  }
}
