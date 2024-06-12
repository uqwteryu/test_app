import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/user_provider.dart';
import 'package:test_app/screens/login_screen.dart';

void main() async {
  // Run the Python script
  await _runPythonScript();

  // Once the Python script execution is complete, runApp
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

Future<void> _runPythonScript() async {
  try {
    // Replace 'path_to_your_python_script.py' with the actual path to your Python script
    final process = await Process.start('python', ['C:/Users/sapin002/OneDrive - Malta Information Technology Agency/Desktop/code/Github Apps/test_app/lib/backend/test.py']);
    final exitCode = await process.exitCode;
    if (kDebugMode) {
      print('Python script exited with code $exitCode');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error running Python script: $e');
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, ThemeMode themeMode, _) {
        return MaterialApp(
          title: 'CS:GO Case Opening Simulator',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: themeMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
