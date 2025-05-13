import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayq/widgets/MyAppBar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MyAppBar(
        title: "Help & Support",
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimary, // make sure color matches
        ),
        leading: IconButton( // <-- Just pass 'leading' here, no new field needed
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            _buildSectionTitle("Frequently Asked Questions", textTheme, colorScheme),
            const SizedBox(height: 10),
            _buildFAQItem(
              context,
              "How does rayQ.ai work?",
              "rayQ.ai is an AI-powered assistant that responds to your queries using advanced language models.",
            ),
            _buildFAQItem(
              context,
              "Can I use voice commands?",
              "Yes! You can activate voice input by tapping the mic button.",
            ),
            _buildFAQItem(
              context,
              "How do I report an issue?",
              "You can contact support via email or visit our official website for troubleshooting steps.",
            ),
            const SizedBox(height: 24),
            _buildSectionTitle("Need More Help?", textTheme, colorScheme),
            const SizedBox(height: 10),
            _buildContactOptions(context, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          question,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.email, color: colorScheme.primary),
          title: Text("Contact Support", style: textTheme.bodyLarge),
          subtitle: Text("support@rayqai.com", style: textTheme.bodyMedium),
          onTap: () {
            // Handle email support
          },
        ),
        ListTile(
          leading: Icon(Icons.language, color: colorScheme.primary),
          title: Text("Visit Website", style: textTheme.bodyLarge),
          subtitle: Text("www.rayqai.com", style: textTheme.bodyMedium),
          onTap: () {
            // Handle website navigation
          },
        ),
      ],
    );
  }
}
