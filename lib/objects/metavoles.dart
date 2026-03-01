import 'package:intl/intl.dart';

enum Metavoli {
  meiomeni,
  ekkremei;

  static Metavoli fromString(String value) {
    return Metavoli.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Metavoli.meiomeni,
    );
  }

  String get label {
    return {
          Metavoli.meiomeni: 'Μειωμένη Θητεία',
          Metavoli.ekkremei: 'Εκκρεμότητα',
        }[this] ??
        'Μειωμένη Θητεία';
  }

  String get enumType {
    return {
          Metavoli.meiomeni: 'meiomeni',
          Metavoli.ekkremei: 'ekkremei',
        }[this] ??
        'meiomeni';
  }
}

class Metavoles {
  final String? id;
  final Metavoli type;
  final DateTime date;
  final String sailorId;
  final String sima;
  final int? duration;

  Metavoles({
    this.id,
    required this.type,
    required this.date,
    required this.sailorId,
    required this.sima,
    this.duration,
  });

  Map<String, dynamic> toJson() => {
    'Type': type.enumType,
    'Date': DateFormat('yyyy-MM-dd').format(date),
    'Sailor_id': sailorId,
    'Sima': sima,
    'Duration': duration,
  };

  factory Metavoles.fromJson(Map<String, dynamic> json) {
    return Metavoles(
      id: json['id'],
      type: Metavoli.fromString(json['Type']),
      date: DateTime.parse(json['Date']),
      sailorId: json['Sailor_id'],
      duration: json['Duration'],
      sima: json['Sima'],
    );
  }
}
