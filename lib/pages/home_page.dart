import 'package:flutter/material.dart';
import 'package:notes/data_sources/objectbox.dart';
import 'package:notes/di.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/widgets/notes_list_item.dart';
import 'package:notes/widgets/notes_search_input_widget.dart';
import 'package:notes/widgets/reuseable_safe_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReuseableSafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              NotesSearchInputWidget(),
              StreamBuilder<List<Note>>(
                stream: getIt<ObjectBox>().getAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    if (notes.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            "No notes found",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return NotesListItemWidget();
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
