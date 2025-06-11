import 'dart:async';
import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/data_sources/objectbox.dart';
import 'package:notes/di.dart';
import 'package:notes/entities/note.dart';

class NotePage extends StatefulWidget {
  final Note? note;
  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late FleatherController _controller;
  final titleController = TextEditingController();
  late Note note;
  Timer? _debounce;
  @override
  void initState() {
    if (widget.note != null) {
      note = widget.note!;
      titleController.text = note.title ?? "Untitled Note";
      _controller = FleatherController(
        document: ParchmentDocument.fromJson(
          json.decode(note.content ?? "[]") as List<dynamic>,
        ),
      );
    } else {
      _controller = FleatherController();
      note = Note(id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now());
      titleController.text = '';
    }
    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (_controller.document.toPlainText().isEmpty) {
          return;
        }
        if (note.id == 0) {
          note = note.copyWith(createdAt: DateTime.now());
        }
        if (note.id == 0) {
          note = note.copyWith(id: getIt<ObjectBox>().noteBox.put(note));
        }
        getIt<ObjectBox>().addOrUpdateNote(
          note.copyWith(
            title: titleController.text,
            content: json.encode(_controller.document.toJson()),
            updatedAt: DateTime.now(),
          ),
        );
      });
    });
    titleController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (titleController.text.isEmpty ||
            titleController.text.trim().isEmpty) {
          return;
        }
        if (note.id == 0) {
          note = note.copyWith(createdAt: DateTime.now());
        }
        if (note.id == 0) {
          note = note.copyWith(id: getIt<ObjectBox>().noteBox.put(note));
        }
        getIt<ObjectBox>().addOrUpdateNote(
          note.copyWith(
            title: titleController.text,
            content: json.encode(_controller.document.toJson()),
            updatedAt: DateTime.now(),
          ),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.note != null,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                getIt<ObjectBox>().deleteNote(widget.note!.id);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat("MMM dd,yyyy HH:mm").format(note.updatedAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(child: FleatherEditor(controller: _controller)),
            FleatherToolbar.basic(controller: _controller),
          ],
        ),
      ),
    );
  }
}
