import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tourism/OnBoarding/onBoarding_Screen.dart';
import 'package:tourism/const/const.dart';


class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OnBoarding()));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: InkWell(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                //  color: Colors.white,
                width: deviceSize.width,
                height: deviceSize.height,
                child: Image.asset(
                  'assets/images/w3.png',
                  // height: deviceSize.height,
                  // width: deviceSize.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0,bottom: 70),
                child: FadeInLeft(
                  delay: Duration(seconds: 1),
                  child: Container(
                    width: deviceSize.width*0.8,
                    child: Text("Not all those who wander are lost.",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: onbText),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
