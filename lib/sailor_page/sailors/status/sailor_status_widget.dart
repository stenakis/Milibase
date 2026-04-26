import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/objects/status.dart';
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
    super.initState();
    _status = checkStatus(widget.sailor);
  }

  Status _resolveStatus(bool hasAdeia, bool hasApomakrynseis) {
    if (hasAdeia) return Status.seAdeia;
    if (hasApomakrynseis) return Status.seApomakrynsi;
    if (DateTime.now().isAfter(widget.sailor.dateRemoval)) {
      return Status.apolythike;
    }
    return Status.stinYphresia;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(bool, bool)>(
      stream: _status,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressBar());
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
          return const SizedBox.shrink();
        }
        if (!snapshot.hasData) return const SizedBox.shrink();
        final (hasAdeia, hasApomakrynseis) = snapshot.data!;
        return SailorStatusStyle(
          status: _resolveStatus(hasAdeia, hasApomakrynseis),
        );
      },
    );
  }
}
