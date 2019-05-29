import 'package:flutter/material.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationBloc.dart';
import 'package:food_buzz/Blocs/Login/LoginBloc.dart';
import 'package:food_buzz/Blocs/Login/LoginEvent.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/AuthenticationRepo.dart';

class LoginPage extends StatelessWidget {
  final bool isRestaurant;
  final AuthenticationRepo authenticationRepo;

  LoginPage({@required this.isRestaurant, @required this.authenticationRepo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: ListView(
        children: <Widget>[
          // SizedBox(height: 50),
          Image.asset(
            'assets/images/foodbuzz.jpg',
            width: 200,
          ),
          _LoginForm(
            isRestaurant: isRestaurant,
            authenticationRepo: authenticationRepo,
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final bool isRestaurant;
  final AuthenticationRepo authenticationRepo;

  _LoginForm({@required this.isRestaurant, @required this.authenticationRepo});

  @override
  __LoginformState createState() => __LoginformState();
}

class __LoginformState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    _authenticationBloc =
        AuthenticationBloc(authenticationRepo: widget.authenticationRepo);

    _loginBloc = LoginBloc(
      authenticationRepo: widget.authenticationRepo,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _text = (widget.isRestaurant) ? 'Restaurant Id' : 'Email';

    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.black54,
                      )),
                  hintText: _text,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Colors.black54,
                      )),
                  hintText: 'Password',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                  textColor: Colors.white,
                  color: Color(0XFFD22030),
                  child: Text('Log In'),
                  onPressed: () {
                    // dispatch
                    _loginBloc.dispatch(LoginButtonPressed(
                        username: usernameController.text,
                        password: passwordController.text,
                        isRestaurant: widget.isRestaurant));
                  },
                ),
              ),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              // _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    if (!widget.isRestaurant) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              'OR',
              style:
                  TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            color: Color(0XFFeeeeee),
            elevation: 6,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 62),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/googleicon.png',
                  width: 24,
                  height: 24,
                ),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onPressed: () {},
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
