class PathBuilder {
  static const _baseUrl = 'https://pokeapi.co/api/v2/';
  static const _pokemonListResource = 'pokemon?limit=151';

  static String pokemonList() => '$_baseUrl$_pokemonListResource';
}