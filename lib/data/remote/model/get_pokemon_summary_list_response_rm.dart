import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:poke_dapp/data/remote/model/pokemon_summary_rm.dart';

part 'get_pokemon_summary_list_response_rm.g.dart';

@JsonSerializable()
class GetPokemonSummaryListResponseRM {
  GetPokemonSummaryListResponseRM({
    @required this.results,
    this.count,
    this.next,
    this.previous,
  }) : assert(results != null);

  static const fromJson = _$GetPokemonSummaryListResponseRMFromJson;

  final int count;
  final String next;
  final String previous;
  final List<Map<String, dynamic>> results;

  Map<String, dynamic> toJson() =>
      _$GetPokemonSummaryListResponseRMToJson(this);
}
