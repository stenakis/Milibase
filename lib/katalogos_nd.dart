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
  final searchController = TextEditingController();
  late Stream<List<Sailor>> _stream;
  late List<Sailor> _allSailors;
  List<Sailor> _displayedSailors = [];
  String _searchQuery = '';
  void retry() {
    _stream = db.select(db.tableSailors).watch().map((rows) {
      final sailors = rows.map((row) => Sailor.fromJson(row.toJson())).toList();
      sailors.sort(
        (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()),
      );
      _allSailors = sailors;
      return sailors;
    });
  }

  @override
  void initState() {
    retry();
    super.initState();
  }

  void _searchSailors(String query) {
    _searchQuery = query.toLowerCase();
    _displayedSailors = query.isEmpty
        ? _allSailors
        : _allSailors.where((sailor) {
            final q = _searchQuery;
            return sailor.name.toLowerCase().contains(q) ||
                sailor.surname.toLowerCase().contains(q) ||
                sailor.agm.toLowerCase().contains(q.trim());
          }).toList();
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
              Text(
                'Κατάλογος Ν/Δ',
                style: FluentTheme.of(context).typography.title,
              ),
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
                onPressed: () => showCreateNDDialog(context),
                //showNdDialog(context),
              ),
              Gap(10),
              SizedBox(
                width: 200,
                child: TextBox(
                  controller: searchController,
                  prefix: Padding(
                    padding: .only(left: 10),
                    child: WindowsIcon(WindowsIcons.search),
                  ),
                  placeholder: 'Αναζήτηση Ν/Δ',
                  onChanged: (String text) {
                    setState(() {
                      _searchSailors(text);
                    });
                  },
                ),
              ),
              if (searchController.text.isNotEmpty)
                IconButton(
                  onPressed: () => setState(() {
                    searchController.clear();
                    _searchQuery = '';
                    _displayedSailors = _allSailors;
                  }),
                  icon: WindowsIcon(WindowsIcons.clear),
                ),
            ],
          ),
          Gap(padding),
          Container(
            decoration: BoxDecoration(
              color: secColor,
              borderRadius: .only(
                topRight: .circular(5),
                topLeft: .circular(5),
              ),
            ),
            padding: .symmetric(horizontal: padding, vertical: 10),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 5,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Ονοματεπώνυμο',
                    style: TextStyle(fontWeight: .bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('ΑΓΜ', style: TextStyle(fontWeight: .bold)),
                ),
                Expanded(
                  flex: col3Flex,
                  child: Text(
                    'Βαθμός/Ειδικότητα',
                    style: TextStyle(fontWeight: .bold),
                  ),
                ),
                Expanded(
                  flex: col4Flex,
                  child: Text('Τηλέφωνο', style: TextStyle(fontWeight: .bold)),
                ),
                Expanded(
                  flex: col5Flex,
                  child: Text('Κατάσταση', style: TextStyle(fontWeight: .bold)),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<List<Sailor>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: ProgressRing());
                }
                if (snapshot.hasError) {
                  showCustomInfoBar(
                    context: context,
                    text: snapshot.error.toString(),
                  );
                  return Center(
                    child: Column(
                      children: [
                        IconButton(
                          icon: WindowsIcon(WindowsIcons.restart_update2),
                          onPressed: () => setState(() => retry()),
                        ),
                        Gap(5),
                        Text('Retry'),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  _allSailors = snapshot.data!;
                  _displayedSailors = _searchQuery.isEmpty
                      ? _allSailors
                      : _allSailors
                            .where(
                              (s) =>
                                  s.surname.toLowerCase().contains(
                                    _searchQuery,
                                  ) ||
                                  s.name.toLowerCase().contains(_searchQuery) ||
                                  s.agm.toLowerCase().contains(_searchQuery),
                            )
                            .toList();
                  return ListView.separated(
                    padding: .only(bottom: padding),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: _displayedSailors.length,
                    itemBuilder: ((context, index) {
                      final Sailor sailor = _displayedSailors[index];
                      final isLast = index == _displayedSailors.length - 1;
                      final bottomRadius = Radius.circular(isLast ? 5 : 0);
                      return HoverButton(
                        builder: (context, states) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .only(
                                bottomLeft: bottomRadius,
                                bottomRight: bottomRadius,
                              ),
                            ),
                            padding: .symmetric(
                              horizontal: padding + 5,
                              vertical: padding,
                            ),
                            child: Row(
                              spacing: 5,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${sailor.surname} ${sailor.name}',
                                  ),
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
                          );
                        },
                        onPressed: () {
                          Navigator.push(
                            context,
                            FluentPageRoute(
                              builder: (context) => SailorPage(sailor: sailor),
                            ),
                          );
                        },
                      );
                    }),
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

  void showCreateNDDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ShowCreateNdDialog(),
    );
  }
}
