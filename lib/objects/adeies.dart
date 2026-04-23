enum Adeia {
  kanoniki,
  aimodotiki,
  proforiki,
  timitiki,
  anarrotiki,
  oikos_nosileias;

  static int kanonikiDays(int servingMonths) => switch (servingMonths) {
    6 => 9,
    9 => 15,
    _ => 18,
  };

  static Adeia fromString(String value) {
    return Adeia.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Adeia.kanoniki,
    );
  }

  String get label => switch (this) {
    Adeia.kanoniki => 'Κανονική',
    Adeia.aimodotiki => 'Αιμοδοτική',
    Adeia.proforiki => 'Προφορική',
    Adeia.timitiki => 'Τιμητική',
    Adeia.anarrotiki => 'Αναρρωτική',
    Adeia.oikos_nosileias => 'Οίκος Νοσηλείας',
  };
}

class Adeies {
  final String id;
  final Adeia type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String sailorId;
  final String? sima;

  Adeies({
    required this.id,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sailorId,
    this.sima,
  });

  static DateTime _parseDate(dynamic date) {
    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    }
    return DateTime.parse(date.toString());
  }

  factory Adeies.fromJson(Map<String, dynamic> json) {
    return Adeies(
      id: json['id']!.toString(),
      type: Adeia.fromString(json['type']),
      dateStart: _parseDate(json['dateStart']),
      dateEnd: _parseDate(json['dateEnd']),
      sailorId: json['sailorId'],
      sima: json['sima'],
    );
  }
}
