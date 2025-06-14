import 'package:flutter/material.dart';
import 'package:final_senior_project/models/deputy_model/post_view_model.dart';
import 'package:final_senior_project/view/screen/deputy_pages/comment_screen.dart';
import 'package:final_senior_project/view/widgets/video_palyer_widget.dart';
import '../../utils/media_utils.dart';

class PostWidget extends StatefulWidget {
  final PostViewModel post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool liked = false;
  bool disliked = false;
  late int likeCount;
  late int dislikeCount;
  late int commentCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.likes;
    dislikeCount = widget.post.dislikes;
    commentCount = widget.post.commentsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildPostContent(),
            const SizedBox(height: 20),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(getFullMediaUrl(widget.post.userImage)),
        radius: 24,
      ),
      title: Text(
        widget.post.userName ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xff2E8F5A),
        ),
      ),
      subtitle: Text(
        widget.post.createdAtFormatted,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: const Icon(Icons.more_vert),
    );
  }

  Widget _buildPostContent() {
    final hasText = widget.post.content != null && widget.post.content!.trim().isNotEmpty;
    final mediaType = widget.post.mediaType;
    final mediaUrl = getFullMediaUrl(widget.post.mediaPath);

    if (hasText && mediaType == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(widget.post.content!, style: const TextStyle(fontSize: 15)),
      );
    }

    if (!hasText && mediaType == 'image') {
      return _buildImage(mediaUrl);
    }

    if (!hasText && mediaType == 'video') {
      return _buildVideo(mediaUrl);
    }

    if (hasText && mediaType == 'image') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(mediaUrl),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.post.content!, style: const TextStyle(fontSize: 15)),
          ),
        ],
      );
    }

    if (hasText && mediaType == 'video') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideo(mediaUrl),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.post.content!, style: const TextStyle(fontSize: 15)),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildImage(String? url) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
      ),
    );
  }

  Widget _buildVideo(String? url) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: VideoPlayerWidget(videoRelativePath: url),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _interactiveIcon("assets/social-network (3).png", likeCount.toString(), onTap: _toggleLike, active: liked),
          _interactiveIcon("assets/hand (1).png", dislikeCount.toString(), onTap: _toggleDislike, active: disliked),
          _interactiveIcon("assets/comment-dots 1.png", "$commentCount", onTap: _navigateToComments),
        ],
      ),
    );
  }

  Widget _interactiveIcon(String path, String text, {VoidCallback? onTap, bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xffE9F5EF) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE4E7EC)),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                active ? const Color(0xff2E8F5A) : Colors.black,
                BlendMode.srcATop,
              ),
              child: Image.asset(path, width: 20, height: 20),
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: active ? const Color(0xff2E8F5A) : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      if (liked) {
        liked = false;
        likeCount--;
      } else {
        liked = true;
        likeCount++;
        if (disliked) {
          disliked = false;
          dislikeCount--;
        }
      }
    });
  }

  void _toggleDislike() {
    setState(() {
      if (disliked) {
        disliked = false;
        dislikeCount--;
      } else {
        disliked = true;
        dislikeCount++;
        if (liked) {
          liked = false;
          likeCount--;
        }
      }
    });
  }

  void _navigateToComments() async {
    final updatedCount = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(postId: widget.post.id),
      ),
    );
    if (updatedCount != null) {
      setState(() {
        commentCount = updatedCount;
      });
    }
  }
}
