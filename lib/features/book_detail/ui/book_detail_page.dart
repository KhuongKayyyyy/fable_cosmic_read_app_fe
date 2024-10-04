import 'package:fable_cosmic_read_app_fe/features/book_detail/bloc/book_detail_bloc.dart';
import 'package:fable_cosmic_read_app_fe/features/home/model/book_model.dart';
import 'package:fable_cosmic_read_app_fe/global/app_image.dart';
import 'package:fable_cosmic_read_app_fe/mainwrapper.dart';
import 'package:fable_cosmic_read_app_fe/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailPage extends StatefulWidget {
  final BookModel bookModel;
  BookDetailPage({Key? key, required this.bookModel}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookDetailBloc bookDetailBloc = BookDetailBloc();

  @override
  void initState() {
    super.initState();
    bookDetailBloc.add(BookDetailInitialEvent(widget.bookModel.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      bloc: bookDetailBloc,
      listenWhen: (previous, current) => current is BookDetailActionState,
      buildWhen: (previous, current) => current is! BookDetailActionState,
      builder: (context, state) {
        switch (state) {
          case ChapterFetchingLoadingState _:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ChapterFetchingFailureState _:
            return const Center(
              child: Text("Failed to fetch chapters"),
            );
          case ChapterFetchingSuccessState _:
            final successState = state as ChapterFetchingSuccessState;

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    )
                  ],
                ),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.library_add,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.switch_access_shortcut_rounded,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Image.network(
                              widget.bookModel.thumbnail!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppImage.defaultImage,
                                  fit: BoxFit.cover,
                                );
                              },
                            )),
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.bookModel.name!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.bookModel.author!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Chapters",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: successState.chapters.take(10).length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            context.go(Routes.chapterRead,
                                extra: successState.chapters.elementAt(index));
                          },
                          title: Text(
                              successState.chapters.elementAt(index).title),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Nothing to show"),
              ),
            );
        }
      },
    );
  }
}
