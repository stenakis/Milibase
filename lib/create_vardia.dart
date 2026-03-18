import 'dart:math';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

List<List<Sailor>> createVardies(List<Sailor> sailors) {
  List<List<Sailor>> sailorList = List.generate(
    7,
    (_) => List.generate(vardiesCount, (_) => sailors.first),
  );

  for (int i = 0; i < sailorList.length; i++) {
    final random = Random();
    sailorList[i] = List.generate(vardiesCount, (_) {
      return sailors[random.nextInt(sailors.length)];
    });
  }
  return sailorList;
}
