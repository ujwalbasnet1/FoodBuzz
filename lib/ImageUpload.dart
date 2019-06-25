import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

import 'const.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload>
    with SingleTickerProviderStateMixin {
  File _image;
  double _uploadedPercent = 0;

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
    dio
        .post(
          Constant.baseURL + "file",
          data: formdata,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json // or ResponseType.JSON
              ),
          onSendProgress: (int sent, int total) {
            setState(() {
              _uploadedPercent = (sent / total);
            });
          },
        )
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
          RaisedButton(
            onPressed: () {
              uploadPic();
            },
            child: Text('UPload'),
          ),
          LinearProgressIndicator(
            value: _uploadedPercent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
