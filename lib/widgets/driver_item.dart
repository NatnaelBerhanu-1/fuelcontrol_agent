import 'package:flutter/material.dart';
import 'package:fuelcontrolseller/models/models.dart';
import 'package:fuelcontrolseller/pages/driverdesc.dart';

class DriverItem extends StatelessWidget{
  Driver driver;

  DriverItem({@required this.driver});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverDescPage(driver: this.driver,)));
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(left: 8.0),
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${this.driver.name}',
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0),
            ),
            Text(
              '${this.driver.email}',
              style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).buttonColor).copyWith(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}