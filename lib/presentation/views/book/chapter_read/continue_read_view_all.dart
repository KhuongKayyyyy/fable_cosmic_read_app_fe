import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/data/res/continue_reading_repo.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/continue_reading_big_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContinueReadViewAll extends StatefulWidget {
  final List<ContinueReadChapter> continueReading;
  const ContinueReadViewAll({super.key, required this.continueReading});

  @override
  State<ContinueReadViewAll> createState() => _ContinueReadViewAllState();
}

class _ContinueReadViewAllState extends State<ContinueReadViewAll> {
  void onDelete(int index) async {
    setState(() {
      widget.continueReading.removeAt(index);
    });
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      await ContinueReadingRepo().deleteBookFromContinueReading(
        userId: id,
        token: token,
        chapterId: widget.continueReading[index].chapterId,
      );
    }
  }

  void onClear() async {
    setState(() {
      widget.continueReading.clear();
    });
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      await ContinueReadingRepo().clearContinueReading(
        userId: id,
        token: token,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Continue Reading"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ]),
            child: IconButton(
              onPressed: () {
                _showClearConfirmDialog(context);
              },
              icon: Icon(
                CupertinoIcons.trash,
                color: AppTheme.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.continueReading.length,
        itemBuilder: (context, index) {
          final continueRead = widget.continueReading[index];
          return ContinueReadingBigItem(
            continueReading: continueRead,
            onDelete: () {
              onDelete(index);
            },
          );
        },
      ),
    );
  }

  Future<dynamic> _showClearConfirmDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Clear All"),
        content: const Text(
            "Are you sure you want to clear all continue reading items?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onClear();
              Navigator.of(context).pop();
            },
            child: const Text("Clear"),
          ),
        ],
      ),
    );
  }
}
