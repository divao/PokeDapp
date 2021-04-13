import 'package:domain/model/pokemon_summary.dart';
import 'package:poke_dapp/data/cache/model/pokemon_summary_cm.dart';
import 'package:poke_dapp/common/utils.dart';

extension PokemonSummaryCMMappers on PokemonSummaryCM {
  PokemonSummary toDM() {
    final id = int.parse(Uri.parse(url).pathSegments[3]);
    return PokemonSummary(
      id: id,
      name: name.capitalize(),
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/$id.png',
      isFavorite: false,
    );
  }
}
