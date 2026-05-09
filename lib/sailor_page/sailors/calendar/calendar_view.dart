import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/apomakrynseis.dart';
import 'package:milibase/objects/metavoles.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';
import 'flyout_items.dart';

// ── Event model ───────────────────────────────────────────────────────────────

enum CalendarEventType {
  adeia,
  apomakrynsi,
  metavoli,
  arrival,
  insert,
  removal;

  String get label => switch (this) {
    adeia => 'Άδεια',
    apomakrynsi => 'Απομάκρυνση',
    metavoli => 'Μεταβολή',
    arrival => 'Άφιξη',
    insert => 'Κατάταξη',
    removal => 'Απόλυση',
  };

  Color get color => switch (this) {
    adeia => const Color(0xFF0078D4),
    apomakrynsi => const Color(0xFFD13438),
    metavoli => const Color(0xFF107C10),
    arrival => const Color(0xFF8764B8),
    insert => const Color(0xFF8764B8),
    removal => const Color(0xFF8764B8),
  };
}

class CalendarEvent {
  const CalendarEvent({
    required this.date,
    required this.type,
    required this.label,
  });
  final DateTime date;
  final CalendarEventType type;
  final String label;
}

// ── Widget ────────────────────────────────────────────────────────────────────

class SailorCalendarOverview extends StatefulWidget {
  const SailorCalendarOverview({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorCalendarOverview> createState() => _SailorCalendarOverviewState();
}

class _SailorCalendarOverviewState extends State<SailorCalendarOverview> {
  // Cache today so it's not recomputed per cell per frame
  final DateTime _today = DateTime.now();
  late DateTime _focusedMonth;
  late Stream<List<CalendarEvent>> _stream;

  DateTime get _minMonth =>
      DateTime(widget.sailor.dateInsert.year, widget.sailor.dateInsert.month);

  DateTime get _maxMonth =>
      DateTime(widget.sailor.dateRemoval.year, widget.sailor.dateRemoval.month);

  static const _weekDays = ['Δευ', 'Τρι', 'Τετ', 'Πεμ', 'Παρ', 'Σαβ', 'Κυρ'];
  static String formatDateGreek(DateTime date) {
    const months = [
      'Ιανουάριος',
      'Φεβρουάριος',
      'Μάρτιος',
      'Απρίλιος',
      'Μάιος',
      'Ιούνιος',
      'Ιούλιος',
      'Αύγουστος',
      'Σεπτέμβριος',
      'Οκτώβριος',
      'Νοέμβριος',
      'Δεκέμβριος',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  static const _cellBorderColor = Color(0x14000000); // black @ alpha 20
  late DateTime current;
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    current = DateTime(now.year, now.month);
    // Start on today's month, but clamped to the sailor's service range
    _focusedMonth = current.isBefore(_minMonth)
        ? _minMonth
        : current.isAfter(_maxMonth)
        ? _maxMonth
        : current;
    _stream = _buildStream();
  }

  Stream<List<CalendarEvent>> _buildStream() {
    final id = widget.sailor.id;
    final sailor = widget.sailor;

    final sailorDates = [
      CalendarEvent(
        date: sailor.dateArrival,
        type: CalendarEventType.arrival,
        label: CalendarEventType.arrival.label,
      ),
      CalendarEvent(
        date: sailor.dateInsert,
        type: CalendarEventType.insert,
        label: CalendarEventType.insert.label,
      ),
      CalendarEvent(
        date: sailor.dateRemoval,
        type: CalendarEventType.removal,
        label: CalendarEventType.removal.label,
      ),
    ];

    final adeiesStream =
        (db.select(
          db.tableAdeies,
        )..where((t) => t.sailorId.equals(id))).watch().map((rows) {
          final events = <CalendarEvent>[];
          for (final row in rows) {
            final adeia = Adeies.fromJson(row.toJson());
            DateTime cursor = adeia.dateStart;
            while (!cursor.isAfter(adeia.dateEnd)) {
              events.add(
                CalendarEvent(
                  date: cursor,
                  type: CalendarEventType.adeia,
                  label: adeia.type.label,
                ),
              );
              cursor = cursor.add(const Duration(days: 1));
            }
          }
          return events;
        });

    final apomakStream =
        (db.select(
          db.tableApomakrynseis,
        )..where((t) => t.sailorId.equals(id))).watch().map((rows) {
          final events = <CalendarEvent>[];
          for (final row in rows) {
            final a = Apomakrynseis.fromJson(row.toJson());
            DateTime cursor = a.dateStart;
            while (!cursor.isAfter(a.dateEnd)) {
              events.add(
                CalendarEvent(
                  date: cursor,
                  type: CalendarEventType.apomakrynsi,
                  label: a.type.label,
                ),
              );
              cursor = cursor.add(const Duration(days: 1));
            }
          }
          return events;
        });

    final metavolesStream =
        (db.select(
          db.tableMetavoles,
        )..where((t) => t.sailorId.equals(id))).watch().map(
          (rows) => rows.map((row) {
            final m = Metavoles.fromJson(row.toJson());
            return CalendarEvent(
              date: m.date,
              type: CalendarEventType.metavoli,
              label: m.type.label,
            );
          }).toList(),
        );

    return Rx.combineLatest3(
      adeiesStream,
      apomakStream,
      metavolesStream,
      (a, b, c) => [...a, ...b, ...c, ...sailorDates],
    );
  }

  void _previousMonth() {
    final prev = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    if (!prev.isBefore(_minMonth)) setState(() => _focusedMonth = prev);
  }

  void _nextMonth() {
    final next = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    if (!next.isAfter(_maxMonth)) setState(() => _focusedMonth = next);
  }

  void _goToToday() {
    final now = DateTime.now();
    final current = DateTime(now.year, now.month);
    if (!current.isBefore(_minMonth) && !current.isAfter(_maxMonth)) {
      setState(() => _focusedMonth = current);
    }
  }

  Map<int, List<CalendarEvent>> _eventsByDay(List<CalendarEvent> all) {
    final map = <int, List<CalendarEvent>>{};
    for (final event in all) {
      if (event.date.year == _focusedMonth.year &&
          event.date.month == _focusedMonth.month) {
        map.putIfAbsent(event.date.day, () => []).add(event);
      }
    }
    return map;
  }

  bool _isToday(int day) =>
      _today.year == _focusedMonth.year &&
      _today.month == _focusedMonth.month &&
      _today.day == day;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CalendarEvent>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        }

        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              showCustomInfoBar(
                context: context,
                text: snapshot.error.toString(),
              );
            }
          });
          return const Center(child: Text('Σφάλμα φόρτωσης'));
        }

        final events = snapshot.data ?? [];
        final eventsByDay = _eventsByDay(events);
        final daysInMonth = DateUtils.getDaysInMonth(
          _focusedMonth.year,
          _focusedMonth.month,
        );
        final leadingBlanks =
            DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;
        final rowCount = ((leadingBlanks + daysInMonth) / 7).ceil();

        return Padding(
          padding: const .only(bottom: padding, right: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(padding),
              _buildHeader(context),
              const Gap(padding),
              _buildWeekDayLabels(context),
              const Gap(8),
              // LayoutBuilder so cell height is based on actual available space
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cellHeight = constraints.maxHeight / rowCount;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisExtent: cellHeight,
                      ),
                      itemCount: rowCount * 7,
                      itemBuilder: (context, index) {
                        final day = index - leadingBlanks + 1;
                        if (day < 1 || day > daysInMonth) {
                          return const SizedBox.shrink();
                        }
                        return DayCell(
                          sailor: widget.sailor,
                          date: DateTime(current.year, current.month, day),
                          isToday: _isToday(day),
                          events: eventsByDay[day] ?? [],
                          cellHeight: cellHeight,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          formatDateGreek(_focusedMonth),
          style: FluentTheme.of(context).typography.title,
        ),
        const Spacer(),
        IconButton(
          icon: const WindowsIcon(WindowsIcons.chevron_left),
          onPressed: _previousMonth,
        ),
        const Gap(4),
        Button(onPressed: _goToToday, child: const Text('Σήμερα')),
        const Gap(4),
        IconButton(
          icon: const WindowsIcon(WindowsIcons.chevron_right),
          onPressed: _nextMonth,
        ),
      ],
    );
  }

  Widget _buildWeekDayLabels(BuildContext context) {
    final color = FluentTheme.of(context).resources.textFillColorSecondary;
    return Row(
      children: _weekDays
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ── Day cell ──────────────────────────────────────────────────────────────────

class DayCell extends StatefulWidget {
  const DayCell({
    super.key,
    required this.date,
    required this.isToday,
    required this.events,
    required this.cellHeight,
    required this.sailor,
  });

  final DateTime date;
  final bool isToday;
  final List<CalendarEvent> events;
  final double cellHeight;
  final Sailor sailor;
  @override
  State<DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<DayCell> {
  final menuController = FlyoutController();
  @override
  Widget build(BuildContext context) {
    return FlyoutTarget(
      controller: menuController,

      child: GestureDetector(
        onSecondaryTap: () {
          menuController.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.topCenter,
            ),
            barrierDismissible: true,
            dismissOnPointerMoveAway: false,
            dismissWithEsc: true,
            builder: (context) {
              return MenuFlyoutWidget(dayCell: widget);
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(5)),
            border: .all(color: _SailorCalendarOverviewState._cellBorderColor),
            color: Colors.white,
          ),

          child: Column(
            children: [
              // Day number badge
              Container(
                height: 22,
                decoration: widget.isToday
                    ? BoxDecoration(
                        color: secColor,
                        shape: .rectangle,
                        borderRadius: const .only(
                          topLeft: .circular(5),
                          topRight: .circular(5),
                        ),
                      )
                    : null,
                child: Center(child: Text('${widget.date.day}')),
              ),
              // Chips
              const Gap(5),
              Expanded(
                child: ListView(
                  padding: const .only(left: 5, right: 5, bottom: 2),
                  children: widget.events
                      .map((e) => _EventChip(event: e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Event chip ────────────────────────────────────────────────────────────────

class _EventChip extends StatelessWidget {
  const _EventChip({required this.event});
  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: event.type.color.withAlpha(38),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: event.type.color.withAlpha(77)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              event.label,
              style: TextStyle(
                fontSize: 13,
                color: event.type.color,
                fontWeight: FontWeight.w500,
              ),
              overflow: .fade,
              softWrap: false,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
