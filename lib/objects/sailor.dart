import '../objects/rank.dart';
import '../objects/specialty.dart';

class Sailor {
  final String id;
  final String name;
  final String surname;
  final String agm;
  final Rank rank;
  final Specialty specialty;
  final String address;
  final String mobile;
  final String landline;
  final String education;
  final int servingMonths;
  final DateTime dateArrival;
  final DateTime dateInsert;
  final DateTime dateRemoval;
  final bool avardiotos;
  Sailor({
    this.id = '',
    required this.name,
    required this.surname,
    required this.agm,
    required this.specialty,
    required this.address,
    required this.mobile,
    required this.landline,
    required this.education,
    required this.dateArrival,
    required this.dateInsert,
    required this.dateRemoval,
    required this.rank,
    required this.servingMonths,
    this.avardiotos = false,
  });

  factory Sailor.fromJson(Map<String, dynamic> json) {
    return Sailor(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      surname: json['surname']?.toString() ?? '',
      agm: json['agm']?.toString() ?? '',
      rank: Rank.fromString(json['rank']?.toString() ?? ''),
      specialty: Specialty.fromString(json['specialty']?.toString() ?? ''),
      address: json['address']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      landline: json['landline']?.toString() ?? '',
      education: json['education']?.toString() ?? '',
      servingMonths: (json['servingMonths'] as num?)?.toInt() ?? 0,
      dateArrival: DateTime.fromMicrosecondsSinceEpoch(
        json['dateArrival'].toInt() * 1000,
      ),
      dateInsert: DateTime.fromMicrosecondsSinceEpoch(
        json['dateInsert'].toInt() * 1000,
      ),
      dateRemoval: DateTime.fromMicrosecondsSinceEpoch(
        json['dateRemoval'].toInt() * 1000,
      ),
      avardiotos: json['avardiotos'] ?? false,
    );
  }
}
