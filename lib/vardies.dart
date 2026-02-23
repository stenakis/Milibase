import 'package:fluent_ui/fluent_ui.dart' hide CalendarView;
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VardiesPage extends StatefulWidget {
  const VardiesPage({super.key});

  @override
  State<VardiesPage> createState() => _VardiesPageState();
}

class _VardiesPageState extends State<VardiesPage> {
  late Future<List<Sailor>> _future;
  @override
  void initState() {
    _future = Supabase.instance.client
        .from('Sailors')
        .select()
        .then((data) => data.map((json) => Sailor.fromJson(json)).toList());
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
      weeks.add(lastWeek.add(const Duration(days: 7)));
    });
  }

  String dayName(int weekday) {
    const names = ["ΔΕΥ", "ΤΡΙ", "ΤΕΤ", "ΠΕΜ", "ΠΑΡ", "ΣΑΒ", "ΚΥΡ"];
    return names[weekday - 1];
  }

  String monthTitle(DateTime date) {
    const months = [
      "Ιανουάριος",
      "Φεβρουάριος",
      "Μάρτιος",
      "Απρίλιος",
      "Μάιος",
      "Ιούνιος",
      "Ιούλιος",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${months[date.month - 1]} ${date.year}";
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
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
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Button(
                      onPressed: generateNextWeek,
                      child: const Text("Generate Next Week"),
                    ),
                  );
                }
                final weekStart = weeks[index];
                final days = generateWeekDays(weekStart);

                /// Check if we need to show month header
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// MONTH HEADER
                    if (showMonthHeader)
                      Padding(
                        padding: .symmetric(vertical: padding),
                        child: Text(
                          monthTitle(weekStart),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? .all(color: secColor, width: 3)
                                    : null,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: .symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    width: double.infinity,
                                    color: secColor,
                                    child: Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        Text(dayName(date.weekday)),
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
                                  Gap(10),
                                  ...sailors.map((sailor) => Text(sailor.name)),
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
