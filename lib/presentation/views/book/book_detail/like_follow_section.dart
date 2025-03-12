import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:flutter/material.dart';

class LikeFollowSection extends StatefulWidget {
  final Function onLikeTap;
  final Book book;
  final bool isLiked;
  const LikeFollowSection(
      {super.key,
      required this.book,
      required this.isLiked,
      required this.onLikeTap});

  @override
  State<LikeFollowSection> createState() => _LikeFollowSectionState();
}

class _LikeFollowSectionState extends State<LikeFollowSection> {
  get onst => null;

  void _onLikeTap() {
    widget.onLikeTap();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Text("Follows",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Spacer(),
                  Text(
                    widget.book.followCount.toString(),
                    style: TextStyle(
                        fontWeight: (FontWeight.w600),
                        color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("|",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Colors.grey,
                  )),
            ),
            Expanded(
              child: Row(
                children: [
                  const Text("Likes",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Spacer(),
                  Text(
                    widget.book.likeCount.toString(),
                    style: TextStyle(
                        fontWeight: (FontWeight.w600),
                        color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Follow",
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.follow_the_signs_outlined),
                        color: AppTheme.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _onLikeTap();
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.isLiked ? "Liked" : "Like",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: widget.isLiked
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border_sharp),
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
