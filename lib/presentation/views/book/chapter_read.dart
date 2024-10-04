import 'package:fable_cosmic_read_app_fe/data/model/chapter_model.dart';
import 'package:flutter/material.dart';

class ChapterRead extends StatefulWidget {
  final ChapterModel chapterModel;
  ChapterRead({super.key, required this.chapterModel});

  @override
  State<ChapterRead> createState() => _ChapterReadState();
}

class _ChapterReadState extends State<ChapterRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterModel.title),
      ),
      body: Column(
        children: [
          Expanded(
            // Use Expanded here
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // Change ListView to Column
                  children: widget.chapterModel.pages.map((pageUrl) {
                    return Image.network(pageUrl);
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
