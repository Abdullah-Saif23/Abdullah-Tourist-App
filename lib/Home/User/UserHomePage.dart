import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:tourism/Home/User/details.dart';
import 'package:tourism/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserHomePage extends StatefulWidget {
  final String userType;

  const UserHomePage({super.key, required this.userType});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  bool places = true;
  bool Resturants = false;
  bool Food = false;

  String ? UserName;
  String ? UserImage;
  String ? UserNo;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getUserData()  {
    print('we are here image');
    FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: auth.currentUser!.uid).snapshots().forEach((element) {

      // _currentRangeValues =   RangeValues(double.parse(element.docs[0]['prefereAgeStart']), double.parse(element.docs[0]['prefereAgeEnd']));
      // _currentRangeValues1 =   RangeValues(double.parse(element.docs[0]['prefereHeightStart']), double.parse(element.docs[0]['prefereHeightEnd']));

      setState(() {
        UserName = element.docs[0]['userName'].toString();
        UserImage = element.docs[0]['profilePhoto'].toString();
        UserNo = element.docs[0]['MobileNo'].toString();
      });


      print(UserName);
      print(UserImage);
      print(UserNo);


    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: devSize.width,
          height: devSize.height,
          color: bg2.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(height: devSize.height*0.065,),

              Container(

                width: devSize.width*0.95,
                height: devSize.height*0.14,
                alignment: Alignment.center,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").snapshots(),
                    // builder: (context,snapshot)
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                        return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, int index) {
                              return auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['uid'].toString() ?
                              Container(
                                width: devSize.width*0.95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: devSize.width*0.77,
                                            height: devSize.height*0.06,
                                            child: Text(streamSnapshot.data!.docs[index]['userName'].toString(),
                                              style: TextStyle(fontSize: 16.5,fontWeight: FontWeight.w600,color: bl),)),
                                        Container(
                                            width: devSize.width*0.77,
                                            child: Text("Where do you want to go?",style: TextStyle(fontSize: 13,color: bl),)),
                                      ],
                                    ),


                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                        if (streamSnapshot.hasData && streamSnapshot.connectionState != ConnectionState.done) {
                                          return streamSnapshot.data!.docs.isNotEmpty
                                              ?
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: bl,
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:onbText,
                                              // backgroundImage: AssetImage('assets/icons/user.png',),
                                              backgroundImage: NetworkImage(
                                                  streamSnapshot.data!.docs[index]['profilePhoto'].toString()
                                                // 'https://i.pinimg.com/originals/25/29/4d/25294d1003ffe106463b5484e19aab30.jpg'
                                                // streamSnapshot.data!.docs[index]['profilePhoto'].toString()

                                              ),

                                            ),
                                          )
                                            : SizedBox(
                                             height: devSize.height * 0.5,
                                        //width: devSize.width,
                                            child: const Center(
                                            child: Text(
                                            'No Data Found!',
                                            style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                            ))
                                            );
                                        } else {
                                        return SizedBox(
                                        height: devSize.height,
                                        width: devSize.width,
                                        child: const Center(
                                        child: CircularProgressIndicator(),
                                        ),
                                        );
                                        }
                                      },
                                    ),



                                  ],
                                ),
                              )
                                  : Container(
                                // child: Text('No Data Found',style: TextStyle(color: Colors.black,fontSize: 15),
                              );

                            }
                        );
                      }
                      else {
                        return Container();
                      }
                    }
                ),
              ),


              SizedBox(height: devSize.height*0.03,),

              Selectt(),

              SizedBox(height: devSize.height*0.03,),


              places == true?
              Places():
              Resturants == true?
              Hotels():
              Food == true ?
              Cuisine()
              :Container()




            ],
          ),
        ),
      ),
    );
  }

  Widget Places(){
    final devSize = MediaQuery.of(context).size;

    return
        Container(
          height: devSize.height*0.53,
          width: devSize.width,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  width: devSize.width*0.95,
                  height: devSize.height*0.065,
                  child: Text("Discover Places",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),

              Container(
                width: devSize.width*0.95,
                height: devSize.height*0.46,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Places").orderBy('price',descending: true)
                        .snapshots(),
                    // builder: (context,snapshot)
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                        return
                          ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, int index) {
                            return
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: Container(
                                  width: devSize.width*0.8,
                                  height: devSize.height*0.4,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(streamSnapshot.data!.docs[index]['placeImage'].toString(),),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: GlassContainer(
                                    height: devSize.height*0.25, width: devSize.width*0.85,
                                    color: login.withOpacity(0.4),
                                    borderColor: Colors.transparent,
                                    blur: 0,
                                    elevation: 15,
                                    isFrostedGlass: false,
                                    shadowColor: login.withOpacity(0.1),
                                    alignment: Alignment.center,
                                    frostedOpacity: 1,
                                    // borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: devSize.width*0.81,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                    child: Text("Place",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['placeName'].toString(),
                                                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: devSize.width*0.81,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                    child: Text("City",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: devSize.width*0.81,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                    child: Text("Price",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Row(
                                                      children: [
                                                        Text(streamSnapshot.data!.docs[index]['price'].toString(),
                                                          style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                        Text(" OMR",
                                                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(
                                              userImage : UserImage.toString(),
                                              userName : UserName.toString(),
                                              userNo : UserNo.toString(),
                                              placeImage : streamSnapshot.data!.docs[index]['placeImage'].toString(),
                                              placeName : streamSnapshot.data!.docs[index]['placeName'].toString(),
                                              cityName : streamSnapshot.data!.docs[index]['cityName'].toString(),
                                              price : streamSnapshot.data!.docs[index]['price'].toString(),
                                              description : streamSnapshot.data!.docs[index]['description'].toString(),
                                              docId: streamSnapshot.data!.docs[index].id,
                                              Status: "Places",
                                            )));

                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: devSize.height*0.05,
                                            width: devSize.width*0.25,
                                            decoration: BoxDecoration(
                                              color: bg2,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text("Book -->",style: TextStyle(fontSize: 16,color: bl),),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ),
                              );

                          },
                          //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 2,
                          // ),

                        );
                      }
                      else {
                        return Container(
                          child: Center(
                            child: Text("No Place\'s Added",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                          ),
                        );
                      }
                    }
                )



              ),
            ],
          ),
        );
  }

  Widget Hotels(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.53,
        width: devSize.width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: devSize.width*0.95,
                height: devSize.height*0.065,
                child: Text("Discover Hotels",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),

            Container(
                width: devSize.width*0.95,
                height: devSize.height*0.46,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Resturants").orderBy('price',descending: true)
                        .snapshots(),
                    // builder: (context,snapshot)
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                        return
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, int index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: Container(
                                    width: devSize.width*0.8,
                                    height: devSize.height*0.4,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(streamSnapshot.data!.docs[index]['resturantImage'].toString(),),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: GlassContainer(
                                      height: devSize.height*0.25, width: devSize.width*0.85,
                                      color: login.withOpacity(0.4),
                                      borderColor: Colors.transparent,
                                      blur: 0,
                                      elevation: 15,
                                      isFrostedGlass: false,
                                      shadowColor: login.withOpacity(0.1),
                                      alignment: Alignment.center,
                                      frostedOpacity: 1,
                                      // borderRadius: BorderRadius.circular(20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: devSize.width*0.81,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                      child: Text("Place",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Text(streamSnapshot.data!.docs[index]['resturantName'].toString(),
                                                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: devSize.width*0.81,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                      child: Text("City",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Text(streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: devSize.width*0.81,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                      child: Text("Price",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Row(
                                                        children: [
                                                          Text(streamSnapshot.data!.docs[index]['price'].toString(),
                                                            style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                          Text(" OMR",
                                                            style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(
                                                userImage : UserImage.toString(),
                                                userName : UserName.toString(),
                                                userNo : UserNo.toString(),
                                                placeImage : streamSnapshot.data!.docs[index]['resturantImage'].toString(),
                                                placeName : streamSnapshot.data!.docs[index]['resturantName'].toString(),
                                                cityName : streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                price : streamSnapshot.data!.docs[index]['price'].toString(),
                                                description : streamSnapshot.data!.docs[index]['description'].toString(),
                                                docId: streamSnapshot.data!.docs[index].id,
                                                Status: "Resturants",
                                              )));

                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: devSize.height*0.05,
                                              width: devSize.width*0.25,
                                              decoration: BoxDecoration(
                                                color: bg2,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text("Book -->",style: TextStyle(fontSize: 16,color: bl),),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ),
                                );

                            },
                            //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            // ),

                          );
                      }
                      else {
                        return Container(
                          child: Center(
                            child: Text("No Resturant\'s Added",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                          ),
                        );
                      }
                    }
                )



            ),
          ],
        ),
      );


  }

  Widget Cuisine(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.53,
        width: devSize.width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: devSize.width*0.95,
                height: devSize.height*0.065,
                child: Text("Discover Cuisine",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),

            Container(
                width: devSize.width*0.95,
                height: devSize.height*0.46,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Cuisine").orderBy('price',descending: true)
                        .snapshots(),
                    // builder: (context,snapshot)
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                        return
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, int index) {
                              return
                                Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: Container(
                                    width: devSize.width*0.8,
                                    height: devSize.height*0.4,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(streamSnapshot.data!.docs[index]['cuisineImage'].toString(),),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: GlassContainer(
                                      height: devSize.height*0.25, width: devSize.width*0.85,
                                      color: login.withOpacity(0.4),
                                      borderColor: Colors.transparent,
                                      blur: 0,
                                      elevation: 15,
                                      isFrostedGlass: false,
                                      shadowColor: login.withOpacity(0.1),
                                      alignment: Alignment.center,
                                      frostedOpacity: 1,
                                      // borderRadius: BorderRadius.circular(20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: devSize.width*0.81,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                      child: Text("Place",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Text(streamSnapshot.data!.docs[index]['cuisineName'].toString(),
                                                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   width: devSize.width*0.81,
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Container(
                                          //           alignment: Alignment.centerLeft,
                                          //           child: Padding(
                                          //             padding: const EdgeInsets.only(left: 8.0,top: 8),
                                          //             child: Text("City",
                                          //               style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                          //           )),
                                          //       Container(
                                          //           alignment: Alignment.centerLeft,
                                          //           child: Padding(
                                          //             padding: const EdgeInsets.only(right: 8.0,top: 8),
                                          //             child: Text(streamSnapshot.data!.docs[index]['cityName'].toString(),
                                          //               style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                          //           )),
                                          //     ],
                                          //   ),
                                          // ),
                                          Container(
                                            width: devSize.width*0.81,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                      child: Text("Price",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Row(
                                                        children: [
                                                          Text(streamSnapshot.data!.docs[index]['price'].toString(),
                                                            style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                          Text(" OMR",
                                                            style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(
                                                userImage : UserImage.toString(),
                                                userName : UserName.toString(),
                                                userNo : UserNo.toString(),
                                                placeImage : streamSnapshot.data!.docs[index]['cuisineImage'].toString(),
                                                placeName : streamSnapshot.data!.docs[index]['cuisineName'].toString(),
                                                cityName : streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                price : streamSnapshot.data!.docs[index]['price'].toString(),
                                                description : streamSnapshot.data!.docs[index]['description'].toString(),
                                                docId: streamSnapshot.data!.docs[index].id,
                                                Status: "Cuisines",
                                              )));

                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: devSize.height*0.05,
                                              width: devSize.width*0.25,
                                              decoration: BoxDecoration(
                                                color: bg2,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text("Book -->",style: TextStyle(fontSize: 16,color: bl),),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ),
                                );

                            },
                            //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            // ),

                          );
                      }
                      else {
                        return Container(
                          child: Center(
                            child: Text("No Cuisine Added",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                          ),
                        );
                      }
                    }
                )



            ),
          ],
        ),
      );
  }

  Widget Selectt(){
    final devSize = MediaQuery.of(context).size;
    return
      Container(
        width: devSize.width*0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                if(places == true){
                  setState(() {
                    places = false;
                    Resturants = false;
                    Food = false;

                  });
                }
                else{
                  if(places == false){
                    setState(() {
                      places = true;
                      Resturants = false;
                      Food = false;

                    });
                  }
                }
              },
              child: Container(
                width: devSize.width*0.3,
                height: devSize.height*0.065,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: places == true ? bg2 : Colors.transparent,
                    border: Border.all(color: places == true ? Colors.transparent : bg2),
                    borderRadius: BorderRadius.circular(25)

                ),
                child: Text("Places",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: bl),),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(Resturants == true){
                  setState(() {
                    places = false;
                    Resturants = false;
                    Food = false;

                  });
                }
                else{
                  if(Resturants == false){
                    setState(() {
                      places = false;
                      Resturants = true;
                      Food = false;

                    });
                  }
                }
              },
              child: Container(
                width: devSize.width*0.3,
                height: devSize.height*0.065,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Resturants == true ? bg2 : Colors.transparent,
                    border: Border.all(color: Resturants == true ? Colors.transparent : bg2),
                    borderRadius: BorderRadius.circular(25)

                ),
                child: Text("Hotels",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: bl),),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(Food == true){
                  setState(() {
                    places = false;
                    Resturants = false;
                    Food = false;

                  });
                }
                else{
                  if(Food == false){
                    setState(() {
                      places = false;
                      Resturants = false;
                      Food = true;

                    });
                  }
                }
              },
              child: Container(
                width: devSize.width*0.3,
                height: devSize.height*0.065,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Food == true ? bg2 : Colors.transparent,
                    border: Border.all(color: Food == true ? Colors.transparent : bg2),
                    borderRadius: BorderRadius.circular(25)

                ),
                child: Text("Cuisine",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: bl),),
              ),
            ),

          ],

        ),
      );
  }

}
