import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/user_provider.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: user == null || user.inventory.isEmpty
          ? const Center(
              child: Text(
                'Inventory is empty',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: user.inventory.length,
              itemBuilder: (context, index) {
                final item = user.inventory[index];
                return ListTile(
                  leading: Image.asset(item['image']),
                  title: Text(
                    item['name'],
                    style: TextStyle(color: rarityColors[item['rarity']]),
                  ),
                  subtitle: Text(
                    item['rarity'],
                    style: TextStyle(color: rarityColors[item['rarity']]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          sellForCoins(context, item);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          viewItem(context, item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void sellForCoins(BuildContext context, Map<String, dynamic> item) {
    // Get the UserProvider instance
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Show a snackbar indicating the item sold
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} sold!')),
    );

    // Remove the sold item from the inventory
    userProvider.removeFromInventory(item);
  }

  void viewItem(BuildContext context, Map<String, dynamic> item) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(item['name']),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(item['image']),
          const SizedBox(height: 10),
          Text('Rarity: ${item['rarity']}'),
          Text('Float: ${item['float']}'), // Assuming 'float' is a field in the item data
          Text('Wear: ${item['wear']}'), // Assuming 'wear' is a field in the item data
          // Add more item details here as needed
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
}