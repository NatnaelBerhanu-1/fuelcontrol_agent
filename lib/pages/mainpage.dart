import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/pages/driverdesc.dart';
import 'package:fuelcontrolseller/pages/drivers.dart';
import 'package:fuelcontrolseller/pages/home.dart';
import 'package:fuelcontrolseller/pages/payment.dart';
import 'package:fuelcontrolseller/pages/sales.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  num _currentPage = 0;
  String barcode;

  final titles = [
    "Home","Sales","Drivers"
  ];

  PageController _controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void _pageChanged(int value){
    setState(() {
      _currentPage = value;
    });
  }

  void _bottomNavClicked(int index){
    setState(() {
      _currentPage = index;
      _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            titles[_currentPage]
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              SharedPreferences preferences =
              await SharedPreferences.getInstance();
              preferences.remove("loggedIn");
              preferences.remove("loggedInEmail");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async{

          var result = await scan();
          print("barcode $barcode");

//          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPage()));
        },
        child: Image.asset(
          'assets/images/scanner_icon.png',
          width: 35.0,
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value){
          _pageChanged(value);
        },
        children: <Widget>[
          HomePage(),
          SalesPage(),
          DriversPage()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  _bottomNavClicked(0);
                },
                child: SizedBox(
                  height: 40.0,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: _currentPage==0?Theme.of(context).primaryColor:Theme.of(context).buttonColor,
                      ),
                      Text(
                        'home',
                        style: Theme.of(context).textTheme.body2.copyWith(color: _currentPage==0?Theme.of(context).primaryColor:Theme.of(context).buttonColor),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _bottomNavClicked(1);
                },
                child: SizedBox(
                  height: 40.0,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.local_gas_station,
                        color: _currentPage==1?Theme.of(context).primaryColor:Theme.of(context).buttonColor,
                      ),
                      Text(
                        'sales',
                        style: Theme.of(context).textTheme.body2.copyWith(color: _currentPage==1?Theme.of(context).primaryColor:Theme.of(context).buttonColor),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _bottomNavClicked(2);
                },
                child: SizedBox(
                  height: 40.0,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.drive_eta,
                        color: _currentPage==2?Theme.of(context).primaryColor:Theme.of(context).buttonColor,
                      ),
                      Text(
                        'drivers',
                        style: Theme.of(context).textTheme.body2.copyWith(color: _currentPage==2?Theme.of(context).primaryColor:Theme.of(context).buttonColor),
                      )
                    ],
                  ),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }

  Future scan() async {
    try{
//      ScanResult result = await BarcodeScanner.scan(options: ScanOptions(
//        restrictFormat: [
//          BarcodeFormat.qr
//        ],
//        android: AndroidOptions(
//          useAutoFocus: true
//        )
//      ));

      String result = await scanner.scan();

      setState(() {
        barcode = result;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPage(barcode: result)));
    } catch (e){
      print("unknown error: $e");
    }
  }
}