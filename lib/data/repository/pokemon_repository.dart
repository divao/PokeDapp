import 'package:domain/data_repository/pokemon_data_repository.dart';
import 'package:domain/model/pokemon_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:poke_dapp/data/cache/data_source/pokemon_cds.dart';
import 'package:poke_dapp/data/remote/data_source/pokemon_rds.dart';
import 'package:poke_dapp/data/mapper/remote_to_cache.dart';
import 'package:poke_dapp/data/mapper/cache_to_domain.dart';

class PokemonRepository extends PokemonDataRepository {
  const PokemonRepository(
      {@required this.pokemonRDS, @required this.pokemonCDS})
      : assert(pokemonRDS != null),
        assert(pokemonCDS != null);

  final PokemonRDS pokemonRDS;
  final PokemonCDS pokemonCDS;

  @override
  Future<List<PokemonSummary>> getPokemonSummaryList() {
    final getPokemonSummaryListFuture = pokemonRDS
        .getPokemonSummaryList()
        .then(
          (rmPokemonSummaryList) => rmPokemonSummaryList
              .map(
                (rmPokemonSummary) => rmPokemonSummary.toCM(),
              )
              .toList(),
        )
        .then(
          (cmPokemonSummaryList) => pokemonCDS
              .upsertPokemonSummaryList(
                cmPokemonSummaryList,
              )
              .then(
                (_) => cmPokemonSummaryList,
              ),
        )
        .catchError(
          (remoteError) => pokemonCDS.getPokemonSummaryList().catchError(
                (cacheError) => throw remoteError,
              ),
        );

    return getPokemonSummaryListFuture.then((cmPokemonSummaryList) =>
        cmPokemonSummaryList
            .map((cmPokemonSummary) => cmPokemonSummary.toDM())
            .toList());
  }
}
