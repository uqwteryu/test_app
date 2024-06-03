# CS:GO Case Opening Simulator

## Summary

The **CS:GO Case Opening Simulator** is a Flutter application that allows users to simulate opening cases from the popular game Counter-Strike: Global Offensive (CS:GO). Users can log in, select cases to open, and experience the excitement of obtaining various in-game items with different rarities. The app includes features such as an inventory system to save items, a ranking system based on XP, and customizable settings.

## Features

- **User Authentication**: Log in with a username and password.
- **Case Selection**: Choose from multiple cases to open.
- **Case Opening Animation**: Enjoy an immersive case opening animation.
- **Inventory Management**: Save obtained items to your inventory.
- **XP and Ranking System**: Gain XP and rank up as you open cases.
- **Settings**: Customize app settings such as sound, notifications, and case opening speed.

## Project Structure

```plaintext
lib/
├── assets/
│   ├── counter-strike-file-tracker-main/
│   │   └── static/
│   │       └── csgo_english.json
│   └── CSGO-API-main/
│       ├── public/
│       │   └── services/
│       │       ├── da3cj6j-ebe8e371-cb11-4c4c-9a09-7bb101750342.png
│       │       ├── png-transparent-cs-go-weapon-case-thumbnail.png
│       │       └── unnamed.png
├── main.dart
├── models/
│   ├── case.dart
│   └── user.dart
├── providers/
│   └── user_provider.dart
├── screens/
│   ├── case_opening_screen.dart
│   ├── case_selection_screen.dart
│   ├── inventory_screen.dart
│   ├── login_screen.dart
│   └── settings_screen.dart