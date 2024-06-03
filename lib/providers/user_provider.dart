import 'package:flutter/foundation.dart'; // Flutter foundation package
import 'package:test_app/models/user.dart'; // Importing the User model
import 'package:test_app/models/case.dart'; // Importing the Case model

class UserProvider with ChangeNotifier {
  User? _user; // Private field to store the current user
  // List of available cases with their details
  final List<Case> cases = [
  Case('Standard Case', [
    {'id': 1, 'name': 'Consumer Grade Item', 'rarity': 'Consumer Grade', 'images': ['']},
    {'id': 2, 'name': 'Industrial Grade', 'rarity': 'Industrial Grade', 'images': ['']},
    {'id': 3, 'name': 'Mil-Spec', 'rarity': 'Mil-Spec', 'images': ['']},
    {'id': 4, 'name': 'Restricted', 'rarity': 'Restricted', 'images': ['']},
    {'id': 5, 'name': 'Classified', 'rarity': 'Classified', 'images': ['']},
    {'id': 6, 'name': 'Covert', 'rarity': 'Covert', 'images': ['']},
    {'id': 7, 'name': 'Extraordinary', 'rarity': 'Extraordinary', 'images': ['']},
    {'id': 8, 'name': 'Contraband', 'rarity': 'Contraband', 'images': ['']},
  ]),
  // Add more cases as needed
];

  User? get user => _user; // Getter for accessing the current user

  // Method to log in the user
  void login(String username, int xp, String rank) {
    _user = User(username, xp, rank); // Create a new user object
    notifyListeners(); // Notify listeners about the change in user data
  }

  // Method to log out the user
  void logout() {
    _user = null; // Set the current user to null
    notifyListeners(); // Notify listeners about the change in user data
  }

  // Method to increase the user's experience points (xp)
  void increaseXp(int amount) {
    if (_user != null) { // Check if the user is logged in
      _user!.xp += amount; // Increase the user's xp by the specified amount
      _user!.rank = getRankFromXp(_user!.xp); // Update the user's rank based on the new xp
      notifyListeners(); // Notify listeners about the change in user data
    }
  }

  // Method to add an item to the user's inventory
  void addToInventory(Map<String, dynamic> item) {
    _user?.inventory.add(item); // Add the item to the user's inventory
    notifyListeners(); // Notify listeners about the change in user data
  }
  
  void removeFromInventory(Map<String, dynamic> item) {
    if (_user != null) {
      _user!.inventory.remove(item);
      notifyListeners();
    }
  }

  // Method to determine the rank based on the user's experience points (xp)
  String getRankFromXp(int xp) {
    if (xp < 100) return 'Unranked';
    if (xp < 200) return 'Silver I';
    if (xp < 300) return 'Silver II';
    if (xp < 400) return 'Silver III';
    if (xp < 500) return 'Silver IV';
    if (xp < 600) return 'Silver Elite';
    if (xp < 700) return 'Silver Elite Master';
    if (xp < 800) return 'Gold Nova I';
    if (xp < 900) return 'Gold Nova II';
    if (xp < 1000) return 'Gold Nova III';
    if (xp < 1100) return 'Gold Nova Master';
    if (xp < 1200) return 'Master Guardian I';
    if (xp < 1300) return 'Master Guardian II';
    if (xp < 1400) return 'Master Guardian Elite';
    if (xp < 1500) return 'Distinguished Master Guardian';
    if (xp < 1600) return 'Legendary Eagle';
    if (xp < 1700) return 'Legendary Eagle Master';
    if (xp < 1800) return 'Supreme Master First Class';
    return 'Global Elite';
  }
}

// A provider class responsible for managing user-related data and operations.
// - `User? _user`: Private field to store the current user.
// - `final List<Case> cases`: List of available cases with their details.
// - `User? get user`: Getter for accessing the current user.
// - `void login(String username, int xp, String rank)`: Method to log in the user with the provided username, xp, and rank.
// - `void logout()`: Method to log out the user.
// - `void increaseXp(int amount)`: Method to increase the user's experience points (xp) by the specified amount.
// - `void addToInventory(Map<String, dynamic> item)`: Method to add an item to the user's inventory.
// - `String getRankFromXp(int xp)`: Method to determine the rank based on the user's experience points (xp).
