import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:poke_dapp/data/cache/model/pokemon_summary_cm.dart';

Future<void> hiveInitializer() async {
  Hive
    ..init((await path_provider.getApplicationDocumentsDirectory()).path)
    ..registerAdapter(PokemonSummaryCMAdapter());
}
