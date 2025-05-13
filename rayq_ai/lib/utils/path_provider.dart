import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Saves the chat history to a text file in the app's documents directory.
/// Returns the file path or an error message if something goes wrong.
Future<String> saveChatHistory(String chatHistory) async {
  try {
    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path
    final filePath = '${directory.path}/chat_history.txt';

    // Create the file and write data
    final file = File(filePath);
    await file.writeAsString(chatHistory);

    return filePath;
  } catch (e) {
    return "Error saving file: $e";
  }
}
