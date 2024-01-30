import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/const/const.dart';


class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {

  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width: devSize.width*1,
            height: devSize.height*1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/w3.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: devSize.height*0.25,
                ),


                Container(
                  alignment: Alignment.bottomCenter,
                  height: devSize.height*0.08,
                  width: devSize.width*0.8,
                  child: Text('Select user type',style: TextStyle(color: onbText,fontSize:25,fontWeight: FontWeight.w600),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: "Admin")));

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
                                    child: Image.asset('assets/icons/admin.png')
                                ),
                                Text("Admin",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: onbText),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: devSize.width*0.05,
                      ),
                      FlipInY(
                        delay: Duration(milliseconds: 300),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: "Guide")));

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
                                Text("Tourist Guide",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: onbText),),
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
                  delay: Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: "User")));

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
                          Text("User",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: onbText),),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),


          ),
        ),
      ),


    );
  }
}
