import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/book_item.dart';
import 'package:flutter/material.dart';

class BookByTypeSection extends StatelessWidget {
  final List<Book> books;
  final String sectionType;
  final Function(Book book)? onTap;
  final VoidCallback? onViewAll;
  const BookByTypeSection(
      {super.key,
      required this.books,
      required this.sectionType,
      this.onTap,
      this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                sectionType,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                child: BookItem(
                  book: book,
                  onTap: () {
                    if (onTap != null) onTap!(book);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
    // recommend for you section
  }
}
