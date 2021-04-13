class RouteNameBuilder {

  static const deepLinkQueryParameter = 'deepLink';
  static const pokemonResource = 'pokemon';
  static const favoritesResource = 'favorites';

  static String pokemonScreen() => '$pokemonResource';
  static String favoritesScreen() => '$favoritesResource';

  static String extractScreenName(String path) {
    // pega a string até o primeiro ? ou /
    final resource = RegExp(r'^[^\?\/]*').stringMatch(path);

    if (resource.isEmpty) {
      return 'Home';
    }

    switch (resource) {
      // case homeResource:
      //   return 'Home';
      default:
        return resource;
    }
  }
}