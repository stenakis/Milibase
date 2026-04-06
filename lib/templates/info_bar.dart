import 'package:fluent_ui/fluent_ui.dart';

Future<void> showCustomInfoBar({
  required BuildContext context,
  String? title,
  required String text,
  InfoBarSeverity? severity,
}) async {
  await displayInfoBar(
    context,
    builder: (context, close) {
      return InfoBar(
        title: Text(title ?? 'Σφάλμα:'),
        content: Text(text),
        action: IconButton(
          icon: const WindowsIcon(WindowsIcons.error),
          onPressed: close,
        ),
        severity: severity ?? .error,
      );
    },
  );
}
