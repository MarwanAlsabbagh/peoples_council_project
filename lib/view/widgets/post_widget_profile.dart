import 'package:easy_localization/easy_localization.dart';
import 'package:final_senior_project/view/widgets/video_palyer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/deputy_model/profile_post_model.dart';
import '../../utils/media_utils.dart';

class PostWidgetProfile extends StatefulWidget {
  final ProfilePostModel post;

  const PostWidgetProfile({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetProfileState createState() => _PostWidgetProfileState();
}

class _PostWidgetProfileState extends State<PostWidgetProfile> {
  bool liked = false;
  bool disliked = false;
  late int likeCount;
  late int dislikeCount;
  late int commentCount;
  late String userName;
  late String userImage;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.likesCount;
    dislikeCount = widget.post.dislikesCount;
    commentCount = widget.post.comments.length;

    final box = GetStorage();
    final userData = box.read('user');
    userName = userData['name'];
    userImage = userData['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            const SizedBox(height: 12),
            _buildPostContent(),
            const SizedBox(height: 20),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(getFullMediaUrl(userImage)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.post.createdAt != null
                  ? DateFormat('yyyy-MM-dd').format(widget.post.createdAt!)
                  : '',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPostContent() {
    final hasText = widget.post.content != null && widget.post.content!.trim().isNotEmpty;
    final mediaType = widget.post.mediaType;
    final mediaUrl = getFullMediaUrl(widget.post.mediaUrl);

    if (hasText && mediaType == null) {
      return Text(widget.post.content!, style: const TextStyle(fontSize: 15));
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
          Text(widget.post.content!, style: const TextStyle(fontSize: 15)),
        ],
      );
    }

    if (hasText && mediaType == 'video') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideo(mediaUrl),
          const SizedBox(height: 8),
          Text(widget.post.content!, style: const TextStyle(fontSize: 15)),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildImage(String? url) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(url, width: double.infinity, fit: BoxFit.cover),
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
    return Row(
      children: [
        _interactiveIcon("assets/social-network (3).png", likeCount.toString(), onTap: _toggleLike, active: liked),
        _interactiveIcon("assets/hand (1).png", dislikeCount.toString(), onTap: _toggleDislike, active: disliked),
        _interactiveIcon("assets/comment-dots 1.png", "$commentCount", onTap: _navigateToComments),
      ],
    );
  }

  Widget _interactiveIcon(String path, String text, {VoidCallback? onTap, bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xffE9F5EF) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE4E7EC)),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(active ? const Color(0xff2E8F5A) : Colors.black, BlendMode.srcATop),
              child: Image.asset(path, width: 20, height: 20),
            ),
            const SizedBox(width: 6),
            Text(text, style: TextStyle(color: active ? const Color(0xff2E8F5A) : Colors.black, fontWeight: FontWeight.w500)),
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

  void _navigateToComments() {
    // افتح شاشة التعليقات هنا حسب تطبيقك
  }
}
