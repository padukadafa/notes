import 'package:flutter/material.dart';

class NotesListItemWidget extends StatelessWidget {
  const NotesListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Something asdasdja sdak asd asd asda sda sd as sdask",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 18),
          Text(
            "May 12,2023",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
