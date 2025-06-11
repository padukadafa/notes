import 'package:flutter/material.dart';
import 'package:notes/data_sources/objectbox.dart';
import 'package:notes/di.dart';
import 'package:notes/entities/note.dart';
import 'package:notes/pages/note_page.dart';
import 'package:notes/providers/app_provider.dart';
import 'package:notes/widgets/notes_list_item.dart';
import 'package:notes/widgets/notes_search_input_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => NotePage()));
        },
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotesSearchInputWidget(),
            Consumer<AppProvider>(
              builder: (context, value, child) {
                return StreamBuilder<List<Note>>(
                  stream: getIt<ObjectBox>().getAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final notes = snapshot.data!
                          .where(
                            (note) =>
                                note.title?.contains(value.searchQuery) ??
                                false,
                          )
                          .toList();
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
                            return NotesListItemWidget(note: notes[index]);
                          },
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
