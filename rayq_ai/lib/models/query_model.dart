import 'dart:convert';

class QueryModel {
  final String id;
  final String userQuery;
  final String botResponse;
  final DateTime timestamp;

  QueryModel({
    required this.id,
    required this.userQuery,
    required this.botResponse,
    required this.timestamp,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userQuery': userQuery,
      'botResponse': botResponse,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Convert from JSON
  factory QueryModel.fromJson(Map<String, dynamic> json) {
    return QueryModel(
      id: json['id'],
      userQuery: json['userQuery'],
      botResponse: json['botResponse'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  // Format timestamp for display
  String get formattedTime {
    return "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
  }
}
