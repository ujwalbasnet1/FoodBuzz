import 'package:floor/floor.dart';

@Entity(tableName: 'cart')
class Cart {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'product_id', nullable: false)
  int product_id;

  @ColumnInfo(name: 'restaurant_id', nullable: false)
  int restaurant_id;

  @ColumnInfo(name: 'product_count')
  int product_count;

  @ColumnInfo(name: 'unit_price')
  double unit_price;

  @ColumnInfo(name: 'picture')
  String picture;

  @ColumnInfo(name: 'name')
  String name;

  @ColumnInfo(name: 'restaurant_name')
  String restaurant_name;

  Cart(
    this.id,
    this.product_id,
    this.restaurant_id,
    this.product_count,
    this.unit_price,
    this.picture,
    this.name,
    this.restaurant_name,
  );

  Cart.withNoID({
    this.product_id,
    this.restaurant_id,
    this.product_count,
    this.unit_price,
    this.picture,
    this.name,
    this.restaurant_name,
  });

  dynamic toJSON() {
    return {
      'product_id': product_id,
      'restaurant_id': restaurant_id,
      'unit_price': unit_price,
      'product_count': product_count,
    };
  }
}
