import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controller/after_ellection/chat_controller.dart';
import '../../../service/audio_service.dart';
import '../../widgets/chat_message_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/message_input_widget.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.find();
  final TextEditingController _controller = TextEditingController();
  final AudioService _audioService = AudioService();

  String? _audioPath;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _audioService.init();
  }

  void _handleMicPressed() async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isRecording ? easy.tr('recording_started') : easy.tr('recording_stopped')))
    );

    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        Get.snackbar(easy.tr('permissions'), easy.tr('microphone_permission_required'));
        return;
      }
    }

    if (!_isRecording) {
      _audioPath = await _audioService.startRecording();
      setState(() => _isRecording = true);
    } else {
      _audioPath = await _audioService.stopRecording();
      setState(() => _isRecording = false);

      if (_audioPath != null) {
        controller.sendAudioMessage(File(_audioPath!));
      }
    }
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    return ChatMessageWidget(
                      isMe: msg.isMe,
                      messageText: msg.message,
                      name: msg.senderName,
                      imageUrl: msg.senderImage,
                    );
                  },
                );
              }),
            ),
            MessageInputWidget(
              controller: _controller,
              onSend: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  controller.sendMessage(text);
                  _controller.clear();
                }
              },
              onMicPressed: _handleMicPressed,
            ),
          ],
        ),
      ),
    );
  }
}
