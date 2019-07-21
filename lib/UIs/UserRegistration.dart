import 'package:flutter/material.dart';
import 'package:food_buzz/Models/Restaurant.dart';
import 'package:food_buzz/Models/User.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRegisterationRepo.dart';
import 'package:food_buzz/UIs/LocationPickerPage.dart';
import 'package:latlong/latlong.dart';

import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantRegistrationRepo.dart';

class UserRegistration extends StatelessWidget {
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
          Text('Register as User',
              style: TextStyle(
                  color: Color(0XFFD22030),
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          _UserRegistrationForm(),
        ],
      ),
    );
  }
}

class _UserRegistrationForm extends StatefulWidget {
  @override
  __LoginformState createState() => __LoginformState();
}

class __LoginformState extends State<_UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  bool _addressReceived = false;
  LatLng _latlng;
  String gender = '';

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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                      hint: Text((gender.length <= 0) ? 'Gender' : gender),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(child: Text('Male'), value: 0),
                        DropdownMenuItem(child: Text('Female'), value: 1),
                      ],
                      onChanged: (int value) {
                        setState(() {
                          gender = (value == 0) ? 'Male' : 'Female';
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                      textColor: Colors.white,
                      color: Color(0XFFD22030),
                      child: Text('Register'),
                      onPressed: () async {
//                         dispatch
                        if (_latlng == null) {
                          _latlng = new LatLng(0, 0);
                        }

                        User _newUser = new User(
                          name: nameController.text,
                          email: emailController.text,
                          gender: gender,
                          password: passwordController.text,
                          address: addressController.text,
                          phoneNumber: phoneNumberController.text,
                        );

                        // newUser

                        // repository call
                        print('\n\n\n\n\n\n\nRegistration Button Clicked' +
                            _newUser.toJSON().toString());

                        UserRegistrationRepo().register(user: _newUser);

                        print('\n\n\n\nEnd');
                      },
                    ),
                  ),
                  SizedBox(height: 10),
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
