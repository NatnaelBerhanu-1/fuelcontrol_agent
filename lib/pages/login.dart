import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/pages/mainpage.dart';
import 'package:fuelcontrolseller/utils/constants.dart';
import 'package:fuelcontrolseller/viewModels/screens/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final gradientColor = [
    Color(0xFFF22613),
    Color(0xFFF34C3D),
  ];

  String email = '', password = '', emailError, passwordError;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
        child: _buildLoginPage(context)
    );
  }

  Widget _buildLoginPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(children: <Widget>[
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150))),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(left: 80, bottom: 40, right: 20),
                    child: Text(
                      'Welcome Please Signin to continue',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    Consumer<LoginViewModel>(
                        builder: (context, loginViewModel, child) => loginViewModel.loginState == ViewState.Error? Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Error try again',
                              style: TextStyle(
                                  color: Colors.red
                              ),
                            ),
                          ),
                        ): Container()
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 42.0, bottom: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              emailError = null;
                            });
                          }
                          setState(() {
                            email = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: emailError,
                          hintText: 'email',
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              passwordError = null;
                            });
                          }
                          setState(() {
                            password = value;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText: passwordError,
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2.0),
                          ),
                          hintText: 'password',
                          hintStyle:
                          TextStyle(color: Theme.of(context).buttonColor),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white70, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 10.0),
                height: 52.0,
                width: MediaQuery.of(context).size.width,
                child: Consumer<LoginViewModel>(
                  builder: (context, loginViewModel, child) => FlatButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () async {
                      if (email == null || email == '') {
                        setState(() {
                          emailError = 'field required';
                        });
                        return;
                      } else if (!(email.contains("@") &&
                          email.contains(".com"))) {
                        setState(() {
                          emailError = 'invalid email';
                        });
                        return;
                      }
                      if (password == null || password == '') {
                        setState(() {
                          passwordError = 'field required';
                        });
                        return;
                      } else if (password.length < 4) {
                        setState(() {
                          passwordError = 'min length for password is 4';
                        });
                        return;
                      }
                      User user = User();
                      user.email = email;
                      user.password = password;
                      var login = await loginViewModel.login(user);
                      if(login){
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => MainPage()), (Route<dynamic> route)=>false);
                      }else{
                        print('login error');
                      }
                    },
                    child: Consumer<LoginViewModel>(
                      builder: (context, loginViewModel, child) => loginViewModel.loginState == ViewState.Busy ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ): Text(
                        'signin',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: (){ launch('https://zowitech.com/resetpassword');},child: Text(
                      'forgot password',
                      style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).primaryColorLight, fontSize: 16.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
