import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/create_nd.dart';
import 'package:milibase/sailor_page/sailors/sailor_page.dart';
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
  List<Sailor> _allSailors = [];
  List<Sailor> _displayedSailors = [];
  String _searchQuery = '';

  @override
  void initState() {
    _stream = db.select(db.tableSailors).watch().map((rows) {
      final sailors = rows.map((row) => Sailor.fromJson(row.toJson())).toList();
      sailors.sort(
        (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()),
      );
      return sailors;
    });
    super.initState();
  }

  void _searchSailors(String query) {
    setState(() {
      _searchQuery = query;
      _displayedSailors = query.isEmpty
          ? _allSailors
          : _allSailors.where((sailor) {
              final q = query.toLowerCase();
              return sailor.name.toLowerCase().contains(q) ||
                  sailor.surname.toLowerCase().contains(q);
            }).toList();
    });
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
                ),
            ],
          ),
          Gap(padding),
          Padding(
            padding: .symmetric(horizontal: padding),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 5,
              children: [
                Expanded(
                  flex: nameFlex,
                  child: Text(
                    'Ονοματεπώνυμο',
                    style: TextStyle(fontWeight: .bold),
                  ),
                ),
                Expanded(
                  flex: col2Flex,
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
              ],
            ),
          ),
          Gap(5),
          Expanded(
            child: StreamBuilder<List<Sailor>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: ProgressRing());
                }

                if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  if (error.contains('SocketException') ||
                      error.contains('Failed host lookup')) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            'Failed to connect to the server. Please check your internet connection.\nServer message: SocketException',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  _allSailors = snapshot.data!;
                  _displayedSailors = _searchQuery.isEmpty
                      ? _allSailors
                      : _allSailors
                            .where(
                              (s) => s.surname.toLowerCase().contains(
                                _searchQuery,
                              ),
                            )
                            .toList();
                  return ListView.builder(
                    itemCount: _displayedSailors.length,
                    itemBuilder: ((context, index) {
                      final Sailor sailor = _displayedSailors[index];

                      return HoverButton(
                        builder: (context, states) {
                          return Container(
                            margin: .symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: .circular(5),
                              color: Colors.white,
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
                                  flex: nameFlex,
                                  child: Text(
                                    '${sailor.surname} ${sailor.name}',
                                  ),
                                ),
                                Expanded(
                                  flex: col2Flex,
                                  child: Text(sailor.agm),
                                ),
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
