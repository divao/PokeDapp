abstract class UserPreferencesDataRepository {
  Future<String> getThemePreference();

  Future<void> updateThemePreference(String themePreference);
}