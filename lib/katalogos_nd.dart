import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/sailor_page/create_nd.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/sailor_page.dart';
import 'package:milibase/variables.dart';

import 'main.dart';

class KatalogosNd extends StatefulWidget {
  const KatalogosNd({super.key});

  @override
  State<KatalogosNd> createState() => _KatalogosNdState();
}

class _KatalogosNdState extends State<KatalogosNd> {
  late Future<List<Sailor>> _future;
  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  void _refreshData() {
    _future = db.select(db.tableSailors).get().then((rows) {
      return rows.map((row) => Sailor.fromJson(row.toJson())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(
              'Κατάλογος Ν/Δ',
              style: FluentTheme.of(context).typography.titleLarge,
            ),
            Spacer(),
            IconButton(
              icon: WindowsIcon(WindowsIcons.update_restore),
              onPressed: () => setState(() {
                _refreshData();
              }),
            ),
            Gap(10),
            FilledButton(
              child: Row(
                mainAxisSize: .min,
                children: [Icon(FluentIcons.add), Gap(5), Text('Προσθήκη Ν/Δ')],
              ),
              onPressed: () => showCreateNDDialog(context),
              //showNdDialog(context),
            ),
          ],
        ),
        Gap(padding),
        Padding(
          padding: .symmetric(horizontal: padding),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(child: Text('Ονοματεπώνυμο')),
              Expanded(child: Text('ΑΓΜ')),
              Expanded(child: Text('Βαθμός/Ειδικότητα')),
              Expanded(child: Text('Τηλέφωνο')),
            ],
          ),
        ),
        Gap(10),
        Expanded(
          child: FutureBuilder(
            future: _future,
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
                        Gap(10),
                        Button(
                          child: Text('Retry'),
                          onPressed: () => _refreshData(),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final sailors = snapshot.data!;
                return ListView.builder(
                  itemCount: sailors.length,
                  itemBuilder: ((context, index) {
                    final Sailor sailor = sailors[index];
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
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Expanded(
                                child: Text('${sailor.surname} ${sailor.name}'),
                              ),
                              Expanded(child: Text(sailor.agm)),
                              Expanded(
                                child: Text(
                                  '${sailor.rank.label} (${sailor.specialty.label})',
                                ),
                              ),
                              Expanded(child: Text(sailor.mobile)),
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
    );
  }

  void showCreateNDDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ShowCreateNdDialog(),
    );

    setState(() {
      _refreshData();
    });
  }
}
