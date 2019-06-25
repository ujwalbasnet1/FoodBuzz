import 'package:flutter/material.dart';
import 'package:food_buzz/Models/Restaurant.dart';
import 'package:food_buzz/UIs/LocationPickerPage.dart';
import 'package:latlong/latlong.dart';

import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantRegistrationRepo.dart';

class RestaurantRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Image.asset(
            'assets/images/foodbuzz.jpg',
            width: 200,
          ),
          Text('Register as Restaurant',
              style: TextStyle(
                  color: Color(0XFFD22030),
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          _RestaurantRegistrationForm(),
        ],
      ),
    );
  }
}

class _RestaurantRegistrationForm extends StatefulWidget {
  @override
  __LoginformState createState() => __LoginformState();
}

class __LoginformState extends State<_RestaurantRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _addressReceived = false;
  LatLng _latlng;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _textField(hintText: 'Name', controller: nameController),
                  SizedBox(height: 10),
                  _textField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 10),
                  _textField(
                      hintText: 'Password',
                      controller: passwordController,
                      obsecureText: true),
                  SizedBox(height: 10),
                  _textField(
                      hintText: 'Address', controller: addressController),
                  SizedBox(height: 10),
                  _textField(
                      hintText: 'Phone number',
                      controller: phoneNumberController),
                  SizedBox(height: 10),
                  _textField(
                      hintText: 'Description',
                      controller: descriptionController,
                      minLine: 6,
                      maxLine: 9),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                      textColor: Colors.white,
                      color: _addressReceived ? Colors.green : Colors.black,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(_addressReceived
                                ? Icons.check
                                : Icons.location_on),
                            SizedBox(width: 10),
                            Text(_addressReceived
                                ? 'Location Picked'
                                : 'Pick a Location')
                          ]),
                      onPressed: () async {
                        //  open a dialog for location picking
                        _latlng = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationPicker()));

                        if (_latlng != null) {
                          setState(() {
                            _addressReceived = true;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                      textColor: Colors.white,
                      color: Color(0XFFD22030),
                      child: Text('Register'),
                      onPressed: () {
                        // dispatch
                        if (_latlng == null) {
                          _latlng = new LatLng(0, 0);
                        }

                        Restaurant _newRestaurant = new Restaurant(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            address: addressController.text,
                            phoneNumber: phoneNumberController.text,
                            description: descriptionController.text,
                            lat: _latlng.latitude.toString(),
                            lng: _latlng.longitude.toString());

                        // newRestaurant

                        // repository call
                        print('\n\n\n\n\n\n\nRegistration Button Clicked' +
                            _newRestaurant.toJSON().toString());
                        RestaurantRegistrationRepo()
                            .register(restaurant: _newRestaurant);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Forgot your login details?',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          ' Get help signing in',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(
      {String hintText = '',
      bool obsecureText = false,
      @required var controller,
      int minLine = 1,
      int maxLine = 1}) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Colors.black54,
            )),
        hintText: hintText,
      ),
    );
  }
}
