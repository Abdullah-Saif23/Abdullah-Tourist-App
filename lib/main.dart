import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/Home/Admin/Places/editPlaces.dart';
import 'package:tourism/Home/Admin/Places/places.dart';
import 'package:tourism/Home/Admin/adminHome.dart';
import 'package:tourism/Home/Guide/guideHome.dart';
import 'package:tourism/Home/Guide/guideNavBar.dart';
import 'package:tourism/Home/User/UserHomePage.dart';
import 'package:tourism/Home/User/dashboard_core_screen.dart';
import 'package:tourism/Home/User/details.dart';
import 'package:tourism/OnBoarding/onBoarding_Screen.dart';
import 'package:tourism/auth/forgotPassword.dart';
import 'package:tourism/auth/signUp.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/auth/usertype.dart';
import 'package:tourism/const/const.dart';
import 'package:tourism/splash/splash_screen.dart';

Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
         options: FirebaseOptions(
             apiKey: "AIzaSyDTsFe7Nai947aCjHKrfanqbTdcEd5pTi8",
             appId: "1:305638471088:android:8fadc6688a7e8e2feb1275",
             messagingSenderId: "305638471088",
             projectId: "tourism-app-67c12",
            storageBucket: "gs://tourism-app-67c12.appspot.com"

         )
   );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String? email, password, uid, userType;


  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('userEmail');
      password =  prefs.getString('userPassword');
      uid = prefs.getString('userId');
      userType = prefs.getString('userType');
    });
    print(email.toString());
    print(password.toString());
    print(uid.toString());
    print(userType.toString());

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Utilizing innovative technologies to promote cultural tourism',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: onbText),
        useMaterial3: true,
      ),
      home: email != null && password != null && userType == 'User' ? AppBottomNavigationBar(userType: userType.toString())
          : email != null && password != null && userType == 'Admin' ? AdminHomePage(userType: userType.toString())
          : email != null && password != null && userType == 'Guide' ? GuideNqavBar(userType: userType.toString())
          : SplashScreen(),

      // home:  UserType(),
    );
  }
}





