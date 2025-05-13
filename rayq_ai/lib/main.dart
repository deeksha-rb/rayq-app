import 'package:flutter/material.dart';
import 'package:rayq/screens/login_screen.dart';
import 'package:rayq/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/theme.dart';  // Your custom theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('darkMode') ?? false;
  runApp(MyAppRoot(isDarkMode: isDarkMode));
}
 
class MyAppRoot extends StatefulWidget {
  final bool isDarkMode;
  const MyAppRoot({super.key, required this.isDarkMode});

  @override
  State<MyAppRoot> createState() => _MyAppRootState();
}

class _MyAppRootState extends State<MyAppRoot> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  // Toggle theme function
  Future<void> _toggleTheme() async {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically use the light or dark theme
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'rayQ.ai',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? theme.light() : theme.dark(),
      home: LoginScreen(  // Initial screen is SplashScreen
        isDarkMode: isDarkMode,
        toggleTheme: _toggleTheme,  // Pass toggle function to SplashScreen
      ),
    );
  }
}
