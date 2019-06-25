import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

  File _image;
  double _uploadedPercent = 0;
  bool _progressing = false;
  List<Map<String, String>> totalCategories;
  List<Map<String, String>> addedCategories;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void uploadPic() {
    Dio dio = new Dio();

    FormData formdata = new FormData(); // just like JS

    formdata.add("myFile", new UploadFileInfo(_image, (_image.path)));
    dio.post(
      Constant.baseURL + "file",
      data: formdata,
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
    ).then((response) {
      print(response);
      setState(() {
        _progressing = false;
      });
    }).catchError((error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 250),
          ),
        );
      });
    });
  }

  void addCategories({@required String index}) {
    Map<String, String> temp = new HashMap();
    // temp[index] = totalCategories.elementAt(index);

    addedCategories.add();
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
            obscureText: true,
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
            obscureText: true,
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
          DropdownButton(
            items: List.generate(totalCategories.length, (index) {
              return DropdownMenuItem(value: 1, child: Text('123'));
            }),
            onChanged: (int index) {
              addCategories(index: index);
            },
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
              },
            ),
          )
        ],
      ),
    ));
  }
}
