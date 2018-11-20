import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
          title: buildRect(150.0, 24.0, 5.0),
          subtitle: buildRect(150.0, 24.0, 5.0),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              buildRect(30.0, 10.0, 5.0),
            ],
          ),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildRect(double width, double height, double margin) {

    return Container(
      color: Colors.grey[200],
      height: height,
      width: width,
      margin: EdgeInsets.only(
          top: margin,
          bottom: margin,
      ),
    );
  }
}
