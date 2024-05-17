class User {
  String username; // Username of the user
  int xp; // Experience points of the user
  String rank; // Rank of the user
  List<Map<String, dynamic>> inventory; // Inventory of the user

  User(this.username, this.xp, this.rank) : inventory = []; // Constructor to initialize username, xp, and rank. The inventory is initially empty.
}

// Represents a user with a username, experience points (xp), rank, and inventory.
// - `String username`: Holds the username of the user.
// - `int xp`: Stores the experience points (xp) of the user.
// - `String rank`: Represents the rank of the user.
// - `List<Map<String, dynamic>> inventory`: Contains the inventory items of the user, represented as a list of maps with various properties.
// - `User(this.username, this.xp, this.rank) : inventory = [];`: Constructor to instantiate a user object with a given username, xp, and rank. The inventory is initialized as an empty list.
