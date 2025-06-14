import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  late String _mp3Path;

  Future<void> init() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) throw Exception('Microphone permission denied');
    await _recorder.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<String> startRecording() async {
    if (!_isRecorderInitialized) await init();

    final tempDir = await getTemporaryDirectory();
    _mp3Path = '${tempDir.path}/temp_record.mp3';

    await _recorder.startRecorder(
      toFile: _mp3Path,
      codec: Codec.mp3, // التسجيل مباشرة بصيغة MP3
    );

    return _mp3Path;
  }

  Future<String> stopRecording() async {
    await _recorder.stopRecorder();
    return _mp3Path;
  }

  void dispose() {
    _recorder.closeRecorder();
  }
}
