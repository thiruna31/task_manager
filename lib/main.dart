import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: TaskListScreen(
        onToggleTheme: () => setState(() => darkMode = !darkMode),
      ),
    );
  }
}
