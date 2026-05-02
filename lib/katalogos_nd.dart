import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/create_nd.dart';
import 'package:milibase/sailor_page/sailors/sailor_page.dart';
import 'package:milibase/sailor_page/sailors/status/sailor_status_widget.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/templates/info_bar.dart';
import 'package:milibase/variables.dart';

import 'main.dart';

class KatalogosNd extends StatefulWidget {
  const KatalogosNd({super.key});

  @override
  State<KatalogosNd> createState() => _KatalogosNdState();
}

class _KatalogosNdState extends State<KatalogosNd> {
  final _searchController = TextEditingController();
  late Stream<List<Sailor>> _stream;
  String _searchQuery = '';

  Stream<List<Sailor>> _buildStream() {
    return db.select(db.tableSailors).watch().map((rows) {
      final sailors = rows.map((r) => Sailor.fromJson(r.toJson())).toList();
      sailors.sort(
        (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()),
      );
      return sailors;
    });
  }

  // Add this helper anywhere inside _KatalogosNdState
  String _normalize(String s) {
    final normalized = s.toLowerCase().runes.map((r) {
      const map = {
        0x03AC: 0x03B1, // ά → α
        0x03AD: 0x03B5, // έ → ε
        0x03AE: 0x03B7, // ή → η
        0x03AF: 0x03B9, // ί → ι
        0x03CC: 0x03BF, // ό → ο
        0x03CD: 0x03C5, // ύ → υ
        0x03CE: 0x03C9, // ώ → ω
        0x0390: 0x03B9, // ΐ → ι
        0x03B0: 0x03C5, // ΰ → υ
      };
      return map[r] ?? r;
    });
    return String.fromCharCodes(normalized).trim();
  }

  // Replace the existing _filter
  List<Sailor> _filter(List<Sailor> all) {
    final q = _normalize(_searchQuery);
    if (q.isEmpty) return all;
    return all.where((s) {
      return _normalize(s.name).contains(q) ||
          _normalize(s.surname).contains(q) ||
          _normalize(s.agm).contains(q);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _stream = _buildStream();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      padding: EdgeInsets.only(
        left: padding + 10,
        right: padding + 10,
        top: 15,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToolbar(context),
          const Gap(padding),
          _buildTableHeader(),
          Expanded(
            child: StreamBuilder<List<Sailor>>(
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
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const WindowsIcon(WindowsIcons.restart_update2),
                          onPressed: () => setState(() {
                            _stream = _buildStream();
                          }),
                        ),
                        const Gap(5),
                        const Text('Retry'),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('Άγνωστο σφάλμα'));
                }

                final displayed = _filter(snapshot.data!);

                if (displayed.isEmpty) {
                  return const Center(
                    child: Text('Δεν βρέθηκαν αποτελέσματα.'),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.only(bottom: padding),
                  separatorBuilder: (_, _) => const Divider(),
                  itemCount: displayed.length,
                  itemBuilder: (context, index) {
                    final sailor = displayed[index];
                    final isLast = index == displayed.length - 1;
                    final bottomRadius = Radius.circular(isLast ? 5 : 0);

                    return HoverButton(
                      onPressed: () => Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (_) => SailorPage(sailor: sailor),
                        ),
                      ),
                      builder: (context, states) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: bottomRadius,
                            bottomRight: bottomRadius,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: padding + 5,
                          vertical: padding,
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('${sailor.surname} ${sailor.name}'),
                            ),
                            Expanded(flex: 1, child: Text(sailor.agm)),
                            Expanded(
                              flex: col3Flex,
                              child: Text(
                                '${sailor.rank.label} (${sailor.specialty.label})',
                              ),
                            ),
                            Expanded(
                              flex: col4Flex,
                              child: Text(sailor.mobile),
                            ),
                            Expanded(
                              flex: col5Flex,
                              child: SailorStatus(sailor: sailor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Row(
      children: [
        Text('Κατάλογος Ν/Δ', style: FluentTheme.of(context).typography.title),
        const Spacer(),
        FilledButton(
          onPressed: () => _showCreateNDDialog(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.add),
              const Gap(5),
              const Text('Προσθήκη Ν/Δ'),
            ],
          ),
        ),
        const Gap(10),
        SizedBox(
          width: 200,
          child: TextBox(
            controller: _searchController,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: WindowsIcon(WindowsIcons.search),
            ),
            placeholder: 'Αναζήτηση Ν/Δ',
            onChanged: (text) => setState(() {
              _searchQuery = _normalize(text);
            }),
          ),
        ),
        if (_searchController.text.isNotEmpty)
          IconButton(
            onPressed: () => setState(() {
              _searchController.clear();
              _searchQuery = '';
            }),
            icon: const WindowsIcon(WindowsIcons.clear),
          ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: secColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          topLeft: Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
      child: Row(
        spacing: 5,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Ονοματεπώνυμο',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text('ΑΓΜ', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: col3Flex,
            child: Text(
              'Βαθμός/Ειδικότητα',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: col4Flex,
            child: Text(
              'Τηλέφωνο',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: col5Flex,
            child: Text(
              'Κατάσταση',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateNDDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (_) => const ShowCreateNdDialog(),
    );
  }
}
