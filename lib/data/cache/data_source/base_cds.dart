import 'package:hive/hive.dart';

abstract class BaseCDS {
  Future<void> migrateData();

  Future<void> deleteBox(String boxKey) => Hive.deleteBoxFromDisk(boxKey);
}
