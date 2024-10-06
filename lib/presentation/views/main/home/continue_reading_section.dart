import 'dart:ffi';

import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/continue_read_book.dart';
import 'package:flutter/material.dart';

class ContinueReadingSection extends StatelessWidget {
  final List<Book> books;
  final Function(Book book)? onTap;
  final VoidCallback? onViewAll;
  const ContinueReadingSection(
      {super.key, required this.books, this.onTap, this.onViewAll});

  @override
  Widget build(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Text(
                "Continue Reading",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer(),
              TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.grey[500]),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ContinueReadBook(book: book),
              );
            },
          ),
        )
      ],
    );
  }
}
