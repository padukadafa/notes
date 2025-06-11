import 'package:flutter/material.dart';
import 'package:notes/providers/app_provider.dart';
import 'package:provider/provider.dart';

class NotesSearchInputWidget extends StatelessWidget {
  NotesSearchInputWidget({super.key});
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Icon(
            Icons.search,
            size: 28,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Expanded(
            child: TextField(
              focusNode: focus,
              onTapOutside: (_) => focus.unfocus(),
              onChanged: (value) {
                context.read<AppProvider>().setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search notes...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
