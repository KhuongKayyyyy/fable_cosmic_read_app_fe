import 'package:fable_cosmic_read_app_fe/data/model/book_model.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:flutter/material.dart';

class NewComingBook extends StatelessWidget {
  final BookModel book;
  NewComingBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: book.thumbnail != null
              ? NetworkImage(book.thumbnail!)
              : const AssetImage(AppImage.defaultImage) as ImageProvider,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                // Center the text within the container
                child: Text(book.name ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
