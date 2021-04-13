import 'package:domain/use_case/get_pokemon_list_uc.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/generated/l10n.dart';
import 'package:poke_dapp/presentation/common/adaptive_scaffold.dart';
import 'package:poke_dapp/presentation/common/async_snapshot_response_view.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/pokemon/list/pokemon_list_bloc.dart';
import 'package:poke_dapp/presentation/pokemon/list/pokemon_list_item.dart';
import 'package:poke_dapp/presentation/pokemon/list/pokemon_list_models.dart';
import 'package:provider/provider.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({@required this.bloc, Key key})
      : assert(bloc != null),
        super(key: key);

  final PokemonListBloc bloc;

  static Widget create(BuildContext context) =>
      ProxyProvider<GetPokemonSummaryListUC, PokemonListBloc>(
        update: (context, useCase, currentBloc) =>
            currentBloc ?? PokemonListBloc(getPokemonSummaryListUC: useCase),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<PokemonListBloc>(
          builder: (context, bloc, _) => PokemonListPage(
            bloc: bloc,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: S.of(context).appBarTitle,
      backgroundColor: PDTheme.of(context).surfaceColor,
      body: StreamBuilder<PokemonListState>(
        stream: bloc.onNewState,
        builder: (context, snapshot) =>
            AsyncSnapshotResponseView<Loading, Error, Success>(
          snapshot: snapshot,
          onTryAgainTap: () => bloc.onTryAgainSink.add(null),
          successWidgetBuilder: (context, successState) => RefreshIndicator(
            onRefresh: () async => bloc.onTryAgainSink.add(null),
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: successState.list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final pokemonSummary = successState.list[index];
                return PokemonListItem(
                  name: pokemonSummary.name,
                  imageUrl: pokemonSummary.imageUrl,
                  onTap: () {},
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
