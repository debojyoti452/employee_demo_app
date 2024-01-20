import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/db/database_helper.dart';
import '../service/navigation_service.dart';

@module
abstract class ServiceModule {
  @singleton
  NavigationService get navigationService => NavigationService();

  @singleton
  DatabaseHelper get databaseHelper => DatabaseHelper();
}
