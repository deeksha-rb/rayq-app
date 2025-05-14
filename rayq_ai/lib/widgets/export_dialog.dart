import 'package:flutter/material.dart';
import 'package:rayq/models/query_model.dart';
import 'package:rayq/utils/export_conversation.dart';

class ExportDialog extends StatelessWidget {
  final List<QueryModel> conversationHistory;

  const ExportDialog({Key? key, required this.conversationHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Export Conversation", style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text("Choose an option to export your conversation."),
      actions: [
        TextButton(
          onPressed: () async {
            await ExportConversation.downloadConversationAsPDF(context, conversationHistory);
            Navigator.pop(context);
          },
          child: Text("Export as PDF"),
        ),
        TextButton(
          onPressed: () async {
            await ExportConversation.downloadConversationAsTextFile(context, conversationHistory);
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
