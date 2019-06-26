class Dish {
  String _imageURL;
  String _name;
  String _price;
  String _categories;

  Dish();

  set imageURL(String url) {
    _imageURL = url;
  }

  String get imageURL => _imageURL;

  set name(String a) {
    _name = a;
  }

  String get name => _name;

  set price(String b) {
    _price = b;
  }

  String get price => _price;

  set categories(String c) {
    _categories = c;
  }

  String get categories => _categories;

  @override
  String toString() {
    // TODO: implement toString
    return 'image: $imageURL, name: $name, price: $price, categories: $categories';
  }

  // Dish({this.imageURL, this.name, this.price, this.categories});
}
