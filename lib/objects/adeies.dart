import 'package:intl/intl.dart';
import 'package:milibase/objects/sailor.dart';

enum Adeia {
  kanoniki,
  aimodotiki,
  proforiki,
  timitiki;

  static Adeia fromString(String value) {
    return Adeia.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Adeia.kanoniki,
    );
  }

  String get label {
    return {
          Adeia.kanoniki: 'Κανονική',
          Adeia.aimodotiki: 'Αιμοδοτική',
          Adeia.proforiki: 'Προφορική',
          Adeia.timitiki: 'Τιμητική',
        }[this] ??
        'Κανονική';
  }

  String get enumType {
    return {
          Adeia.kanoniki: 'kanoniki',
          Adeia.aimodotiki: 'aimodotiki',
          Adeia.proforiki: 'proforiki',
          Adeia.timitiki: 'timitiki',
        }[this] ??
        'kanoniki';
  }
}

class Adeies {
  final String? id;
  final Adeia type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String sailorId;

  Adeies({
    this.id,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sailorId,
  });

  Map<String, dynamic> toJson() => {
    'Type': type.enumType,
    'Date_Start': DateFormat('yyyy-MM-dd').format(dateStart),
    'Date_End': DateFormat('yyyy-MM-dd').format(dateEnd),
    'Sailor_id': sailorId,
  };

  // Parse the String from Supabase back into a Dart DateTime
  factory Adeies.fromJson(Map<String, dynamic> json) {
    return Adeies(
      id: json['id'],
      type: Adeia.fromString(json['Type']),
      dateStart: DateTime.parse(json['Date_Start']),
      dateEnd: DateTime.parse(json['Date_End']),
      sailorId: json['Sailor_id'] as String,
    );
  }
}
