import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayq/widgets/MyAppBar.dart';

class AboutScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const AboutScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(
        title: "About",
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.onPrimary, // make sure color matches
        ),
        leading: IconButton( // <-- Just pass 'leading' here, no new field needed
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "rayQ.ai Assistant",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Version: 1.0.0",
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "rayQ.ai is a cutting-edge AI assistant designed to help users with intelligent conversations and voice interactions. Our goal is to enhance productivity and user experience through advanced AI technology.",
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Developed by: rayQ Team",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
