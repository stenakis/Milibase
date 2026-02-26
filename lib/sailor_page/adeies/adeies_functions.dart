import 'package:milibase/objects/adeies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> addNewAdeia(Adeies adeia) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Adeies').insert(adeia.toJson());
}

Future<void> deleteAdeia(String? id) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Adeies').delete().eq('id', id ?? '');
}
