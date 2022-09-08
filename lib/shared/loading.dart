// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(
              child: SpinKitFoldingCube(
                color: Colors.deepPurple,
                size: 50.0,
              ),
            ),
            HeightBox(30),
            Text(
              'Loading...\nThis may take a while',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
