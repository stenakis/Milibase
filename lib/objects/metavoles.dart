enum Metavoli {
  meiomeni,
  exagora,
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
          Metavoli.exagora: 'Εξαγορά'
        }[this] ??
        'Μειωμένη Θητεία';
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

  static DateTime _parseDate(dynamic date) {
    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    }
    return DateTime.parse(date.toString());
  }

  factory Metavoles.fromJson(Map<String, dynamic> json) {
    return Metavoles(
      id: json['id'],
      type: Metavoli.fromString(json['type']),
      date: _parseDate(json['date']),
      sailorId: json['sailorId'],
      duration: json['duration'],
      sima: json['sima'],
    );
  }
}
