import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/sailor_page/sailors/status/sailor_status_style.dart';

import '../../../objects/sailor.dart';
import '../../../templates/info_bar.dart';
import 'sailor_status.dart';

class SailorStatus extends StatefulWidget {
  const SailorStatus({super.key, required this.sailor});
  final Sailor sailor;

  @override
  State<SailorStatus> createState() => _SailorStatusState();
}

class _SailorStatusState extends State<SailorStatus> {
  late Stream<(bool, bool)> _status;

  @override
  void initState() {
    _status = checkStatus(widget.sailor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _status,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        }
        if (snapshot.hasError) {
          showCustomInfoBar(context: context, text: snapshot.error.toString());
          return SizedBox.shrink();
        } else if (snapshot.hasData) {
          final (hasAdeia, hasApomakrynseis) = snapshot.data ?? (false, false);
          if (hasAdeia) {
            return SailorStatusStyle(status: .seAdeia);
          }
          if (hasApomakrynseis) {
            return SailorStatusStyle(status: .seApomakrynsi);
          }
          if (DateTime.now().isAfter(widget.sailor.dateRemoval)) {
            return SailorStatusStyle(status: .apolythike);
          }
          return SailorStatusStyle(status: .stinYphresia);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
