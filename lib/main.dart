import 'package:bike_tracker/models/geo_location.dart';
import 'package:bike_tracker/repositories/storages/geo_storage.dart';
import 'package:bike_tracker/repositories/storages/storage.dart';
import 'package:bike_tracker/services/geo_background.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive
  await StorageService.init();
  // init background service
  await GeoBackgroundService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GeoLocation> locations = [];

  @override
  void initState() {
    GeoStorage().readAll().then(
          (value) => setState(
            () {
              locations = value;
            },
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                GeoStorage().clear();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final item = locations[index];
          return Text(item.date.toIso8601String());
        },
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: GeoBackgroundService.start,
        child: Icon(
          Icons.bug_report_outlined,
          size: 40,
        ),
      ),
    );
  }
}
