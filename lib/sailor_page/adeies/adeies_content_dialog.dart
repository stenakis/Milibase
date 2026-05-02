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
    _selectedAdeia = widget.adeia?.type ?? Adeia.kanoniki;
    _startDate = widget.adeia?.dateStart ?? DateTime.now();
    _endDate = widget.adeia?.dateEnd ?? DateTime.now();
    _simaController = TextEditingController(text: widget.adeia?.sima ?? '');
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
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Text(
              _isEditing ? 'Επεξεργασία Άδειας' : 'Νέα Άδεια',
              maxLines: 2,
              overflow: .ellipsis,
            ),
          ),
          const Gap(10),
          IconButton(
            icon: const WindowsIcon(WindowsIcons.chrome_close),
            onPressed: _isLoading ? null : () => Navigator.pop(context),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
                    (e) => ComboBoxItem<Adeia>(value: e, child: Text(e.label)),
                  )
                  .toList(),
            ),
          ),
          const Gap(padding),
          if (_needsSima)
            Form(
              key: _formKey,
              child: InfoLabel(
                label: 'Σήμα',
                child: TextFormBox(
                  controller: _simaController,
                  placeholder: 'Εισαγωγή σήματος',
                  validator: (text) => (text == null || text.trim().isEmpty)
                      ? 'Παρακαλώ συμπληρώστε το σήμα'
                      : null,
                ),
              ),
            ),
          if (_needsSima) const Gap(padding),
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
                    _startDate = data.selectedDates.first;
                    if (!_isEditing && _startDate.isAfter(_endDate)) {
                      _endDate = _startDate;
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
                    _endDate = data.selectedDates.first;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        _isLoading
            ? const Row(
                children: [ProgressRing(), Gap(10), Text('Αποθήκευση Άδειας')],
              )
            : Row(
                mainAxisAlignment: .end,
                children: [
                  if (widget.adeia != null)
                    Button(
                      onPressed: () async {
                        try {
                          await deleteAdeia(widget.adeia!);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (error) {
                          if (context.mounted) {
                            showCustomInfoBar(
                              context: context,
                              text: error.toString(),
                            );
                          }
                        }
                      },
                      child: Row(
                        children: [
                          WindowsIcon(WindowsIcons.delete),
                          Gap(5),
                          const Text('Διαγραφή'),
                        ],
                      ),
                    ),
                  if (widget.adeia != null) Gap(10),
                  FilledButton(
                    autofocus: true,
                    onPressed: _submit,
                    child: Row(
                      children: [
                        WindowsIcon(WindowsIcons.save),
                        Gap(5),
                        Text(widget.adeia == null ? 'Εισαγωγή' : 'Αποθήκευση'),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      final adeia = Adeies(
        id: widget.adeia?.id ?? Uuid().v4(),
        type: _selectedAdeia,
        dateStart: _startDate,
        dateEnd: _endDate,
        sailorId: widget.sailor.id,
        sima: _needsSima ? _simaController.text.trim() : null,
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
