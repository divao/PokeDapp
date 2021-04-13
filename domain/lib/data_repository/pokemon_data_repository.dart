import 'dart:async';

import 'package:domain/model/pokemon_summary.dart';

abstract class PokemonDataRepository {
  const PokemonDataRepository();

  Future<List<PokemonSummary>> getPokemonSummaryList();
}