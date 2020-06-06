import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/pages/login.dart';
import 'package:fuelcontrolseller/pages/mainpage.dart';
import 'package:fuelcontrolseller/viewModels/screens/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
//    var task = Future.delayed(Duration(seconds: 3), (){
//      return true;
//    });
    sharedPreferences.then((sharedPreferences){
      if (sharedPreferences.get('loggedIn') == 'true') {
        var data = Provider.of<HomeViewModel>(context, listen: false);
        var user = data.getUser(true).then((user){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainPage()), (Route<dynamic> route)=>false);
        });
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (Route<dynamic> route)=>false);
      }
    });
//    task.then((value){
//      sharedPreferences.then((sharedPreferences){
//        if (sharedPreferences.get('loggedIn') == 'true') {
//          var data = Provider.of<HomeViewModel>(context);
//          var user = data.getUser(false).then((user){
//            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainPage()), (Route<dynamic> route)=>false);
//          });
//        }else{
//          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (Route<dynamic> route)=>false);
//        }
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/british_flag.png',
              width: 100.0,
            ),
            Text(
              'Fuel Control Seller'
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}