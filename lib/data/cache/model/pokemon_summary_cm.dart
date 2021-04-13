import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pokemon_summary_cm.g.dart';

@HiveType(typeId: 1)
class PokemonSummaryCM {
  PokemonSummaryCM({@required this.name, @required this.url})
      : assert(name != null),
        assert(url != null);

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;
}
