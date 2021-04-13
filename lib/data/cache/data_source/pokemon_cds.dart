import 'package:hive/hive.dart';
import 'package:poke_dapp/data/cache/data_source/base_cds.dart';
import 'package:poke_dapp/data/cache/model/pokemon_summary_cm.dart';

class PokemonCDS extends BaseCDS {

  static const _pokemonSummaryListBoxKey = '_pokemonSummaryListBoxKey';

  @override
  Future<void> migrateData() {
    throw UnimplementedError();
  }

  Future<List<PokemonSummaryCM>> getPokemonSummaryList() async {
    final box = await Hive.openBox<List<PokemonSummaryCM>>(_pokemonSummaryListBoxKey);
    return box.getAt(0);
  }

  Future<void> upsertPokemonSummaryList(List<PokemonSummaryCM> list) async {
    final box = await Hive.openBox<List<PokemonSummaryCM>>(_pokemonSummaryListBoxKey);
    return box.putAll({0: list});
  }

}