import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/new_coming_book.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewBookSection extends StatefulWidget {
  final List<Book> books;
  final VoidCallback? onViewAll;
  final Function(Book book)? onTap;

  const NewBookSection(
      {super.key, required this.books, this.onTap, this.onViewAll});

  @override
  _NewBookSectionState createState() => _NewBookSectionState();
}

class _NewBookSectionState extends State<NewBookSection> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Update the current page index when the page changes
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Text(
                "New Coming",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer(),
              TextButton(
                  onPressed: widget.onViewAll,
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.grey[500]),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.books.length,
            itemBuilder: (context, index) {
              final book = widget.books[index];
              final scale = index == _currentPage
                  ? 1.0
                  : 0.7; // Scale for the centered book
              return Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  child: NewComingBook(
                    book: book,
                    onTap: () {
                      if (widget.onTap != null) widget.onTap!(book);
                    },
                  ));
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.books.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
            activeDotColor: Theme.of(context).primaryColor,
            dotColor: Colors.grey[300]!,
          ),
        ),
      ],
    );
  }
}
