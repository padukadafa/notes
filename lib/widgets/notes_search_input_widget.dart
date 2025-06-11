import 'package:flutter/material.dart';

class NotesSearchInputWidget extends StatelessWidget {
  const NotesSearchInputWidget({super.key});

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
