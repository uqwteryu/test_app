import 'package:flutter/material.dart'; // Flutter Material package

// Widget for the settings screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key}); // Constructor for the SettingsScreen class

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState(); // Creating state for the SettingsScreen widget
}

// State class for the settings screen
class _SettingsScreenState extends State<SettingsScreen> {
  bool soundEnabled = true; // Variable to store sound enable state
  bool notificationsEnabled = true; // Variable to store notifications enable state
  double caseOpeningSpeed = 10.0; // Variable to store case opening speed

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold widget for the overall screen layout
      appBar: AppBar( // AppBar widget for the top app bar
        title: const Text('Settings'), // Text widget for app bar title
      ),
      body: ListView( // ListView widget for scrolling content
        children: [ // List of children widgets
          SwitchListTile( // SwitchListTile widget for enabling/disabling sound
            title: const Text('Enable Sound'), // Text for the switch tile
            value: soundEnabled, // Current value of sound enable state
            onChanged: (bool value) { // Method called when switch state changes
              setState(() { // Set state to update UI
                soundEnabled = value; // Update sound enable state
              });
            },
          ),
          SwitchListTile( // SwitchListTile widget for enabling/disabling notifications
            title: const Text('Enable Notifications'), // Text for the switch tile
            value: notificationsEnabled, // Current value of notifications enable state
            onChanged: (bool value) { // Method called when switch state changes
              setState(() { // Set state to update UI
                notificationsEnabled = value; // Update notifications enable state
              });
            },
          ),
          ListTile( // ListTile widget for case opening speed slider
            title: const Text('Case Opening Speed'), // Text for the list tile
            subtitle: Slider( // Slider widget for selecting case opening speed
              value: caseOpeningSpeed, // Current value of case opening speed
              min: 1, // Minimum value of the slider
              max: 20, // Maximum value of the slider
              divisions: 19, // Number of divisions between min and max
              label: caseOpeningSpeed.round().toString(), // Label for the current slider value
              onChanged: (double value) { // Method called when slider value changes
                setState(() { // Set state to update UI
                  caseOpeningSpeed = value; // Update case opening speed
                });
              },
            ),
          ),
          ListTile( // ListTile widget for save settings button
            title: ElevatedButton( // ElevatedButton widget for saving settings
              child: const Text('Save Settings'), // Text for the button label
              onPressed: () { // Method called when button is pressed
                ScaffoldMessenger.of(context).showSnackBar( // Show snackbar to indicate settings saved
                  const SnackBar(content: Text('Settings saved!')), // SnackBar widget with message
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
