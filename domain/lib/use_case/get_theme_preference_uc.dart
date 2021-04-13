import 'package:domain/data_repository/user_preferences_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:meta/meta.dart';

class GetThemePreferenceUC extends UseCase<void, String> {
  GetThemePreferenceUC({
    @required this.repository,
    @required ErrorLogger logger,
  })  : assert(repository != null),
        assert(logger != null),
        super(logger: logger);

  final UserPreferencesDataRepository repository;

  @override
  Future<String> getRawFuture({void params}) => repository.getThemePreference();
}
