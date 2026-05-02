import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:milibase/styles/colors.dart';
import 'package:milibase/variables.dart';

class InfoOverview extends StatelessWidget {
  const InfoOverview({super.key, required this.title, required this.items});
  final String title;
  final List<Map<String, String>> items;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .all(.circular(5)),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: .symmetric(horizontal: padding, vertical: padding / 2),
              width: double.infinity,
              color: secColor,
              child: Text(
                title,
                style: FluentTheme.of(
                  context,
                ).typography.bodyLarge?.copyWith(fontWeight: .bold),
              ),
            ),
            Padding(
              padding: .all(padding),
              child: Column(
                spacing: 15,
                children: items.map((item) {
                  return Row(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.keys.first,
                          style: FluentTheme.of(context).typography.body,
                          overflow: .ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          item.values.first,
                          style: FluentTheme.of(context).typography.body,
                          overflow: .ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
