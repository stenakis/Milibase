import 'package:supabase_flutter/supabase_flutter.dart';

import '../../objects/metavoles.dart';

Future<void> addNewMetavoli(Metavoles metavoli) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Metavoles').insert(metavoli.toJson());
}

Future<void> deleteMetavoli(String? id) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Metavoles').delete().eq('id', id ?? '');
}
