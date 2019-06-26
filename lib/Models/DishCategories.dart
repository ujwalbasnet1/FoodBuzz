class DishCategories {
  String category;
  List<DishCategoryItem> dishes;

  DishCategories() {
    category = '';
    dishes = [];
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{category: $category, dishes: $dishes}';
  }
}

class DishCategoryItem {
  String id;
  String restaurantId;
  String name;
  String price;
  String picture;
  String categoryId;

  DishCategoryItem({
    this.id,
    this.restaurantId,
    this.name,
    this.price,
    this.picture,
    this.categoryId,
  });

  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, restaurant_id: $restaurantId, name: $name, price: $price, picture: $picture, category_id: $categoryId}';
  }
}
