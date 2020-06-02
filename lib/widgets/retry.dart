import 'package:flutter/material.dart';

class Retry extends StatelessWidget{
  Function callback;
  Retry({@required this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Something went wrong\ntry again',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            child: FlatButton(
              color: Theme.of(context).accentColor,
              onPressed: (){
                callback();
              },
              child: Text(
                'retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}