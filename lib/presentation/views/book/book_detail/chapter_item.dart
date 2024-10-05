import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChapterItem extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback? onTap;
  const ChapterItem({super.key, required this.chapter, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                chapter.pages.elementAt(3) ?? "",
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
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(chapter.title),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "·",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    formatDate(chapter.updatedAt.toString()),
                    style: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Text(
                "Tôi không có dữ liệu tên chapter",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.file_download_outlined,
                color: AppTheme.primaryColor,
              ))
        ],
      ),
    );
  }

  String formatDate(String isoDateString) {
    // Parse the ISO string to a DateTime object
    DateTime parsedDate = DateTime.parse(isoDateString);

    // Format the DateTime to "MMM dd, yyyy" (e.g., "Oct 05, 2024")
    String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);

    return formattedDate;
  }
}
