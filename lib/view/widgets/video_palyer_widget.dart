import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/media_utils.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoRelativePath;
  const VideoPlayerWidget({super.key, required this.videoRelativePath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    final fullVideoUrl =widget.videoRelativePath;

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(fullVideoUrl),
    );
    /*_controller = VideoPlayerController.networkUrl(
      Uri.parse('http://192.168.130.213:8000/storage/videos/mSwcQ2zmN46yu0d66AbpkDc1Te7LCjARqlSCIcbC.mp4'),
    );*/



    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.setVolume(1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 40,
                        color: const Color(0xff2E8F5A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
