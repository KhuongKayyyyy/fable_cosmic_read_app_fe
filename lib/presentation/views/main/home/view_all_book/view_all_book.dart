import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/view_all_book/book_item_large.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/continue_reading_big_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewAllBook extends StatefulWidget {
  final String bookListName;
  final List<Book>? books;
  final List<ContinueReadChapter>? continueReadingList;
  const ViewAllBook(
      {super.key,
      required this.bookListName,
      this.books,
      this.continueReadingList});

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
      body: widget.books != null
          ? ListView.builder(
              itemCount: widget.books!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: BookItemLarge(
                    book: widget.books![index],
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: widget.continueReadingList!.length,
              itemBuilder: (context, index) {
                return ContinueReadingBigItem(
                  continueReading: widget.continueReadingList![index],
                  onDelete: () {
                    setState(() {
                      widget.continueReadingList!.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
