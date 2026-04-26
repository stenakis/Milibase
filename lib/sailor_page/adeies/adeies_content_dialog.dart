import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/adeies/adeies_functions.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';
import 'package:uuid/uuid.dart';

class ShowAdeiesDialog extends StatefulWidget {
  const ShowAdeiesDialog({super.key, required this.sailor, this.adeia});
  final Sailor sailor;
  final Adeies? adeia;

  @override
  State<ShowAdeiesDialog> createState() => _ShowAdeiesDialogState();
}

class _ShowAdeiesDialogState extends State<ShowAdeiesDialog> {
  static const _uuid = Uuid(); // static — no need to instantiate per call
  static final _dateFormat = DateFormat('dd/MM/yy', 'el');

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  late DateTime _startDate;
  late DateTime _endDate;
  late Adeia _selectedAdeia;
  late TextEditingController _simaController;

  bool get _isEditing => widget.adeia != null;
  bool get _needsSima =>
      _selectedAdeia == Adeia.oikos_nosileias ||
      _selectedAdeia == Adeia.anarrotiki;

  @override
  void initState() {
    super.initState();
    final adeia = widget.adeia;
    _selectedAdeia = adeia?.type ?? Adeia.kanoniki;
    _startDate = adeia?.dateStart ?? DateTime.now();
    _endDate = adeia?.dateEnd ?? DateTime.now();
    _simaController = TextEditingController(text: adeia?.sima ?? '');
  }

  @override
  void dispose() {
    _simaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              _isEditing ? 'Επεξεργασία Άδειας' : 'Νέα Άδεια',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const Gap(10),
          IconButton(
            icon: const WindowsIcon(WindowsIcons.chrome_close),
            onPressed: _isLoading ? null : () => Navigator.pop(context),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            InfoLabel(
              label: 'Τύπος',
              child: ComboBox<Adeia>(
                isExpanded: true,
                value: _selectedAdeia,
                onChanged: _isLoading
                    ? null
                    : (Adeia? newValue) {
                        setState(() {
                          _selectedAdeia = newValue!;
                          if (!_needsSima) _simaController.clear();
                        });
                      },
                items: Adeia.values
                    .map(
                      (e) =>
                          ComboBoxItem<Adeia>(value: e, child: Text(e.label)),
                    )
                    .toList(),
              ),
            ),
            const Gap(padding),
            if (_needsSima)
              InfoLabel(
                label: 'Σήμα',
                child: TextFormBox(
                  controller: _simaController,
                  placeholder: 'Εισαγωγή σήματος',
                  validator: (text) => (text == null || text.trim().isEmpty)
                      ? 'Παρακαλώ συμπληρώστε το σήμα'
                      : null,
                ),
              ),
            const Gap(10),
            // Date range validator lives here as a hidden FormField
            FormField<void>(
              validator: (_) => _startDate.isAfter(_endDate)
                  ? 'Η ημερομηνία έναρξης πρέπει να είναι πριν την ημερομηνία λήξης.'
                  : null,
              builder: (field) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InfoLabel(
                        label: 'Έναρξη',
                        child: CalendarDatePicker(
                          initialStart: _startDate,
                          isTodayHighlighted: false,
                          locale: const Locale('el'),
                          placeholderText: _dateFormat.format(_startDate),
                          onSelectionChanged: (CalendarSelectionData data) {
                            if (data.selectedDates.isNotEmpty) {
                              setState(() {
                                _startDate = data.selectedDates.first;
                                // Auto-advance end date for new entries
                                if (!_isEditing &&
                                    _startDate.isAfter(_endDate)) {
                                  _endDate = _startDate;
                                }
                              });
                              field.didChange(null); // re-trigger validation
                            }
                          },
                        ),
                      ),
                      const Gap(10),
                      InfoLabel(
                        label: 'Λήξη',
                        child: CalendarDatePicker(
                          initialStart: _endDate,
                          isTodayHighlighted: false,
                          locale: const Locale('el'),
                          placeholderText: _dateFormat.format(_endDate),
                          onSelectionChanged: (CalendarSelectionData data) {
                            if (data.selectedDates.isNotEmpty) {
                              setState(
                                () => _endDate = data.selectedDates.first,
                              );
                              field.didChange(null);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        field.errorText!,
                        style: TextStyle(
                          color: FluentTheme.of(
                            context,
                          ).resources.systemFillColorCritical,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (_isLoading)
          const Row(
            children: [ProgressRing(), Gap(10), Text('Αποθήκευση Άδειας')],
          )
        else
          FilledButton(
            onPressed: _submit,
            child: Text(_isEditing ? 'Αποθήκευση' : 'Εισαγωγή'),
          ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final adeia = Adeies(
        id: widget.adeia?.id ?? _uuid.v4(),
        type: _selectedAdeia,
        dateStart: _startDate,
        dateEnd: _endDate,
        sailorId: widget.sailor.id,
        sima: _needsSima
            ? _simaController.text.trim()
            : null, // null when unused
      );
      await addNewAdeia(adeia);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        showCustomInfoBar(
          context: context,
          text: e.toString(),
          severity: InfoBarSeverity.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
