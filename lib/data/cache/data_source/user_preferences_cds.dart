import 'dart:async';

import 'package:hive/hive.dart';
import 'package:poke_dapp/data/cache/data_source/base_cds.dart';

class UserPreferencesCDS extends BaseCDS {
  static const _themePreferenceBoxKey = '_themePreferenceBoxKey';

  @override
  Future<void> migrateData() {
    throw UnimplementedError();
  }

  Future<String> getThemePreference() =>
      Hive.openBox<String>(_themePreferenceBoxKey).then(
            (box) => box.get(0),
      );

  Future<void> upsertThemePreference(String themePreference) =>
      Hive.openBox<String>(_themePreferenceBoxKey).then(
            (box) => box.put(0, themePreference),
      );
}
