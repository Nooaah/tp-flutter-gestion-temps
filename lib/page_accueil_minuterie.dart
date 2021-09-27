import 'package:flutter/material.dart';

class PageAccueilMinuterie extends StatelessWidget {
  const PageAccueilMinuterie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma gestion du temps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ma gestion du temps',
            ),
          ],
        ),
      ),
    );
  }
}
