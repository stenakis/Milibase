import 'package:fluent_ui/fluent_ui.dart';

import '../../../objects/status.dart';

class SailorStatusStyle extends StatelessWidget {
  const SailorStatusStyle({super.key, required this.status});
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        Container(
          padding: .symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: .all(.circular(5)),
            color: () {
              switch (status) {
                case Status.stinYphresia:
                  return Colors.blue.withAlpha(40);
                case Status.seAdeia:
                  return Colors.green.withAlpha(40);
                case Status.seApomakrynsi:
                  return Colors.orange.withAlpha(40);
                case Status.apolythike:
                  return Colors.grey.withAlpha(40);
              }
            }(),
          ),
          child: Text(
            status.label,
            style: TextStyle(
              color: () {
                switch (status) {
                  case Status.stinYphresia:
                    return Colors.blue;
                  case Status.seAdeia:
                    return Colors.green;
                  case Status.seApomakrynsi:
                    return Colors.orange;
                  case Status.apolythike:
                    return Colors.grey;
                }
              }(),
            ),
          ),
        ),
      ],
    );
  }
}
