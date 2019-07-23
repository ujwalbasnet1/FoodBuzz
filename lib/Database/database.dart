import 'dart:async';
import 'package:floor/floor.dart';
import 'package:food_buzz/Database/Cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'CartDAO.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Cart])
abstract class AppDatabase extends FloorDatabase {
  CartDAO get cartDao;
}
