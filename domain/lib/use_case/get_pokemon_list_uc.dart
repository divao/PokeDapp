import 'package:domain/data_repository/pokemon_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/model/pokemon_summary.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class GetPokemonSummaryListUC extends UseCase<void, List<PokemonSummary>> {
  GetPokemonSummaryListUC(
      {@required this.repository, @required ErrorLogger logger})
      : assert(repository != null),
        assert(logger != null),
        super(logger: logger);

  final PokemonDataRepository repository;

  @override
  Future<List<PokemonSummary>> getRawFuture({void params}) =>
      repository.getPokemonSummaryList();
}