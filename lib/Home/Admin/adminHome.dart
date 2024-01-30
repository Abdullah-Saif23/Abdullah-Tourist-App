import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:tourism/Home/Admin/Places/places.dart';
import 'package:tourism/Home/Admin/Resturants/hotels.dart';
import 'package:tourism/Home/Admin/tourGuides.dart';
import 'package:tourism/Home/Admin/users.dart';
import 'package:tourism/Home/Cuisine/cuisine.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/auth/usertype.dart';
import 'package:tourism/const/const.dart';


class AdminHomePage extends StatefulWidget {
  final String userType;

  const AdminHomePage({super.key, required this.userType});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    return  Scaffold(
      body: Center(
        child: Container(
          height: devSize.height,
          width: devSize.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/w3.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: devSize.height*0.05,
              ),


              Container(
                alignment: Alignment.bottomCenter,
                height: devSize.height*0.08,
                width: devSize.width*0.8,
                child: Text('Administrator',style: TextStyle(color: onbText,fontSize:25,fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: devSize.height*0.07,
              ),


              Container(
                width: devSize.width*0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: devSize.width*0.028,
                    ),
                    FlipInY(
                      delay: Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Userss(userType: "User")));

                        },
                        child: GlassContainer(
                          color: bg1.withOpacity(0.3),
                          borderColor: Colors.transparent,
                          blur: 0,
                          elevation: 5,
                          isFrostedGlass: false,
                          shadowColor: bg1.withOpacity(0.1),
                          alignment: Alignment.center,
                          frostedOpacity: 1,
                          height: devSize.height*0.2,
                          width: devSize.width*0.4,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              Container(
                                  height: devSize.height*0.11,
                                  width: devSize.width*0.12,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/icons/user.png')
                              ),
                              Text("Users",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: onbText),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: devSize.width*0.05,
                    ),
                    FlipInY(
                      delay: Duration(milliseconds: 350),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TourGuides(userType: "Guide")));

                        },
                        child: GlassContainer(
                          color: bg1.withOpacity(0.3),
                          borderColor: Colors.transparent,
                          blur: 0,
                          elevation: 5,
                          isFrostedGlass: false,
                          shadowColor: bg1.withOpacity(0.1),
                          alignment: Alignment.center,
                          frostedOpacity: 1,
                          height: devSize.height*0.2,
                          width: devSize.width*0.4,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              Container(
                                  height: devSize.height*0.12,
                                  width: devSize.width*0.12,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/icons/guide.png')
                              ),
                              Text("Tourist Guide",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: onbText),),
                            ],
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ),
              SizedBox(
                height: devSize.height*0.03,
              ),
              Container(
                width: devSize.width*0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: devSize.width*0.028,
                    ),
                    FlipInY(
                      delay: Duration(milliseconds: 400),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Places()));

                        },
                        child: GlassContainer(
                          color: bg1.withOpacity(0.3),
                          borderColor: Colors.transparent,
                          blur: 0,
                          elevation: 5,
                          isFrostedGlass: false,
                          shadowColor: bg1.withOpacity(0.1),
                          alignment: Alignment.center,
                          frostedOpacity: 1,
                          height: devSize.height*0.2,
                          width: devSize.width*0.4,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              Container(
                                  height: devSize.height*0.11,
                                  width: devSize.width*0.12,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/icons/places.png')
                              ),
                              Text("Places",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: onbText),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: devSize.width*0.05,
                    ),
                    FlipInY(
                      delay: Duration(milliseconds: 450),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Hotels()));

                        },
                        child: GlassContainer(
                          color: bg1.withOpacity(0.3),
                          borderColor: Colors.transparent,
                          blur: 0,
                          elevation: 5,
                          isFrostedGlass: false,
                          shadowColor: bg1.withOpacity(0.1),
                          alignment: Alignment.center,
                          frostedOpacity: 1,
                          height: devSize.height*0.2,
                          width: devSize.width*0.4,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              Container(
                                  height: devSize.height*0.12,
                                  width: devSize.width*0.12,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/icons/hotels.png')
                              ),
                              Text("Resturants",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: onbText),),
                            ],
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ),


              SizedBox(
                height: devSize.height*0.03,
              ),
              FlipInY(
                delay: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cuisine()));

                  },
                  child: GlassContainer(
                    color: bg1.withOpacity(0.3),
                    borderColor: Colors.transparent,
                    blur: 0,
                    elevation: 5,
                    isFrostedGlass: false,
                    shadowColor: bg1.withOpacity(0.1),
                    alignment: Alignment.center,
                    frostedOpacity: 1,
                    height: devSize.height*0.2,
                    width: devSize.width*0.4,
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        Container(
                            height: devSize.height*0.11,
                            width: devSize.width*0.12,
                            alignment: Alignment.center,
                            child: Image.asset('assets/icons/cuisine.png')
                        ),
                        Text("Cuisine",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: onbText),),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                width: devSize.width*0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                        shape: CircleBorder(),
                        backgroundColor: bg2.withOpacity(0.6),
                        foregroundColor: Colors.black,
                        onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserType()));

                    },
                    child: Image.asset("assets/icons/logout.png",height: 40,width: 40,),
                    ),
                  ],
                ),
              ),


            ],
          ),

        ),
      ),
    );
  }
}
