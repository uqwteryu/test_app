import 'package:flutter/material.dart'; // Flutter Material package
import 'package:provider/provider.dart'; // Provider package for state management
import 'package:test_app/providers/user_provider.dart'; // Importing UserProvider class
import 'package:test_app/screens/login_screen.dart'; // Importing LoginScreen class

void main() {
  runApp(
    ChangeNotifierProvider( // Provider for providing UserProvider to the app
      create: (_) => UserProvider(), // Creating instance of UserProvider
      child: const MyApp(), // MyApp widget as the root of the app
    ),
  );
}

// MyApp widget for the root of the application
class MyApp extends StatefulWidget {
  const MyApp({super.key}); // Constructor for the MyApp class

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState(); // Creating state for the MyApp widget
}

// State class for the MyApp widget
class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.dark); // ValueNotifier for managing theme mode

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>( // Builder for listening to changes in theme mode
      valueListenable: _themeModeNotifier, // ValueNotifier to listen to changes in theme mode
      builder: (context, ThemeMode themeMode, _) { // Builder method to build UI based on theme mode
        return MaterialApp( // MaterialApp widget for the overall app
          title: 'CS:GO Case Opening Simulator', // Title of the app
          theme: ThemeData( // Light theme data
            brightness: Brightness.light, // Light brightness
            primaryColor: Colors.blueGrey, // Primary color
            visualDensity: VisualDensity.adaptivePlatformDensity, // Visual density
          ),
          darkTheme: ThemeData( // Dark theme data
            brightness: Brightness.dark, // Dark brightness
            primaryColor: Colors.blueGrey, // Primary color
            visualDensity: VisualDensity.adaptivePlatformDensity, // Visual density
          ),
          themeMode: themeMode, // Current theme mode
          home: const LoginScreen(), // Initial screen of the app is the login screen
        );
      },
    );
  }
}
