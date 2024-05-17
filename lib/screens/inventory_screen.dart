import 'package:flutter/material.dart'; // Flutter Material package
import 'package:provider/provider.dart'; // Provider package for state management
import 'package:test_app/providers/user_provider.dart'; // Importing the UserProvider class

// Widget for the inventory screen
class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});

  // Map of rarity colors
  final Map<String, Color> rarityColors = {
    'common': Colors.grey,
    'uncommon': Colors.green,
    'rare': Colors.blue,
    'epic': Colors.purple,
    'legendary': Colors.orange,
  };

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user; // Accessing the UserProvider instance and getting the current user

    return Scaffold( // Scaffold widget for the overall screen layout
      appBar: AppBar(title: const Text('Inventory')), // AppBar widget for the top app bar
      body: user == null || user.inventory.isEmpty // Conditional rendering based on user login status and inventory
          ? const Center( // Center widget for centering its child
              child: Text( // Text widget for displaying inventory empty message
                'Inventory is empty', // Message text
                style: TextStyle(fontSize: 24), // Text style with font size
              ),
            )
          : ListView.builder( // ListView.builder widget to display list of inventory items
              itemCount: user.inventory.length, // Total number of inventory items
              itemBuilder: (context, index) { // Builder function to build each list item
                final item = user.inventory[index]; // Getting the inventory item at the current index
                return ListTile( // ListTile widget for each inventory item
                  leading: Image.asset(item['image']), // Leading widget for the item image
                  title: Text( // Title of the inventory item
                    item['name'], // Name of the item
                    style: TextStyle(color: rarityColors[item['rarity']]), // Text style with color based on rarity
                  ),
                  subtitle: Text( // Subtitle of the inventory item showing rarity
                    item['rarity'], // Rarity of the item
                    style: TextStyle(color: rarityColors[item['rarity']]), // Text style with color based on rarity
                  ),
                );
              },
            ),
    );
  }
}
