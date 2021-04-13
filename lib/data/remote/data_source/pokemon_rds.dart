import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:poke_dapp/data/remote/infrastructure/path_builder.dart';
import 'package:poke_dapp/data/remote/model/get_pokemon_summary_list_response_rm.dart';
import 'package:poke_dapp/data/remote/model/pokemon_summary_rm.dart';

class PokemonRDS {
  PokemonRDS({@required this.dio}) : assert(dio != null);

  final Dio dio;

  Future<List<PokemonSummaryRM>> getPokemonSummaryList() =>
      dio.get(PathBuilder.pokemonList()).then(
        (response) {
          final responseData =
              GetPokemonSummaryListResponseRM.fromJson(response.data);
          final result = responseData.results
              .map((resultMap) => PokemonSummaryRM.fromJson(resultMap))
              .toList();
          return result;
        },
      );
}
