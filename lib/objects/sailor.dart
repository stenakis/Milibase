import 'package:milibase/objects/adeies.dart';
import 'package:milibase/objects/rank.dart';
import 'package:milibase/objects/specialty.dart';

class Sailor {
  final String id;
  final String name;
  final String surname;
  final String agm;
  final Rank rank;
  final Specialty specialty;
  final List<Adeies> adeies;
  final String address;
  final String mobile;
  final String landline;
  final String education;
  final int servingMonths;
  final DateTime dateArrival;
  final DateTime dateInsert;
  final DateTime dateRemoval;

  Sailor({
    required this.id,
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
    required this.adeies,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'Surname': surname,
    'Name': name,
    'AGM': agm,
    'Rank': rank,
    'Specialty': specialty,
    'Address': address,
    'Mobile': mobile,
    'Landline': landline,
    'Education': education,
    'Adeies': adeies,
    'Serving_Months': servingMonths,
    'Date_Arrival': dateArrival,
    'Date_Insert': dateInsert,
    'Date_Removal': dateRemoval,
  };

  factory Sailor.fromJson(Map<String, dynamic> json) {
    return Sailor(
      id: json['id'] as String,
      name: json['Name'] as String,
      surname: json['Surname'] as String,
      agm: json['AGM'] as String,
      rank: Rank.fromString(json['Rank']),
      adeies: (json['adeies'] as List? ?? [])
          .map((item) => Adeies.fromJson(item))
          .toList(),
      specialty: Specialty.fromString(json['Specialty']),
      address: json['Address'] as String,
      mobile: json['Mobile'] as String,
      landline: json['Landline'] as String,
      servingMonths: json['Serving_Months'] as int,
      education: json['Education'] as String,
      dateArrival: DateTime.tryParse(json['Date_Arrival']) as DateTime,
      dateInsert: DateTime.tryParse(json['Date_Insert']) as DateTime,
      dateRemoval: DateTime.tryParse(json['Date_Removal']) as DateTime,
    );
  }
}
