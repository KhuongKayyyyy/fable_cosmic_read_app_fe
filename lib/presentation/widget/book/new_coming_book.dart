import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewComingBook extends StatelessWidget {
  final VoidCallback? onTap;
  final Book book;

  const NewComingBook({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 400,
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
            Align(
              alignment: Alignment
                  .bottomCenter, // Aligns the text container at the bottom center
              child: Container(
                width: double
                    .infinity, // Ensure the width fills the entire container
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(
                        10), // Correctly apply the border radius
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                  // Center the text horizontally and vertically
                  child: Text(
                    book.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
