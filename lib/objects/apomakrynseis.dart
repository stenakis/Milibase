import 'package:intl/intl.dart';

enum Apomakrynsi {
  diathesi,
  apospasi,
  metathesi;

  static Apomakrynsi fromString(String value) {
    return Apomakrynsi.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Apomakrynsi.apospasi,
    );
  }

  String get label {
    return {
          Apomakrynsi.apospasi: 'Απόσπαση',
          Apomakrynsi.diathesi: 'Διάθεση',
          Apomakrynsi.metathesi: 'Μετάθεση',
        }[this] ??
        'Απόσπαση';
  }

  String get enumType {
    return {
          Apomakrynsi.apospasi: 'apospasi',
          Apomakrynsi.diathesi: 'diathesi',
          Apomakrynsi.metathesi: 'metathesi',
        }[this] ??
        'apospasi';
  }
}

class Apomakrynseis {
  final String id;
  final Apomakrynsi type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String sailorId;
  final String sima;
  final String ypiresia;

  Apomakrynseis({
    required this.id,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sailorId,
    required this.ypiresia,
    required this.sima,
  });

  Map<String, dynamic> toJson() => {
    'type': type.enumType,
    'dateStart': DateFormat('yyyy-MM-dd').format(dateStart),
    'dateEnd': DateFormat('yyyy-MM-dd').format(dateEnd),
    'sailorId': sailorId,
    'ypiresia': ypiresia,
    'sima': sima,
  };

  static DateTime _parseDate(dynamic date) {
    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    }
    return DateTime.parse(date.toString());
  }

  factory Apomakrynseis.fromJson(Map<String, dynamic> json) {
    return Apomakrynseis(
      id: json['id'],
      type: Apomakrynsi.fromString(json['type']),
      dateStart: _parseDate(json['dateStart']),
      dateEnd: _parseDate(json['dateEnd']),
      sailorId: json['sailorId'],
      ypiresia: json['ypiresia'],
      sima: json['sima'],
    );
  }
}
