import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_content_dialog.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/templates/delete_button.dart';
import 'package:milibase/variables.dart';

import '../../main.dart';
import '../../templates/info_bar.dart';

class SailorWidgetAdeies extends StatefulWidget {
  const SailorWidgetAdeies({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorWidgetAdeies> createState() => _SailorWidgetAdeiesState();
}

class _SailorWidgetAdeiesState extends State<SailorWidgetAdeies> {
  static final _dateFormat = DateFormat('EEE dd MMM yy', 'el');
  late Stream<List<Adeies>> _stream;
  Adeia? _selectedAdeia;

  List<Adeies> _applyFilter(List<Adeies> all) {
    final filtered = _selectedAdeia == null
        ? List<Adeies>.from(all)
        : all.where((a) => a.type == _selectedAdeia).toList();
    return filtered..sort((a, b) => a.dateStart.compareTo(b.dateStart));
  }

  int get _daysKanoniki => Adeia.kanonikiDays(widget.sailor.servingMonths);

  @override
  void initState() {
    super.initState();
    _stream =
        (db.select(
          db.tableAdeies,
        )..where((t) => t.sailorId.equals(widget.sailor.id))).watch().map(
          (rows) => rows.map((r) => Adeies.fromJson(r.toJson())).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Adeies>>(
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
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Άγνωστο σφάλμα'));
        }

        final allAdeies = snapshot.data!;
        final displayed = _applyFilter(allAdeies);
        final daysKanoniki = _daysKanoniki;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(padding),
              _buildHeader(context, allAdeies),
              const Gap(padding),
              _buildSummaryChips(allAdeies, daysKanoniki),
              if (allAdeies.isNotEmpty) ...[
                const Gap(padding * 1.5),
                _buildTableHeader(context),
                Expanded(child: _buildTable(displayed)),
              ] else
                const Padding(
                  padding: EdgeInsets.only(top: padding),
                  child: Text('Δεν υπάρχουν καταχωρημένες άδειες.'),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, List<Adeies> allAdeies) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Άδειες', style: FluentTheme.of(context).typography.title),
        const Spacer(),
        FilledButton(
          onPressed: () => _showContentDialog(context, null),
          child: Row(
            children: [
              const Icon(FluentIcons.add),
              const Gap(5),
              const Text('Νέα Άδεια'),
            ],
          ),
        ),
        const Gap(padding),
        if (allAdeies.isNotEmpty) ...[
          ComboBox<Adeia>(
            placeholder: Row(
              children: [
                WindowsIcon(WindowsIcons.filter),
                const Gap(5),
                Text(_selectedAdeia?.label ?? 'Όλες'),
              ],
            ),
            isExpanded: false,
            value: _selectedAdeia,
            onChanged: (adeia) => setState(() => _selectedAdeia = adeia),
            items:
                (Adeia.values.toList()
                      ..sort((a, b) => a.label.compareTo(b.label)))
                    .map(
                      (e) =>
                          ComboBoxItem<Adeia>(value: e, child: Text(e.label)),
                    )
                    .toList(),
          ),
          if (_selectedAdeia != null)
            IconButton(
              onPressed: () => setState(() => _selectedAdeia = null),
              icon: WindowsIcon(WindowsIcons.clear),
            ),
        ],
      ],
    );
  }

  Widget _buildSummaryChips(List<Adeies> allAdeies, int daysKanoniki) {
    final chips = Adeia.values.map((adeiaType) {
      final totalDays = allAdeies
          .where((a) => a.type == adeiaType)
          .fold<int>(
            0,
            (sum, a) => sum + a.dateEnd.difference(a.dateStart).inDays + 1,
          );

      if (totalDays == 0) return const SizedBox.shrink();

      final dayLabel = totalDays == 1 ? 'ημέρα' : 'ημέρες';
      final labelText = adeiaType == Adeia.kanoniki
          ? '${adeiaType.label}: $totalDays/$daysKanoniki ημέρες'
          : '${adeiaType.label}: $totalDays $dayLabel';

      final isOverLimit =
          adeiaType == Adeia.kanoniki && totalDays > daysKanoniki;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isOverLimit ? Colors.orange.withOpacity(0.3) : secColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(labelText),
      );
    }).toList();

    return Wrap(spacing: 5, runSpacing: 5, children: chips);
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
      child: Row(
        spacing: 5,
        children: [
          _headerCell('Τύπος', col1Flex),
          _headerCell('Έναρξη', col2Flex),
          _headerCell('Λήξη', col3Flex),
          _headerCell('Σήμα', col4Flex),
          _headerCell('', col6Flex),
        ],
      ),
    );
  }

  Widget _headerCell(String label, int flex) => Expanded(
    flex: flex,
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTable(List<Adeies> displayed) {
    return ListView.separated(
      itemCount: displayed.length,
      separatorBuilder: (_, __) => const Divider(),
      padding: EdgeInsets.only(bottom: padding),
      itemBuilder: (context, index) {
        final adeia = displayed[index];
        final isLast = index == displayed.length - 1; // ← fixed: was _allAdeies
        final bottomRadius = Radius.circular(isLast ? 5 : 0);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: bottomRadius,
              bottomRight: bottomRadius,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding - 5,
          ),
          child: Row(
            spacing: 5,
            children: [
              Expanded(flex: col1Flex, child: Text(adeia.type.label)),
              Expanded(
                flex: col2Flex,
                child: Text(_dateFormat.format(adeia.dateStart)),
              ),
              Expanded(
                flex: col3Flex,
                child: Text(_dateFormat.format(adeia.dateEnd)),
              ),
              Expanded(flex: col4Flex, child: Text(adeia.sima ?? '')),
              Expanded(
                flex: col6Flex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const WindowsIcon(WindowsIcons.edit),
                      onPressed: () => _showContentDialog(context, adeia),
                    ),
                    const Gap(5),
                    DeleteFlyout(
                      title: 'Διαγραφή άδειας;',
                      onPressed: () => deleteAdeia(adeia.id),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showContentDialog(BuildContext context, Adeies? adeia) {
    showDialog<String>(
      context: context,
      builder: (_) => ShowAdeiesDialog(sailor: widget.sailor, adeia: adeia),
    );
  }
}
