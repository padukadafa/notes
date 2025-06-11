import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/pages/note_page.dart';

class NotesListItemWidget extends StatelessWidget {
  final Note note;
  const NotesListItemWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Color(note.colorCode),

        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => NotePage(note: note)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title ?? "Untitled",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                Builder(
                  builder: (context) {
                    final content = ParchmentDocument.fromJson(
                      json.decode(note.content ?? "[]"),
                    ).toPlainText().replaceAll("\n", "");
                    return Text(
                      content.isNotEmpty ? content : "No content",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    );
                  },
                ),

                SizedBox(height: 18),
                Text(
                  DateFormat("MMM dd,yyyy HH:mm").format(note.updatedAt),
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
