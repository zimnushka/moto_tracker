import 'package:bike_tracker/models/geo_location.dart';
import 'package:bike_tracker/repositories/storages/geo_storage.dart';
import 'package:bike_tracker/repositories/storages/storage.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (task, inputData) async {
      if (task == GeoBackgroundService._testTask) {
        await StorageService.init();
        await GeoStorage().add(GeoLocation(date: DateTime.now()));
      }
      return Future.value(true);
    },
  );
}

class GeoBackgroundService {
  static const _testTask = 'geoBackgroundTask';
  static const _uniqueName = 'geoBackgroundTask23428589674';

  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static Future<void> start() async {
    await Workmanager().registerPeriodicTask(
      _uniqueName,
      _testTask,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 20),
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ),
    );
  }

  static Future<void> stop() async {
    await Workmanager().cancelByUniqueName(_uniqueName);
  }
}
