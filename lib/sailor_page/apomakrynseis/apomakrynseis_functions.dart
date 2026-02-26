import 'package:milibase/objects/apomakrynseis.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> addNewApomakrynsi(Apomakrynseis apomakrynsi) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Apomakrynseis').insert(apomakrynsi.toJson());
}

Future<void> deleteApomakrynsi(String? id) async {
  final supabase = Supabase.instance.client;
  await supabase.from('Apomakrynseis').delete().eq('id', id ?? '');
}
