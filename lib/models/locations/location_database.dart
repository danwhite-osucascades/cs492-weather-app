import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'location.dart';

const dbName = 'location.db';
const sqlCreateTablePath = 'assets/sql/create.sql';
const sqlInsertPath = 'assets/sql/insert.sql';
const sqlGetAllPath = 'assets/sql/get_all.sql';
const sqlDeletePath = 'assets/sql/delete.sql';

class LocationDatabase {
  final Database _db;

  LocationDatabase({required Database db}) : _db = db;

  // This should be called externally to create the database.
  static Future<LocationDatabase> open() async {
    // this will attempt to open the database and create the database if it doesn't exist
    final Database db = await openDatabase(dbName, version: 1,
        onCreate: (Database db, int version) async {
      // You can find this query in assets/sql/create.
      // It creates the location_entries table if it does not already exist.
      String query = await rootBundle.loadString(sqlCreateTablePath);
      await db.execute(query);
    });

    return LocationDatabase(db: db);
  }

  void close() async {
    await _db.close();
  }

  Future<List<Location>> getLocations() async {
    String query = await rootBundle.loadString(sqlGetAllPath);
    List<Map> locationEntries = await _db.rawQuery(query);
    List<Location> locations = [];
    for (final entry in locationEntries) {
      locations.add(Location.fromJson(Map<String, dynamic>.from(entry)));
    }
    return locations;
  }

  Future<void> insertLocation(Location location) async {
    await _db.transaction((txn) async {
      String query = await rootBundle.loadString(sqlInsertPath);

      List<dynamic> rawInsertParameters = [
        location.city,
        location.state,
        location.zip,
        location.country,
        location.latitude,
        location.longitude
      ];
      await txn.rawInsert(query, rawInsertParameters);
    });
  }

  Future<void> deleteLocation(Location location) async {
    await _db.transaction((txn) async {
      String query = await rootBundle.loadString(sqlDeletePath);

      List<dynamic> rawDeleteParameters = [location.zip];
      await txn.rawDelete(query, rawDeleteParameters);
    });
  }
}
