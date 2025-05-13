import 'package:flutter/material.dart';

class ExportDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Export Conversation", style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text("Choose an option to export your conversation."),
      actions: [
        TextButton(
          onPressed: () {
            // Implement PDF export functionality
            Navigator.pop(context);
          },
          child: Text("Export as PDF"),
        ),
        TextButton(
          onPressed: () {
            // Implement text file export functionality
            Navigator.pop(context);
          },
          child: Text("Export as TXT"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
  }
}