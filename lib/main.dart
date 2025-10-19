class MyApp extends StatefulWidget { ... }
class _MyAppState extends State<MyApp> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: TaskListScreen(onToggleTheme: () => setState(() => darkMode = !darkMode)),
    );
  }
}
