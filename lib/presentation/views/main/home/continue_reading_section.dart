import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/continue_reading/continue_reading_bloc.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/continue_read_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContinueReadingSection extends StatefulWidget {
  final Function(Book book)? onTap;
  final VoidCallback? onViewAll;
  const ContinueReadingSection({super.key, this.onTap, this.onViewAll});

  @override
  State<ContinueReadingSection> createState() => _ContinueReadingSectionState();
}

class _ContinueReadingSectionState extends State<ContinueReadingSection> {
  List<ContinueReadChapter> continueReading = [];
  ContinueReadingBloc continueReadingBloc = ContinueReadingBloc();
  @override
  void initState() {
    super.initState();
    continueReadingBloc.add(ContinueReadingRequestedEvent());
  }

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
                  onPressed: () {
                    context.pushNamed(Routes.continueReadingViewAll,
                        extra: continueReading);
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(color: AppTheme.secondaryColor),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<ContinueReadingBloc, ContinueReadingState>(
          bloc: continueReadingBloc,
          builder: (context, crState) {
            if (crState is ContinueReadingLoading) {
              return Skeletonizer(
                child: SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ContinueReadBook(
                            continueReadChapter: ContinueReadChapter(
                                bookId: "1",
                                chapterId: "1",
                                chapterName: "1",
                                bookName: "1",
                                bookAuthor: "1",
                                bookImage: "1")),
                      );
                    },
                  ),
                ),
              );
            } else if (crState is ContinueReadingFailure) {
              return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  child: Center(
                    child: Text(
                      "Start reading to see your continue reading list",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ));
            } else if (crState is ContinueReadingSuccess) {
              continueReading = crState.continueReading;
              if (continueReading.isEmpty) {
                return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Start reading to see your continue reading list",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ));
              }
              return SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crState.continueReading.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ContinueReadBook(
                          continueReadChapter: crState.continueReading[index]),
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
