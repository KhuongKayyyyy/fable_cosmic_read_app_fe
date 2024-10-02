import "package:fable_cosmic_read_app_fe/widget/book_item.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fable_cosmic_read_app_fe/features/home/bloc/home_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state) {
          case BookFetchingLoadingState _:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case BookFetchingSuccessState _:
            final successState = state as BookFetchingSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Books"),
              ),
              extendBodyBehindAppBar: true,
              body: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: successState.books.length,
                  itemBuilder: (context, index) {
                    final book = successState.books.elementAt(index);
                    return BookItem(book: book);
                  },
                ),
              ),
            );
          case BookFetchingFailureState _:
            return const Center(
              child: Text("Error fetching books"),
            );
          default:
            return const Center(
              child: Text("Nothing to show"),
            );
        }
      },
    );
  }
}
