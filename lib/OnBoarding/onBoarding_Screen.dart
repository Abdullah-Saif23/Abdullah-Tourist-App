import 'package:flutter/material.dart';
import 'package:tourism/OnBoarding/onBoarding_Model.dart';
import 'package:tourism/auth/usertype.dart';
import 'package:tourism/const/const.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  int currentIndex = 0;

  List<OnBoardingModel> model = [
    OnBoardingModel(
      'assets/images/w1.png',
      "A journey of a thousand miles begins with a single step.",
        "Let's Travel"
  ),

    OnBoardingModel(
        'assets/images/w2.png',
        "Take only memories, leave only footprints",
        "Plan A Trip"
    ),



  ];

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    return Scaffold(
    body: Center(
      child: Container(
        height: devSize.height,
        child: Column(
          children: [
            Container(
              height: devSize.height*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: devSize.height*0.09,),

                  Container(
                    height: devSize.height*0.81,
                    child: PageView.builder(
                        onPageChanged: (int index){
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemCount: model.length,
                        itemBuilder: (_,i){
                          return
                              Column(
                                children: [
                                  Container(
                                    width: devSize.width*0.8,
                                    alignment: Alignment.centerLeft,
                                    child: Text(model[i].heading,
                                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: onbText),),
                                  ),
                                  Container(
                                    width: devSize.width*0.8,
                                    alignment: Alignment.center,
                                    child: Text(
                                      model[i].text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17,color: onbText),

                                    ),
                                  ),
                                  SizedBox(width: 100,),
                                  Container(
                                    alignment: Alignment.centerLeft,

                                    width: devSize.width*0.8,
                                    child: Container(
                                      width: devSize.width*0.4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              bg2,bg1,
                                            ],
                                          )
                                      ),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));

                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                          ),
                                          child: Text("Get Started",
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
                                          )
                                      ),
                                    ),
                                  ),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: i==2? 300 :300,
                                      width: i==2? devSize.width*0.85 :devSize.width*0.85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.asset(model[i].image,fit: BoxFit.contain,),
                                    ),
                                  ),


                                ],
                              );
                        }),
                  ),


                ],
              ),
            ),
            Container(
              height: devSize.height*0.09,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      2,
                          (index) =>Builddot(context,index)
                  )
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
  Widget  Builddot(BuildContext context, int index){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.015,
        width: currentIndex == index ? devSize.width*0.07 : devSize.width*0.03,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:
            currentIndex == index ?
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bg2,bg1,
              ],
            )
            :LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey,Colors.grey,
              ],
            )


        ),
      );


  }
}

