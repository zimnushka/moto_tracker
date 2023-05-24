import 'package:bike_tracker/models/geo_location.dart';
import 'package:bike_tracker/repositories/storages/storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GeoStorage implements StorageMulty<GeoLocation> {
  static const _boxName = 'geo_storage';

  @override
  String get boxName => _boxName;

  @override
  Future<void> add(item) async {
    final box = await Hive.openBox<GeoLocation>(boxName);
    await box.add(item);
    return;
  }

  @override
  Future<void> delete(item) async {
    final box = await Hive.openBox<GeoLocation>(boxName);
    item.delete();
  }

  @override
  Future<List<GeoLocation>> readAll() async {
    final box = await Hive.openBox<GeoLocation>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> update(item) async {
    final box = await Hive.openBox<GeoLocation>(boxName);
  }

  @override
  Future<void> clear() async {
    final box = await Hive.openBox<GeoLocation>(boxName);
    await box.clear();
  }
}
