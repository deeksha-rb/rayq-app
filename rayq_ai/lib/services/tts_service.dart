import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _flutterTts = FlutterTts();

  void speak(String text) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }

  void setCompletionHandler(Function onComplete) {
    _flutterTts.setCompletionHandler(() => onComplete());
  }

  void stop() async {
    await _flutterTts.stop();
  }
}
