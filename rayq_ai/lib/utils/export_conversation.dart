import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/query_model.dart';

class ExportConversation {
  static String formatConversation(List<QueryModel> conversations) {
    final buffer = StringBuffer();
    for (var convo in conversations) {
      buffer.writeln("User: ${convo.userQuery}");
      buffer.writeln("Bot: ${convo.botResponse}");
      buffer.writeln('---');
    }
    return buffer.toString();
  }

  static Future<void> downloadConversationAsTextFile(
      BuildContext context, List<QueryModel> conversations) async {
    try {
      final text = formatConversation(conversations);
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/rayQ_ai_conversation.txt';
      final file = File(filePath);
      await file.writeAsString(text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File saved at: $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save conversation: $e")),
      );
    }
  }
}
