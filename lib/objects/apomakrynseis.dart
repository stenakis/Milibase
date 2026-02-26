import 'package:intl/intl.dart';

enum Apomakrynsi {
  diathesi,
  apospasi;

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
        }[this] ??
        'Απόσπαση';
  }

  String get enumType {
    return {
          Apomakrynsi.apospasi: 'apospasi',
          Apomakrynsi.diathesi: 'diathesi',
        }[this] ??
        'apospasi';
  }
}

class Apomakrynseis {
  final String? id;
  final Apomakrynsi type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String sailorId;
  final String sima;
  final String ypiresia;

  Apomakrynseis({
    this.id,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sailorId,
    required this.ypiresia,
    required this.sima,
  });

  Map<String, dynamic> toJson() => {
    'Type': type.enumType,
    'Date_Start': DateFormat('yyyy-MM-dd').format(dateStart),
    'Date_End': DateFormat('yyyy-MM-dd').format(dateEnd),
    'Sailor_id': sailorId,
    'Ypiresia': ypiresia,
    'Sima': sima,
  };

  factory Apomakrynseis.fromJson(Map<String, dynamic> json) {
    return Apomakrynseis(
      id: json['id'],
      type: Apomakrynsi.fromString(json['Type']),
      dateStart: DateTime.parse(json['Date_Start']),
      dateEnd: DateTime.parse(json['Date_End']),
      sailorId: json['Sailor_id'],
      ypiresia: json['Ypiresia'],
      sima: json['Sima'],
    );
  }
}
