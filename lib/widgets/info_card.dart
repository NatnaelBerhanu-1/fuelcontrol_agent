import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget{
  final title;
  final desc;
  final icon;


  InfoCard({@required this.title,@required this.desc, this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.only(bottom:15.0, left: 5.0, right: 5.0),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
            begin:Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                ),
                Text(
                  '$desc',
                  style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                ),
              ],
            ),
            icon!=null?icon:SizedBox()
          ],
        ),
      ),
    );
  }
}