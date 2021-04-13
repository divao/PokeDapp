import 'package:poke_dapp/data/cache/model/pokemon_summary_cm.dart';
import 'package:poke_dapp/data/remote/model/pokemon_summary_rm.dart';
import 'package:poke_dapp/common/utils.dart';

extension PokemonSummaryRMMappers on PokemonSummaryRM {
  PokemonSummaryCM toCM() => PokemonSummaryCM(
        name: name.capitalize(),
        url: url,
      );
}
