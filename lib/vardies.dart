import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/create_vardia.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

import 'main.dart';

class VardiesPage extends StatefulWidget {
  const VardiesPage({super.key});

  @override
  State<VardiesPage> createState() => _VardiesPageState();
}

class _VardiesPageState extends State<VardiesPage> {
  late List<List<Sailor>> vardies = [];
  late Future<List<Sailor>> _future;
  @override
  void initState() {
    _future = db.select(db.tableSailors).get().then((rows) {
      return rows.map((row) => Sailor.fromJson(row.toJson())).toList();
    });
    weeks.add(getStartOfWeek(DateTime.now())); // first week
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  List<DateTime> weeks = [];

  /// Get Monday of a week
  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Generate 7 days from start
  List<DateTime> generateWeekDays(DateTime start) {
    return List.generate(7, (index) => start.add(Duration(days: index)));
  }

  /// Add next week to list
  void generateNextWeek() {
    final lastWeek = weeks.last;

    setState(() {
      if (weeks.isNotEmpty) {
        weeks.add(lastWeek.add(const Duration(days: 7)));
      }
    });
  }

  void removeWeek() {
    final lastWeek = weeks.last;

    setState(() {
      weeks.remove(lastWeek);
    });
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: .all(padding),
      content: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Sailor> sailors = snapshot.data!;
            return ListView.separated(
              padding: .symmetric(horizontal: padding),
              itemCount: weeks.length + 1,
              itemBuilder: (context, index) {
                if (index == weeks.length) {
                  return Row(
                    children: [
                      Button(
                        onPressed: generateNextWeek,
                        child: const Text("Generate Next Week"),
                      ),
                      Gap(10),
                      Button(
                        onPressed: removeWeek,
                        child: const Text("Remove Week"),
                      ),
                    ],
                  );
                }
                final weekStart = weeks[index];
                final days = generateWeekDays(weekStart);

                // Check if we need to show month header
                bool showMonthHeader = false;

                if (index == 0) {
                  showMonthHeader = true;
                } else {
                  final previousWeek = weeks[index - 1];
                  showMonthHeader =
                      previousWeek.month != weekStart.month ||
                      previousWeek.year != weekStart.year;
                }

                return Column(
                  crossAxisAlignment: .start,
                  children: [
                    /// MONTH HEADER
                    if (showMonthHeader)
                      Padding(
                        padding: .symmetric(vertical: padding),
                        child: Text(
                          DateFormat('MMMM yyyy', 'el').format(weekStart),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Button(
                      onPressed: () => setState(() {
                        vardies = createVardies(sailors);
                      }),
                      child: Text('Δημιουργία βάρδιας'),
                    ),
                    Gap(10),

                    /// WEEK ROW
                    Row(
                      children: days.map((date) {
                        final isSelected = isSameDay(date, selectedDate);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedDate = date);
                            },
                            child: Container(
                              margin: .symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? .all(color: secColor, width: 3)
                                    : null,
                              ),
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Container(
                                    padding: .symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    width: double.infinity,
                                    color: secColor,
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat(
                                            'E',
                                            'el',
                                          ).format(date).toUpperCase(),
                                        ),

                                        Gap(5),
                                        Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(7),
                                  Padding(
                                    padding: .symmetric(horizontal: 12),
                                    child: vardies.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment: .start,
                                            children: vardies[index]
                                                .map(
                                                  (sailor) =>
                                                      Text(sailor.surname),
                                                )
                                                .toList(),
                                          )
                                        : Text('Home'),
                                  ),

                                  Gap(10),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Gap(padding),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
