import 'package:hive_flutter/hive_flutter.dart';

part 'geo_location.g.dart';

@HiveType(typeId: 0)
class GeoLocation extends HiveObject {
  @HiveField(0)
  final DateTime date;

  GeoLocation({required this.date});
}
