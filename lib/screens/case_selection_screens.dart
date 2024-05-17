import 'package:flutter/material.dart'; // Flutter Material package
import 'package:provider/provider.dart'; // Provider package for state management
import 'package:test_app/providers/user_provider.dart'; // Importing the UserProvider class
import 'package:test_app/screens/case_opening_screen.dart'; // Importing the CaseOpeningScreen class
import 'package:test_app/screens/inventory_screen.dart'; // Importing the InventoryScreen class
import 'package:test_app/screens/login_screen.dart'; // Importing the LoginScreen class

// Widget for the case selection screen
class CaseSelectionScreen extends StatelessWidget {
  const CaseSelectionScreen({super.key}); // Constructor for the CaseSelectionScreen class

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Accessing the UserProvider instance
    final user = userProvider.user; // Getting the current user from the provider

    return Scaffold( // Scaffold widget for the overall screen layout
      appBar: AppBar( // AppBar widget for the top app bar
        title: const Text('Select a Case'), // Title of the app bar
        actions: [ // List of actions/widgets in the app bar
          IconButton( // IconButton widget for the inventory icon
            icon: const Icon(Icons.inventory), // Icon for inventory
            onPressed: () { // Callback function when the inventory icon is pressed
              Navigator.push( // Navigating to the inventory screen
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()), // Creating a new route for the inventory screen
              );
            },
          ),
          IconButton( // IconButton widget for the logout icon
            icon: const Icon(Icons.logout), // Icon for logout
            onPressed: () { // Callback function when the logout icon is pressed
              Provider.of<UserProvider>(context, listen: false).logout(); // Logging out the user using the UserProvider
              Navigator.pushReplacement( // Navigating to the login screen and replacing the current route
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Creating a new route for the login screen
              );
            },
          ),
        ],
      ),
      body: Center( // Center widget to center its child
        child: Column( // Column widget to arrange children vertically
          mainAxisAlignment: MainAxisAlignment.center, // Aligning children vertically at the center
          children: [ // List of children widgets
            if (user != null) // Conditional rendering based on user login status
              Column( // Column widget for user information
                children: [ // List of children widgets for user information
                  Text('Logged in as: ${user.username}'), // Text widget to display username
                  Text('XP: ${user.xp}'), // Text widget to display XP
                  Text('Rank: ${user.rank}'), // Text widget to display rank
                ],
              ),
            const SizedBox(height: 20), // SizedBox widget for vertical spacing
            Expanded( // Expanded widget to fill remaining space
              child: ListView.builder( // ListView.builder widget to display list of cases
                itemCount: userProvider.cases.length, // Total number of cases
                itemBuilder: (context, index) { // Builder function to build each list item
                  final caseItem = userProvider.cases[index]; // Getting the case item at the current index
                  return ListTile( // ListTile widget for each case item
                    title: Text(caseItem.name), // Title of the case item
                    onTap: () { // Callback function when the case item is tapped
                      Navigator.push( // Navigating to the case opening screen
                        context,
                        MaterialPageRoute( // Creating a new route for the case opening screen
                          builder: (context) => CaseOpeningScreen(caseItem: caseItem, onThemeToggle: null),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
