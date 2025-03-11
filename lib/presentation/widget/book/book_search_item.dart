import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookSearchItem extends StatefulWidget {
  final Book book;
  const BookSearchItem({super.key, required this.book});

  @override
  State<BookSearchItem> createState() => _BookSearchItemState();
}

class _BookSearchItemState extends State<BookSearchItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.bookDetail, extra: widget.book);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        height: 130,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.book.thumbnail!,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImage.darkLogo,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "From ${widget.book.author}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text("6.9m views",
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(CupertinoIcons.add, color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
