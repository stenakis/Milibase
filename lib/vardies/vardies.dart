import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/vardies/generate_vardies.dart';
import 'package:milibase/variables.dart';

import '../main.dart';
import '../templates/info_bar.dart';

class VardiesPage extends StatefulWidget {
  const VardiesPage({super.key});

  @override
  State<VardiesPage> createState() => _VardiesPageState();
}

class _VardiesPageState extends State<VardiesPage> {
  List<List<Sailor>> vardies = [];
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
    if (weeks.isNotEmpty) {
      final DateTime lastWeek = weeks.last;
      setState(() {
        weeks.add(lastWeek.add(const Duration(days: 7)));
      });
    }
  }

  void removeWeek() {
    if (weeks.length > 1) {
      final DateTime lastWeek = weeks.last;
      setState(() {
        weeks.remove(lastWeek);
      });
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      padding: .only(left: padding + 10, right: padding + 10, top: 15),
      content: FutureBuilder<List<Sailor>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: ProgressRing());
          }
          if (snapshot.hasError) {
            showCustomInfoBar(
              context: context,
              text: snapshot.error.toString(),
            );
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      'Βάρδιες',
                      style: FluentTheme.of(context).typography.title,
                    ),
                    Spacer(),
                    FilledButton(
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(FluentIcons.add),
                          const Gap(5),
                          Text('Δημιουργία βάρδιας'),
                        ],
                      ),
                      onPressed: () => setState(() {
                        vardies = generateVardies(snapshot.data!);
                      }),

                      //showNdDialog(context),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Button(
                          onPressed: generateNextWeek,
                          child: const Text("Generate Next Week"),
                        ),
                        const Gap(10),
                        Button(
                          onPressed: removeWeek,
                          child: const Text("Remove Week"),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(padding),
                Expanded(
                  child: ListView.separated(
                    itemCount: weeks.length + 1,
                    itemBuilder: (context, index) {
                      if (index == weeks.length) return SizedBox.shrink();
                      final DateTime weekStart = weeks[index];
                      final List<DateTime> days = generateWeekDays(weekStart);
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
                            Text(
                              DateFormat('MMMM yyyy', 'el').format(weekStart),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (showMonthHeader) const Gap(10),

                          /// WEEK ROW
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: days.map((date) {
                                final dayIndex = days.indexOf(
                                  date,
                                ); // 0–6 within the week
                                final absoluteIndex =
                                    index * 7 +
                                    dayIndex; // across multiple weeks

                                final isSelected = isSameDay(
                                  date,
                                  selectedDate,
                                );
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() => selectedDate = date);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: isSelected
                                            ? .all(color: secColor, width: 2)
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
                                            color: secColor,
                                            child: Row(
                                              children: [
                                                Text(
                                                  DateFormat(
                                                    'E',
                                                    'el',
                                                  ).format(date).toUpperCase(),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  date.day.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(7),
                                          Padding(
                                            padding: .symmetric(horizontal: 12),
                                            child:
                                                vardies.isNotEmpty &&
                                                    absoluteIndex <
                                                        vardies.length
                                                ? Column(
                                                    spacing: 5,
                                                    crossAxisAlignment: .start,
                                                    children:
                                                        vardies[absoluteIndex]
                                                            .map(
                                                              (sailor) => Text(
                                                                sailor.surname,
                                                              ),
                                                            )
                                                            .toList(),
                                                  )
                                                : Text('Home'),
                                          ),

                                          const Gap(10),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Gap(padding),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
