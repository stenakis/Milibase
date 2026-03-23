import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milibase/styles/colors.dart';

Typography getTypography(Brightness brightness) {
  final Color color = brightness == Brightness.light
      ? Colors.black
      : Colors.white;

  return Typography.raw(
    caption: GoogleFonts.inter(fontSize: 12, color: color.withOpacity(0.6)),
    body: GoogleFonts.inter(fontSize: 14, color: color),
    subtitle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
    title: GoogleFonts.inter(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: mainColor,
    ),
    titleLarge: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold),
  );
}

extension StringExtension on String {
  String toCapitalLowercase() {
    return split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
