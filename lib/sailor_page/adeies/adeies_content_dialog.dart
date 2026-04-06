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
  const ShowAdeiesDialog({super.key, required this.sailor, this.id});
  final Sailor sailor;
  final Adeies? id;
  @override
  State<ShowAdeiesDialog> createState() => _ShowAdeiesDialogState();
}

class _ShowAdeiesDialogState extends State<ShowAdeiesDialog> {
  bool isLoading = false;
  final rankKey = GlobalKey<ComboBoxState>(debugLabel: 'Adeies Key');
  final _formKey = GlobalKey<FormState>();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Adeia selectedAdeia = Adeia.kanoniki;
  String statusText = 'Προσθήκη Άδειας';
  late TextEditingController simaController;

  @override
  void initState() {
    simaController = TextEditingController(
      text: selectedAdeia == .oikos_nosileias || selectedAdeia == .anarrotiki
          ? widget.id?.sima ?? ""
          : '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.id == null ? 'Νέα Άδεια' : 'Επεξεργασία Άδειας',
              overflow: .ellipsis,
              maxLines: 1,
            ),
          ),
          Gap(10),
          IconButton(
            icon: WindowsIcon(WindowsIcons.chrome_close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            InfoLabel(
              label: 'Τύπος',
              child: ComboBox<Adeia>(
                isExpanded: true,
                value: selectedAdeia,
                key: rankKey,
                onChanged: (Adeia? newValue) {
                  setState(() {
                    selectedAdeia = newValue!;
                  });
                },
                items: Adeia.values.map((Adeia e) {
                  return ComboBoxItem<Adeia>(value: e, child: Text(e.label));
                }).toList(),
              ),
            ),
            Gap(padding),
            if (selectedAdeia == Adeia.oikos_nosileias ||
                selectedAdeia == Adeia.anarrotiki)
              InfoLabel(
                label: 'Σήμα',
                child: TextFormBox(
                  controller: simaController,
                  placeholder: simaController.text.isEmpty
                      ? 'Εισαγωγή σήματος'
                      : widget.id?.sima ?? 'Εισαγωγή σήματος',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Παρακαλώ συμπληρώστε το σήμα';
                    }
                    return null;
                  },
                ),
              ),
            Gap(10),
            Row(
              children: [
                InfoLabel(
                  label: 'Έναρξη',
                  child: CalendarDatePicker(
                    locale: Locale('el'),
                    placeholderText: DateFormat(
                      'dd/MM/yy',
                      'el',
                    ).format(widget.id?.dateStart ?? selectedStartDate),
                    onSelectionChanged: (CalendarSelectionData data) {
                      if (data.selectedDates.isNotEmpty) {
                        setState(() {
                          selectedStartDate = data.selectedDates.first;
                          selectedEndDate = data.selectedDates.first;
                        });
                      }
                    },
                  ),
                ),
                Gap(10),
                InfoLabel(
                  label: 'Λήξη',
                  child: CalendarDatePicker(
                    locale: Locale('el'),
                    placeholderText: DateFormat(
                      'dd/MM/yy',
                      'el',
                    ).format(widget.id?.dateEnd ?? selectedEndDate),
                    onSelectionChanged: (CalendarSelectionData data) {
                      if (data.selectedDates.isNotEmpty) {
                        setState(() {
                          selectedEndDate = data.selectedDates.first;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        isLoading
            ? Row(children: [ProgressRing(), Gap(10), Text(statusText)])
            : FilledButton(
                child: const Text('Εισαγωγή'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final newAdeia = Adeies(
                        id: widget.id != null ? widget.id!.id : Uuid().v4(),
                        type: selectedAdeia,
                        dateStart: selectedStartDate,
                        dateEnd: selectedEndDate,
                        sailorId: widget.sailor.id,
                        sima: simaController.text,
                      );
                      await addNewAdeia(newAdeia);
                      if (context.mounted && mounted) Navigator.pop(context);
                    } catch (e) {
                      print(e);
                      if (context.mounted && mounted) {
                        showCustomInfoBar(
                          context: context,
                          text: e.toString(),
                          severity: .error,
                        );
                      }
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
              ),
      ],
    );
  }
}
