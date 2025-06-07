import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;

  Future<void> init() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) throw Exception('Microphone permission denied');
    await _recorder.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<String> startRecording() async {
    if (!_isRecorderInitialized) await init();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/recorded.wav';
    await _recorder.startRecorder(toFile: path, codec: Codec.pcm16WAV);
    return path;
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
  }
}