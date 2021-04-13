import 'package:domain/model/pokemon_summary.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/common/generic_error.dart';

abstract class PokemonListState {}

class Success implements PokemonListState {
  Success({@required this.list}) : assert(list != null);
  final List<PokemonSummary> list;
}

class Loading implements PokemonListState {}

class Error implements PokemonListState, GenericError {
  const Error(this.type);

  @override
  final GenericErrorType type;

}