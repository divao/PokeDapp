import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_summary_rm.g.dart';

@JsonSerializable()
class PokemonSummaryRM {
  PokemonSummaryRM({@required this.name, @required this.url})
      : assert(name != null),
        assert(url != null);

  static const fromJson = _$PokemonSummaryRMFromJson;

  final String name;
  final String url;

  Map<String, dynamic> toJson() => _$PokemonSummaryRMToJson(this);
}
