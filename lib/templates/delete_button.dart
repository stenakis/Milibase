import 'package:fluent_ui/fluent_ui.dart';

class DeleteFlyout extends StatefulWidget {
  const DeleteFlyout({
    super.key,
    required this.title,
    this.returnType,
    required this.onPressed,
  });
  final String title;
  final dynamic returnType;
  final Future<void> Function() onPressed;
  @override
  State<DeleteFlyout> createState() => _DeleteFlyoutState();
}

class _DeleteFlyoutState extends State<DeleteFlyout> {
  final FlyoutController flyoutController = FlyoutController();

  @override
  Widget build(BuildContext context) {
    return FlyoutTarget(
      controller: flyoutController,
      child: IconButton(
        icon: const WindowsIcon(WindowsIcons.delete),
        onPressed: () {
          flyoutController.showFlyout<void>(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.topCenter,
            ),
            barrierDismissible: true,
            dismissOnPointerMoveAway: false,
            dismissWithEsc: true,
            builder: (context) {
              return FlyoutContent(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12.0),
                    Button(
                      onPressed: () async {
                        try {
                          await widget.onPressed();
                          Navigator.pop(context);
                        } catch (error) {
                          await displayInfoBar(
                            context,
                            duration: Duration(seconds: 5),
                            builder: (context, close) {
                              return InfoBar(
                                title: const Text('Σφάλμα:'),
                                content: Text(error.toString()),
                                action: IconButton(
                                  icon: const WindowsIcon(WindowsIcons.error),
                                  onPressed: close,
                                ),
                                severity: InfoBarSeverity.error,
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Επιβεβαίωση'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
