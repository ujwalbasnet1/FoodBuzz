import 'package:meta/meta.dart';

class Category {
  String id;
  String name;

  Category({@required this.id, @required this.name});

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}
