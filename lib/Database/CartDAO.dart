import 'package:floor/floor.dart';
import 'package:food_buzz/Database/Cart.dart';

@dao
abstract class CartDAO {
  @insert
  Future<void> insertCart(Cart cart);

  @Query(
      'INSERT INTO cart (product_id, restaurant_id, product_count, unit_price, picture, name, restaurant_name) VALUES (:productId, :restaurantId, :productCount, :unitPrice, :picture, :name, :restaurantName)')
  Future<void> insertIntoCart(
    int productId,
    int restaurantId,
    int productCount,
    double unitPrice,
    String picture,
    String name,
    String restaurantName,
  );

  @Query('SELECT * FROM cart')
  Future<List<Cart>> getCart();

  @Query('DELETE FROM cart WHERE id = :id')
  Future<Cart> deleteCart(int id);

  @Query('UPDATE cart set product_count = product_count + 1 WHERE id = :id')
  Future<void> increaseCartItem(int id);

  @Query('UPDATE cart set product_count = product_count - 1 WHERE id = :id')
  Future<void> decreaseCartItem(int id);

  @Query('DELETE FROM cart')
  Future<void> clearCart();
}
