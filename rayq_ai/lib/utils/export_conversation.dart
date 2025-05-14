import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:rayq/models/query_model.dart';

class ExportConversation {
  static Future<void> downloadConversationAsTextFile(
      BuildContext context, List<QueryModel> conversationHistory) async {
    final text = conversationHistory
        .map((e) => 'User: ${e.userQuery}\nAI: ${e.botResponse}')
        .join('\n\n');

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/rayq_conversation.txt');
    await file.writeAsString(text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Conversation exported as TXT.')),
    );

    OpenFile.open(file.path);
  }

  static Future<void> downloadConversationAsPDF(
      BuildContext context, List<QueryModel> conversationHistory) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Text('rayQ.ai Conversation',
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),
          ...conversationHistory.map(
            (e) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('User: ${e.userQuery}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('AI: ${e.botResponse}'),
                  pw.Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/rayq_conversation.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Conversation exported as PDF.')),
    );

    OpenFile.open(file.path);
  }
}
