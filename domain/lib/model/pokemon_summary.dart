import 'package:meta/meta.dart';

class PokemonSummary {
  const PokemonSummary(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.isFavorite})
      : assert(id != null),
        assert(name != null),
        assert(imageUrl != null),
        assert(isFavorite != null);

  final int id;
  final String name;
  final String imageUrl;
  final bool isFavorite;
}
