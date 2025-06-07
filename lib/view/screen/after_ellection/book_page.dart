import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/book_card.dart';
class Book {
  final String title;
  final String author;
  final String date;
  final String pdfUrl;

  Book({
    required this.title,
    required this.author,
    required this.date,
    required this.pdfUrl,
  });
}

class BookPage extends StatelessWidget {
  BookPage({super.key});

  final List<Book> books = [
    Book(
      title: "الكتاب الأول",
      author: "الكاتب الأول",
      date: "2022-01-01",
      pdfUrl: "https://example.com/book1.pdf",
    ),
    Book(
      title: "الكتاب الثاني",
      author: "الكاتب الثاني",
      date: "2021-06-15",
      pdfUrl: "https://example.com/book2.pdf",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الكتب"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: books.length,
          padding:EdgeInsets.all(10),

          itemBuilder: (context, index) {
            final book = books[index];
            return BookCard(
              title: book.title,
              author: book.author,
              date: book.date,
              pdfUrl: book.pdfUrl,
              onTap: () {
                // يمكن أن تضيف هنا أي تفاصيل عند الضغط على الكتاب
                launchUrl(Uri.parse(book.pdfUrl)); // فتح الرابط مباشرة
              },
            );
          },
        ),
      ),
    );
  }
}
