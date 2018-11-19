import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return Container(
          height: 80.0,
          child: FutureBuilder(
              future: getFuture(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Text('Im visible $index')
                    : Text('I havent fetched data yet $index');
              }),
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'Hi',
    );
  }
}
