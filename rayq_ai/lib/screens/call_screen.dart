import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:rayq/services/tts_service.dart';
import 'package:rayq/screens/chat_screen.dart';

class CallScreen extends StatefulWidget {
  final bool isDarkMode;
  const CallScreen({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late stt.SpeechToText _speech;
  bool isListening = false;
  bool isCallActive = false;
  String recognizedWords = '';
  Duration callDuration = Duration.zero;
  Timer? timer;

  final TTSService _ttsService = TTSService();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initialize();
  }

  void _initialize() async {
    await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' && isCallActive) {
          Future.delayed(Duration(seconds: 1), () {
            if (mounted && isCallActive) _startListening();
          });
        }
      },
      onError: (error) {
        debugPrint('Speech error: $error');
      },
    );
  }

  void _startCall() {
    setState(() {
      isCallActive = true;
      callDuration = Duration.zero;
    });
    _startTimer();
    _startListening();
  }

  void _endCall() {
    setState(() {
      isCallActive = false;
      isListening = false;
    });
    timer?.cancel();
    _speech.stop();
    _ttsService.stop();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => callDuration += Duration(seconds: 1));
    });
  }

  void _startListening() async {
    if (!_speech.isListening && isCallActive) {
      await _speech.listen(
        onResult: _onSpeechResult,
        listenMode: stt.ListenMode.dictation,
        pauseFor: Duration(seconds: 30),
        partialResults: true,
      );
      setState(() => isListening = true);
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => isListening = false);
  }

  void _onSpeechResult(result) {
    recognizedWords = result.recognizedWords;
    if (result.finalResult && recognizedWords.trim().isNotEmpty) {
      _handleUserSpeech(recognizedWords.trim());
    }
  }

  void _handleUserSpeech(String userInput) async {
    _stopListening();
    final response = "$userInput"; // Replace with actual RAG call
    _ttsService.speak(response);

    _ttsService.setCompletionHandler(() {
      if (isCallActive) _startListening();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isCallActive) ...[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/app_logo.png'),
              ),
              SizedBox(height: 80),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  textStyle: TextStyle(color: textColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: theme.colorScheme.primary),
                ),
                icon: Icon(Icons.phone),
                label: Text('Start Call'),
                onPressed: _startCall,
              ),
            ],
            if (isCallActive) ...[
              Text(
                'rayQ - your AI Assistant',
                style: TextStyle(fontSize: 28, color: textColor),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/app_logo.png'),
              ),
              SizedBox(height: 100),
              Text(
                isListening ? 'Listening...' : 'Speaking...',
                style: TextStyle(fontSize: 18, color: textColor),
              ),
              SizedBox(height: 10),
              Text(
                _formatDuration(callDuration),
                style: TextStyle(fontSize: 24, color: textColor),
              ),
              SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.message, color: textColor, size: 32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ChatScreen(isDarkMode: widget.isDarkMode),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: _endCall,
                    icon: Icon(Icons.call_end, color: Colors.white),
                    label: Text(
                      'End Call',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
