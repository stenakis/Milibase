import 'package:intl/intl.dart';

enum Adeia {
  kanoniki,
  aimodotiki,
  proforiki,
  timitiki,
  anarrotiki,
  oikos_nosileias;

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
          Adeia.anarrotiki: 'Αναρρωτική',
          Adeia.oikos_nosileias: 'Οίκος Νοσηλείας',
        }[this] ??
        'Κανονική';
  }

  String get enumType {
    return {
          Adeia.kanoniki: 'kanoniki',
          Adeia.aimodotiki: 'aimodotiki',
          Adeia.proforiki: 'proforiki',
          Adeia.timitiki: 'timitiki',
          Adeia.anarrotiki: 'anarrotiki',
          Adeia.oikos_nosileias: 'oikos_nosileias:',
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
  final String? sima;

  Adeies({
    this.id,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sailorId,
    this.sima,
  });

  Map<String, dynamic> toJson() => {
    'Type': type.enumType,
    'Date_Start': DateFormat('yyyy-MM-dd').format(dateStart),
    'Date_End': DateFormat('yyyy-MM-dd').format(dateEnd),
    'Sailor_id': sailorId,
    'Sima': sima,
  };

  // Parse the String from Supabase back into a Dart DateTime
  factory Adeies.fromJson(Map<String, dynamic> json) {
    return Adeies(
      id: json['id'],
      type: Adeia.fromString(json['Type']),
      dateStart: DateTime.parse(json['Date_Start']),
      dateEnd: DateTime.parse(json['Date_End']),
      sailorId: json['Sailor_id'],
      sima: json['Sima'],
    );
  }
}
