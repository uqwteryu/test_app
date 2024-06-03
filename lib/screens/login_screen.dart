import 'package:flutter/material.dart'; // Flutter Material package
import 'package:provider/provider.dart'; // Provider package for state management
import 'package:test_app/providers/user_provider.dart'; // Importing the UserProvider class
import 'package:test_app/screens/case_selection_screens.dart'; // Importing the CaseSelectionScreen class

// Widget for the login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Constructor for the LoginScreen class

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState(); // Creating state for the LoginScreen widget
}

// State class for the login screen
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController(); // Text controller for username input
  final TextEditingController _passwordController = TextEditingController(); // Text controller for password input

  // Method to handle login
  void _login(BuildContext context) {
    String username = _usernameController.text; // Get username from text controller
    String password = _passwordController.text; // Get password from text controller

    if (username == 'nik' && password == '123') { // Check if credentials are correct
      Provider.of<UserProvider>(context, listen: false).login(username, 0, 'Unranked'); // Log in user using UserProvider
      Navigator.pushReplacement( // Navigate to the CaseSelectionScreen after successful login
        context,
        MaterialPageRoute(
          builder: (context) => const CaseSelectionScreen(),
        ),
      );
    } else { // Show error message if credentials are incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold widget for the overall screen layout
      appBar: AppBar(title: const Text('Login')), // AppBar widget for the top app bar
      body: Padding( // Padding widget for adding padding around its child
        padding: const EdgeInsets.all(16.0), // Padding on all sides
        child: Column( // Column widget for arranging children in a vertical column
          mainAxisAlignment: MainAxisAlignment.center, // Center main axis of the column
          children: [ // List of children widgets
            TextField( // TextField widget for username input
              controller: _usernameController, // Assigning text controller
              decoration: const InputDecoration(labelText: 'Username'), // Decoration for the input field
            ),
            TextField( // TextField widget for password input
              controller: _passwordController, // Assigning text controller
              decoration: const InputDecoration(labelText: 'Password'), // Decoration for the input field
              obscureText: true, // Hide password text
            ),
            const SizedBox(height: 20), // SizedBox for adding vertical spacing
            ElevatedButton( // ElevatedButton widget for login action
              onPressed: () => _login(context), // Call login method when pressed
              child: const Text('Login'), // Text widget for button label
            ),
          ],
        ),
      ),
    );
  }
}
