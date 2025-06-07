import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/article_card.dart';

class Article {
  final String title;
  final String author;
  final String description;
  final String date;
  final List<String> tags;
  final String url;

  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.date,
    required this.tags,
    required this.url,
  });
}

class ArticlesAndResearchPage extends StatelessWidget {
   ArticlesAndResearchPage({super.key});

  final List<Article> articles =  [
    Article(
      title: "التحول السياسي والاقتصادي في الشرق الأوسط",
      author: "د. ليلى خالد",
      description: "دراسة تحليلية حول تأثير التحول السياسي على الاقتصاد.",
      date: "2024-11-20",
      tags: ["سياسي", "اقتصادي"],
      url: "https://example.com/article1.pdf",
    ),
    Article(
      title: "البيئة والتغير المناخي في المنطقة العربية",
      author: "أ. فادي عويس",
      description: "بحث في آثار التغير المناخي على دول المنطقة.",
      date: "2023-09-12",
      tags: ["بيئي", "علمي"],
      url: "https://example.com/article2.pdf",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المقالات والأبحاث"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ArticleCard(
              title: article.title,
              author: article.author,
              description: article.description,
              date: article.date,
              tags: article.tags,
              url: article.url,
              onTap: () {
                launchUrl(Uri.parse(article.url));
              },
            );
          },
        ),
      ),
    );
  }
}
