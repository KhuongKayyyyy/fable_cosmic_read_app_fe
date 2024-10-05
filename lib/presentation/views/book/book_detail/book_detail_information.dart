import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:flutter/material.dart';

class BookDetailInformation extends StatefulWidget {
  final Book book;
  const BookDetailInformation({super.key, required this.book});

  @override
  _BookDetailInformationState createState() => _BookDetailInformationState();
}

class _BookDetailInformationState extends State<BookDetailInformation> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // rating
          Row(
            children: [
              const Text(
                "Rating",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.yellow, size: 20);
                }),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "4.9/ 5",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: AppTheme.primaryColor,
              )
            ],
          ),
          // status
          Row(
            children: [
              const Text("Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const Spacer(),
              Text(
                widget.book.status!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          // introduction
          const Text("Introduction",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Hàng loạt những vụ giết người kỳ lạ đang xảy ra ở Tokyo, và nhờ chất lỏng bằng chứng tại hiện trường, cảnh sát kết luận thủ phạm chính là 'ghoul'- quỷ ăn thịt người. Kaneki, một sinh viên đại học thích đọc sách bị một con ghoul tấn công, và từ đó, số phận của chàng trai bắt đầu thay đổi...",
                          textAlign: TextAlign.justify,
                          maxLines: _isExpanded ? null : 2,
                          overflow: _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        color: AppTheme.primaryColor,
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        icon: Icon(_isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          // statistics
          Row(
            children: [
              Text("Views",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(widget.book.viewCount.toString()),
            ],
          ),
          Row(
            children: [
              Text("Likes",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(widget.book.likeCount.toString()),
            ],
          ),
          Row(
            children: [
              Text("Follows",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(widget.book.followCount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
