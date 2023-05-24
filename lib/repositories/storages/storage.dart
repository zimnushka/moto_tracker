// type ids:
// geo storage - 0

import 'package:bike_tracker/models/geo_location.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  /// Register storages
  static Future<void> init() async {
    // Get app dir for init Hive
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    if (!Hive.isAdapterRegistered(GeoLocationAdapter().typeId)) {
      Hive.registerAdapter(GeoLocationAdapter());
    }
  }
}

abstract class StorageSingle<T> {
  String get boxName => '';

  Future<T?> read();

  Future<void> update(T item);

  Future<void> delete();

  Future<void> clear();
}

abstract class StorageMulty<T> {
  String get boxName => '';

  Future<List<T>> readAll();

  Future<void> add(T item);

  Future<void> update(T item);

  Future<void> delete(T item);

  Future<void> clear();
}
