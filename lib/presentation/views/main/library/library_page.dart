import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/library/components/favorite_book_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    super.initState();
    authenticationBloc = AuthenticationBloc();
    authenticationBloc.add(AuthenticatioGetUserRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            setState(() {
              authenticationBloc.add(AuthenticatioGetUserRequested());
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              CupertinoIcons.arrow_clockwise,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              authenticationBloc.add(AuthenticationLogoutRequested());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.logout,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, authenState) {
          if (authenState is AuthenticationLogoutSuccess) {
            context.go(Routes.authentication);
            EasyLoading.showSuccess("Logout success");
          } else if (authenState is AuthenticationLogoutFailure) {
            EasyLoading.showError(authenState.message);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInformation(),
              _buildStatistic(),
              const FavoriteBookSection(),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformation() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      builder: (context, userState) {
        if (userState is AuthenticationGetUserSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png"),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userState.user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userState.user.email,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        } else if (userState is AuthenticationGetUserFailure) {
          return const Center(
            child: Text("User not found"),
          );
        } else if (userState is AuthenticationLoading) {
          return Center(
            child: Skeletonizer(
              enabled: true,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "https://images.vexels.com/content/145908/preview/male-avatar-maker-2a7919.png"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Khuong",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "zzkhngzz@gmail.com",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Text("Error");
      },
    );
  }

  Container _buildStatistic() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              children: [
                const Text("14",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text("Reading",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.8),
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.secondaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              children: [
                const Text("14",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Text("Reading",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.8),
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.inkGreyLight,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              children: [
                const Text("14",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Text("Reading",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.8),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
