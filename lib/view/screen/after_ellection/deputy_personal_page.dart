/*
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> posts = const [
    {
      'type': 'text',
      'user': 'أحمد',
      'profile': 'assets/images/1.jpg',
      'content': 'نبقى على العهد مع أبناء شعبنا...',
    },
    {
      'type': 'image_text',
      'user': 'منى',
      'profile': 'assets/images/2.jpg',
      'content': 'اليوم شاركنا في جلسة مجلس الشعب...',
      'image': 'assets/images/2.jpg',
    },
    {
      'type': 'carousel',
      'user': 'خالد',
      'profile': 'assets/images/4.jpg',
      'images': [
        'assets/images/1.jpg',
        'assets/images/2.jpg',
        'assets/images/3.jpg'
      ],
    },
    {
      'type': 'video',
      'user': 'علي',
      'profile': 'assets/images/1.jpg',
      'video': 'assets/video/v1.mp4',
      'content': 'فيديو من جلسة المجلس الأخير.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildUserInfoSection()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => PostWidget(post: posts[index]),
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/cover.jpg', fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.3)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          'أحمد النجار',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text('سياسي وناشط مجتمعي'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _StatItem(label: 'المنشورات', count: 24),
            SizedBox(width: 20),
            _StatItem(label: 'الإعجابات', count: 340),
            SizedBox(width: 20),
            _StatItem(label: 'المتابعين', count: 1500),
          ],
        ),
        const Divider(thickness: 1, height: 32),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label),
      ],
    );
  }
}
*/
