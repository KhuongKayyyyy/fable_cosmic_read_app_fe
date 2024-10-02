import 'package:fable_cosmic_read_app_fe/features/home/model/book_model.dart';
import 'package:fable_cosmic_read_app_fe/global/app_image.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                book.thumbnail ?? "",
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    AppImage.defaultImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.name ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(book.author ?? ""),
        ],
      ),
    );
  }
}
