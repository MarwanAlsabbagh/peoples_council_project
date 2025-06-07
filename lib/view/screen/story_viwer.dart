import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../models/deputy_model/story_model.dart';


class StoryViewer extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;

  const StoryViewer({
    Key? key,
    required this.stories,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final StoryController storyController = StoryController();
  late int currentUserIndex;
  late List<StoryItem> currentStoryItems;
  int currentMediaIndex = 0;

  @override
  void initState() {
    super.initState();
    currentUserIndex = widget.initialIndex;
    currentStoryItems = _buildStoryItems(widget.stories[currentUserIndex]);
  }

  List<StoryItem> _buildStoryItems(StoryModel story) {
    return story.mediaList.map((media) {
      if (media.type == 'image') {
        return StoryItem.pageImage(
          url: media.url,
          controller: storyController,
          imageFit: BoxFit.cover,
          duration: const Duration(seconds: 5),
        );
      } else {
        return StoryItem.pageVideo(
          media.url,
          controller: storyController,
          imageFit: BoxFit.cover,
          duration: const Duration(seconds: 10),
        );
      }
    }).toList();
  }

  void _goToNextUserStory() {
    if (currentUserIndex < widget.stories.length - 1) {
      setState(() {
        currentUserIndex++;
        currentMediaIndex = 0;
        currentStoryItems = _buildStoryItems(widget.stories[currentUserIndex]);
      });
    } else {
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = widget.stories[currentUserIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              final width = MediaQuery.of(context).size.width;
              if (details.globalPosition.dx < width / 3) {
                storyController.previous();
              } else if (details.globalPosition.dx > 2 * width / 3) {
                storyController.next();
              }
            },
            child: StoryView(
              storyItems: currentStoryItems,
              controller: storyController,
              onComplete: _goToNextUserStory,
              onStoryShow: (storyItem, index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      currentMediaIndex = index;
                    });
                  }
                });
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) Navigator.pop(context);
              },
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(currentStoryItems.length, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index < currentMediaIndex
                              ? Colors.white
                              : index == currentMediaIndex
                              ? Colors.white.withOpacity(0.9)
                              : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(currentStory.image),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      currentStory.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("أعجبك")),
                    );
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.thumb_down, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("لم يعجبك")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
