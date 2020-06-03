import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/pages/splash.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuel Control Agent',
      theme: ThemeData(
          primaryColor: Color(0xFFF22613),
          primaryColorLight: Color(0xFFF34C3D),
          backgroundColor: Color(0xFF2B2B2B),
          buttonColor: Color(0xFF707070),
          accentColor: Color(0xFFF29513),
          hintColor: Color(0xFF006FFF),
          textTheme: TextTheme(
            title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            subtitle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
            body1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
          )
      ),
      home: SplashScreen(),
    );
  }
}


