import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/navigation.dart';
import 'package:milibase/objects/sailor.dart';
import 'package:milibase/sailor_page/sailor_page.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/styles/typography.dart';
import 'package:milibase/variables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jdwlcddrlkjxvazwcspg.supabase.co',
    anonKey: 'sb_publishable_wEqxMwNZzdsI7R1JTADL9g_NC7Hu3PM',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      locale: const Locale('el'),
      title: 'Flutter Demo',
      theme: FluentThemeData(
        accentColor: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        typography: getInterTypography(Brightness.light),
        visualDensity: VisualDensity.standard,
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const Navigation(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Sailor>> _future;
  @override
  void initState() {
    _future = Supabase.instance.client
        .from('Sailors')
        .select()
        .then((data) => data.map((json) => Sailor.fromJson(json)).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      content: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Text(
                'Κατάλογος Ν/Δ',
                style: FluentTheme.of(context).typography.titleLarge,
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
                onPressed: () {},
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
                Text('Ονοματεπώνυμο'),
                Text('ΑΓΜ'),
                Text('Βαθμός/Ειδικότητα'),
                Text('Τηλέφωνο'),
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
                                Text('${sailor.surname} ${sailor.name}'),
                                Text(sailor.agm),
                                Text(
                                  '${sailor.rank.label} (${sailor.specialty.label})',
                                ),
                                Text(sailor.mobile),
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
}
