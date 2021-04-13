import 'package:domain/use_case/get_pokemon_list_uc.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/common/subscription_holder.dart';
import 'package:poke_dapp/presentation/common/generic_error.dart';
import 'package:poke_dapp/presentation/pokemon/list/pokemon_list_models.dart';
import 'package:rxdart/rxdart.dart';

class PokemonListBloc with SubscriptionHolder {
  PokemonListBloc({@required this.getPokemonSummaryListUC})
      : assert(getPokemonSummaryListUC != null) {
    Rx.merge(List<Stream<void>>.of([
      Stream.value(null),
      _onTryAgainSubject,
    ]))
        .flatMap((_) => _fetchPokemonList())
        .listen(_onNewStateSubject.add)
        .addTo(subscriptions);
  }

  final _onTryAgainSubject = PublishSubject<void>();

  Sink<void> get onTryAgainSink => _onTryAgainSubject.sink;

  final GetPokemonSummaryListUC getPokemonSummaryListUC;

  final _onNewStateSubject = BehaviorSubject<PokemonListState>.seeded(
    Loading(),
  );

  Stream<PokemonListState> get onNewState => _onNewStateSubject.stream;

  Stream<PokemonListState> _fetchPokemonList() async* {
    yield Loading();

    try {
      final list = await getPokemonSummaryListUC.getFuture();
      yield Success(
        list: list,
      );
    } catch (e) {
      yield Error(mapToGenericErrorType(e));
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
    disposeAll();
  }
}
