import 'dart:math';

import 'package:milibase/objects/sailor.dart';
import 'package:milibase/variables.dart';

List<List<Sailor>> generateVardies(List<Sailor> sailors) {
  List<Sailor> filteredSailors = filterSailors(sailors);

  // Track the last day each sailor was assigned (-daysGap means eligible from start)
  Map<String, int> lastSeen = {
    for (Sailor s in filteredSailors) s.id: -gapDays,
  };

  Random random = Random();
  List<List<Sailor>> result = [];

  for (int day = 0; day < 7; day++) {
    // Only pick sailors who haven't been seen within the last daysGap days
    List<Sailor> eligible =
        filteredSailors.where((s) => day - lastSeen[s.id]! >= gapDays).toList()
          ..shuffle(random);

    // If not enough eligible, fill with least recently used
    if (eligible.length < plithosVardias) {
      List<Sailor> others =
          filteredSailors.where((s) => !eligible.contains(s)).toList()
            ..sort((a, b) => lastSeen[a.id]!.compareTo(lastSeen[b.id]!));
      eligible = [...eligible, ...others];
    }

    List<Sailor> dayList = eligible.take(plithosVardias).toList();

    // Mark these sailors as seen today
    for (var s in dayList) {
      lastSeen[s.id] = day;
    }

    result.add(dayList);
  }

  return result;
}

List<Sailor> filterSailors(List<Sailor> sailors) {
  return sailors.where((sailor) => !sailor.avardiotos).toList();
}
