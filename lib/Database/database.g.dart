// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDAO _cartDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cart` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `product_id` INTEGER NOT NULL, `restaurant_id` INTEGER NOT NULL, `product_count` INTEGER, `unit_price` REAL, `picture` TEXT, `name` TEXT, `restaurant_name` TEXT)');
      },
    );
  }

  @override
  CartDAO get cartDao {
    return _cartDaoInstance ??= _$CartDAO(database, changeListener);
  }
}

class _$CartDAO extends CartDAO {
  _$CartDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'cart',
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'product_id': item.product_id,
                  'restaurant_id': item.restaurant_id,
                  'product_count': item.product_count,
                  'unit_price': item.unit_price,
                  'picture': item.picture,
                  'name': item.name,
                  'restaurant_name': item.restaurant_name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _cartMapper = (Map<String, dynamic> row) => Cart(
      row['id'] as int,
      row['product_id'] as int,
      row['restaurant_id'] as int,
      row['product_count'] as int,
      row['unit_price'] as double,
      row['picture'] as String,
      row['name'] as String,
      row['restaurant_name'] as String);

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  @override
  Future<void> insertIntoCart(
      int productId,
      int restaurantId,
      int productCount,
      double unitPrice,
      String picture,
      String name,
      String restaurantName) async {
    await _queryAdapter.queryNoReturn(
        'INSERT INTO cart (product_id, restaurant_id, product_count, unit_price, picture, name, restaurant_name) VALUES (? ? ? ? ? ? ?)',
        arguments: <dynamic>[
          productId,
          restaurantId,
          productCount,
          unitPrice,
          picture,
          name,
          restaurantName
        ]);
  }

  @override
  Future<List<Cart>> getCart() async {
    return _queryAdapter.queryList('SELECT * FROM cart', mapper: _cartMapper);
  }

  @override
  Future<Cart> deleteCart(int id) async {
    return _queryAdapter.query('DELETE FROM cart WHERE id = ?',
        arguments: <dynamic>[id], mapper: _cartMapper);
  }

  @override
  Future<void> increaseCartItem(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE cart set product_count = product_count + 1 WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> decreaseCartItem(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE cart set product_count = product_count - 1 WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> clearCart() async {
    await _queryAdapter.queryNoReturn('DELETE FROM cart');
  }

  @override
  Future<void> insertCart(Cart cart) async {
    await _cartInsertionAdapter.insert(cart, sqflite.ConflictAlgorithm.abort);
  }
}
