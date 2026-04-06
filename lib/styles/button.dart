import 'package:fluent_ui/fluent_ui.dart';
import 'package:milibase/styles/colors.dart';

class FluentButton extends StatelessWidget {
  final double? height, width;
  final bool? selected;
  final Widget? icon;
  final String? text;
  final void Function()? onPressed;
  final double? padding;
  final double? color;
  const FluentButton({
    super.key,
    this.height,
    this.selected,
    this.icon,
    this.text,
    this.onPressed,
    this.width,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: onPressed,
      builder: (BuildContext context, Set<WidgetState> state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: .circular(5),

            color:
                (selected != null && selected!
                        ? color ?? secColor
                        : secColor.withAlpha(75))
                    as Color?,
          ),
          width: width,
          height: height,
          child: Padding(
            padding: .symmetric(
              horizontal: padding ?? 20,
              vertical: padding != null ? padding! - 5 : 12,
            ),
            child: Row(
              spacing: 10,
              children: [
                if (icon != null) SizedBox(height: 24, child: icon),
                if (text != null) Text(text!),
              ],
            ),
          ),
        );
      },
    );
  }
}
