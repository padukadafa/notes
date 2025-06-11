import 'dart:math';
import 'package:notes/colors/note_colors.dart';

int getRandomNoteColor() {
  final random = Random();
  return noteColors[random.nextInt(noteColors.length)].toARGB32();
}
