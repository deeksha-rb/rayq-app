import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayq/widgets/MyAppBar.dart';
import '../screens/call_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/help_screen.dart';
import '../screens/about_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _exportHistory(BuildContext context) async {
    String chatHistory = "Chat History:\nUser: Hello\nBot: Hi there!\n...";

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Export via Email"),
                onTap: () {
                  Share.share("Chat History:\n$chatHistory");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text("Download as Text File"),
                onTap: () async {
                  final directory = await getApplicationDocumentsDirectory();
                  final file = File('${directory.path}/chat_history.txt');
                  await file.writeAsString(chatHistory);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Chat history saved in ${file.path}"),
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.surface;
    final foregroundColor = colorScheme.onSurface;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: MyAppBar(
        title: "rayQ.ai",
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: backgroundColor, // make sure color matches
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15.0),
            child: IconButton(
              icon: Icon(Icons.wb_sunny, color: backgroundColor),
              onPressed: widget.toggleTheme,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15.0),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: backgroundColor),
              onSelected: (value) {
                if (value == 'about') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => AboutScreen(
                            isDarkMode: widget.isDarkMode,
                            toggleTheme: widget.toggleTheme,
                          ),
                    ),
                  );
                } else if (value == 'help') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpScreen()),
                  );
                }
              },
              itemBuilder:
                  (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'about',
                      child: Text('About'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'help',
                      child: Text('Help'),
                    ),
                  ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ), // Adjust top/bottom padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adding the text above the buttons
              Text(
                "Hey, call me rayQ, I'm your assistant!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor,
                ),
                textAlign: TextAlign.center, // Ensures the text is centered
              ),
              const SizedBox(
                height: 50,
              ), // Space between the text and the buttons
              // Row for buttons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center buttons horizontally
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center buttons vertically
                children: [
                  _buildButton(
                    context: context,
                    label: "Call rayQ",
                    icon: Icons.phone,
                    screen: CallScreen(isDarkMode: widget.isDarkMode),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 20), // Space between buttons
                  _buildButton(
                    context: context,
                    label: "Chat with rayQ",
                    icon: Icons.chat_bubble_outline,
                    screen: ChatScreen(isDarkMode: widget.isDarkMode),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 15.0),
        child: FloatingActionButton(
          backgroundColor: colorScheme.primary,
          onPressed: () => _exportHistory(context),
          tooltip: 'Export', // Tooltip that shows on hover or long press
          child: Icon(Icons.save, color: colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Widget screen,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return SizedBox(
      height: 80,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}
