import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';

import 'package:fable_cosmic_read_app_fe/presentation/bloc/book_detail/book_detail_bloc.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/view_all_book/book_item_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BooksByGenre extends StatefulWidget {
  final Genre genre;
  const BooksByGenre({super.key, required this.genre});

  @override
  State<BooksByGenre> createState() => _BooksByGenreState();
}

class _BooksByGenreState extends State<BooksByGenre> {
  BookDetailBloc bookDetailBloc = BookDetailBloc();
  @override
  void initState() {
    super.initState();
    bookDetailBloc.add(GetBookByGenreEvent(widget.genre));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.genre.name,
            style: TextStyle(
                color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<BookDetailBloc, BookDetailState>(
          bloc: bookDetailBloc,
          builder: (context, state) {
            if (state is GetBookByGenreLoadingState) {
              return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return BookItemLarge(
                      book: Book(),
                      onTap: () {
                        context.pushNamed(Routes.bookDetail, extra: Book());
                      },
                    );
                  },
                ),
              );
            } else if (state is GetBookByGenreSuccessState) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: BookItemLarge(
                      book: state.books.elementAt(index),
                      onTap: () {
                        context.pushNamed(Routes.bookDetail,
                            extra: state.books.elementAt(index));
                      },
                    ),
                  );
                },
              );
            } else if (state is GetBookByGenreFailureState) {
              return const Center(
                child: Text("Failed to load books"),
              );
            }
            return const Center(
              child: Text("No event added"),
            );
          },
        ));
  }
}
