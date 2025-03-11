import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenreSearchItem extends StatelessWidget {
  final String img;
  final Genre genre;
  final Color color;

  const GenreSearchItem({
    super.key,
    required this.img,
    required this.color,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.getBookByGenre, extra: genre);
      },
      child: SizedBox(
        width: 150, // Set width
        height: 350, // Set height
        child: Stack(
          clipBehavior: Clip.none, // Allow elements to overflow
          children: [
            // Background container
            Container(
              width: 150,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
            ),
            // Overlayed image
            Positioned(
              top: -50, // Move it up to stick out
              left: 0,
              right: 0,
              child: SizedBox(
                height: 230,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color.withOpacity(0.1),
                            color.withOpacity(0.5),
                          ],
                        )),
                    child: Center(
                      child: Text(
                        genre.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
