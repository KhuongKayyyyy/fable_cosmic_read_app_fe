import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/view_all_book/book_item_large.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewAllBook extends StatefulWidget {
  final String bookListName;
  final List<Book> books;
  const ViewAllBook(
      {super.key, required this.bookListName, required this.books});

  @override
  State<ViewAllBook> createState() => _ViewAllBookState();
}

class _ViewAllBookState extends State<ViewAllBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.bookListName),
      ),
      body: ListView.builder(
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: BookItemLarge(
              book: widget.books.elementAt(index),
              onTap: () {
                context.pushNamed(Routes.bookDetail,
                    extra: widget.books.elementAt(index));
              },
            ),
          );
        },
      ),
    );
  }
}
