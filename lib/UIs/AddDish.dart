import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:food_buzz/Models/Category.dart';
import 'package:food_buzz/Models/Dish.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/Repo.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantProfileRepo.dart';

import 'package:image_picker/image_picker.dart';

import '../const.dart';

class AddDish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddDishForm(),
      appBar: AppBar(
        title: Text('Add Dish'),
        backgroundColor: Color(0XFFD22030),
      ),
    );
  }
}

class AddDishForm extends StatefulWidget {
  @override
  _AddDishFormState createState() => _AddDishFormState();
}

class _AddDishFormState extends State<AddDishForm> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  // pictureController;

  Dish _dish = new Dish();
  File _image;
  double _uploadedPercent = 0;
  bool _progressing = false;
  bool _dishAdded = false;

  List<Category> totalCategories = new List<Category>();
  List<Category> addedCategories = new List<Category>();

  String _addedCategoriesId = '';
  String _addedCategoriesName = '';

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void uploadPic() {
    Dio dio = new Dio();

    FormData formData = new FormData(); // just like JS

    formData.add("myFile", new UploadFileInfo(_image, (_image.path)));

    dio.post(
      Constant.baseURL + "file",
      data: formData,
      options: Options(
          method: 'POST',
          responseType: ResponseType.json // or ResponseType.JSON
          ),
      onSendProgress: (int sent, int total) {
        setState(() {
          _progressing = true;
          _uploadedPercent = (sent / total);
        });
      },
    ).then((Response response) {
      _dish.imageURL = (response.data['URL']);
      setState(() {
        _progressing = false;
      });
    }).catchError((error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1000),
          ),
        );
      });
    });
  }

  void addCategories({@required Category category}) {
    setState(() {
      if (addedCategories.length >= 1) {
        _addedCategoriesId += ', ' + category.id;
        _addedCategoriesName += ', ' + category.name;
      } else {
        _addedCategoriesId += category.id;
        _addedCategoriesName += category.name;
      }
      addedCategories.add(category);
      totalCategories.remove(category);
    });
  }

  @override
  void initState() {
    super.initState();
    Repo().getCategories().then((List<Category> categories) {
      for (int i = 0; i < categories.length; i++) {
        setState(() {
          totalCategories.add(categories[i]);
        });
      }

      for (int i = 0; i < totalCategories.length; i++) {
        print(totalCategories[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (_image == null) getImage();
                },
                onDoubleTap: () {
                  getImage();
                },
                child: Container(
                  height: 250,
                  color: Colors.black12,
                  child: Center(
                    child: _image == null
                        ? Icon(Icons.add_a_photo,
                            size: 72, color: Color(0XFFD22030))
                        : Image.file(_image, fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  child: _progressing
                      ? LinearProgressIndicator(value: _uploadedPercent)
                      : Container(),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.black54,
                  )),
              hintText: 'Name',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.black54,
                  )),
              hintText: 'Price',
            ),
          ),
          SizedBox(height: 20),
          // categories list
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment(0, 0),
            child: DropdownButton(
              isExpanded: false,
              hint: Text('Add Categories'),
              items: List.generate(totalCategories.length, (index) {
                return DropdownMenuItem(
                    value: totalCategories[index],
                    child: Text(totalCategories[index].name));
              }),
              onChanged: (Category category) {
                addCategories(category: category);
              },
            ),
          ),
          SizedBox(height: 20),
          // added categories
          Text(
            (_addedCategoriesName.length <= 0)
                ? 'Categories Name'
                : _addedCategoriesName,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
              textColor: Colors.white,
              color: Color(0XFFD22030),
              child: Text('ADD'),
              onPressed: () {
                uploadPic();
                _dish.name = nameController.text;
                _dish.price = priceController.text;
                _dish.categories = _addedCategoriesId;
                print(_dish);
                RestaurantProfileRepo(authenticationRepo: AuthenticationRepo())
                    .addDish(dish: _dish)
                    .then((message) {
                  if (message == 'Dish was added to your restaurant.') {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message.toString()),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    });
                    Future.delayed(Duration(milliseconds: 1000), () {
                      Navigator.pop(context);
                    });
                  }
                  print('message from repo \n\n' + message.toString());
                }).catchError((error) {
                  print('error from respos \n\n' + error.toString());
                });
              },
            ),
          )
        ],
      ),
    ));
  }
}
