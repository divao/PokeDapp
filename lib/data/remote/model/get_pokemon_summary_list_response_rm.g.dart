// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pokemon_summary_list_response_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPokemonSummaryListResponseRM _$GetPokemonSummaryListResponseRMFromJson(
    Map<String, dynamic> json) {
  return GetPokemonSummaryListResponseRM(
    results: (json['results'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    count: json['count'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
  );
}

Map<String, dynamic> _$GetPokemonSummaryListResponseRMToJson(
        GetPokemonSummaryListResponseRM instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
