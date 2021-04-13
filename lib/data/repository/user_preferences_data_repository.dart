import 'package:domain/data_repository/user_preferences_data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:poke_dapp/data/cache/data_source/user_preferences_cds.dart';

class UserPreferencesRepository extends UserPreferencesDataRepository {
  UserPreferencesRepository({
    @required this.userPreferencesCDS,
  }) : assert(userPreferencesCDS != null);

  final UserPreferencesCDS userPreferencesCDS;

  @override
  Future<String> getThemePreference() =>
      userPreferencesCDS.getThemePreference();

  @override
  Future<void> updateThemePreference(String themePreference) =>
      userPreferencesCDS.upsertThemePreference(themePreference);
}
