import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:flutter/material.dart';

class BookItemLarge extends StatefulWidget {
  final Book book;
  final VoidCallback? onTap;
  const BookItemLarge({super.key, required this.book, this.onTap});

  @override
  _BookItemLargeState createState() => _BookItemLargeState();
}

class _BookItemLargeState extends State<BookItemLarge> {
  List<Genre>? _genres;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    // Fetch genres asynchronously and update the state
    List<Genre>? genres = await BookRepo.fetchGenre(widget.book.id!);
    setState(() {
      _genres = genres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align items at the top
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.book.thumbnail ?? "",
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.name ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      widget.book.author ?? "",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.book.status),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        widget.book.status ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Show a loading indicator while genres are being fetched
                    _genres == null
                        ? const CircularProgressIndicator() // or a placeholder text
                        : SizedBox(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _genres!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    _genres![index]
                                        .name, // Genre name from the fetched list
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Hoàn Thành':
        return const Color.fromARGB(255, 138, 236, 141); // Completed (green)
      case 'Đang Cập Nhật':
        return const Color.fromARGB(255, 251, 232, 55); // Updating (yellow)
      case 'Tạm Ngưng':
        return Colors.red; // Paused (red)
      default:
        return Colors.grey[200]!; // Default color for unknown statuses
    }
  }
}
