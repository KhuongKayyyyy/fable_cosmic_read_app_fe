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
    // _homeBloc.add(const HomeEventStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      bloc: homeBloc,
    );
  }
}
