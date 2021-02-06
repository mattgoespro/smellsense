import 'package:flutter/material.dart';
import 'package:smellsense/screens/widgets/app-bar.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 100,
                bottom: 20,
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Smell',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: Theme.of(context).textTheme.headline3.fontSize,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sense',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                        fontSize:
                            Theme.of(context).textTheme.headline3.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: RaisedButton(
                child: Text('Train'),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/view-training-progress'),
              ),
            ),
            SizedBox(
              width: 100,
              child: RaisedButton(
                child: Text('Progress'),
                onPressed: () => {},
              ),
            ),
            SizedBox(
              width: 100,
              child: RaisedButton(
                child: Text('Settings'),
                onPressed: () => {},
              ),
            ),
            SizedBox(
              width: 100,
              child: RaisedButton(
                child: Text('About'),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
