import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
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
      content: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Text('Βάρδιες', style: FluentTheme.of(context).typography.title),
              Spacer(),
              FilledButton(
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(FluentIcons.add),
                    Gap(5),
                    Text('Προσθήκη Ν/Δ'),
                  ],
                ),
                onPressed: () {},
                //showNdDialog(context),
              ),
              Gap(10),
              Row(
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
              ),

              /* SizedBox(
                            width: 200,
                            child: TextBox(
                              controller: searchController,
                              prefix: Padding(
                                padding: .only(left: 10),
                                child: WindowsIcon(WindowsIcons.search),
                              ),
                              placeholder: 'Αναζήτηση Ν/Δ',
                              onChanged: (String text) {
                                _searchSailors(text);
                              },
                            ),
                          ),
                          if (searchController.text.isNotEmpty)
                            IconButton(
                              onPressed: () => setState(() {
                                searchController.clear();
                                _displayedSailors = _allSailors;
                              }),
                              icon: WindowsIcon(WindowsIcons.clear),
                            ),*/
            ],
          ),
          Gap(padding),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: ProgressRing());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: weeks.length + 1,
                    itemBuilder: (context, index) {
                      if (index == weeks.length) return SizedBox.shrink();
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
                            Text(
                              DateFormat('MMMM yyyy', 'el').format(weekStart),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          /*Button(
                            onPressed: () => setState(() {
                              vardies = createVardies(sailors);
                            }),
                            child: Text('Δημιουργία βάρδιας'),
                          ),*/

                          /// WEEK ROW
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: days.map((date) {
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
                                                          (sailor) => Text(
                                                            sailor.surname,
                                                          ),
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
          ),
        ],
      ),
    );
  }
}
