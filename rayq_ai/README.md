# rayq_ai

A new Flutter project.

# Add ons

## android 

### build.gradle.kts 
- ndkVersion = "27.0.12077973"
- minSdk = 24

### AndroidManifest.xml

user permissions: 
- android:name="android.permission.RECORD_AUDIO"
- android:name="android.permission.INTERNET"
- android:name="android.permission.BLUETOOTH"
- android:name="android.permission.BLUETOOTH_ADMIN"
- android:name="android.permission.BLUETOOTH_CONNECT"

## ios

### Info.plist

- NSSpeechRecognitionUsageDescription: Permission required to record audio for Speech recognition
- NSMicrophoneUsageDescription: Permission required to record audio for Speech recognition

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
