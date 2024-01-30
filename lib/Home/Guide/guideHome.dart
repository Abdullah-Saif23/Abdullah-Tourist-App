import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:tourism/chatScreen.dart';
import 'package:tourism/const/const.dart';


class GuideHomePage extends StatefulWidget {
  final String userType;

  const GuideHomePage({super.key, required this.userType});

  @override
  State<GuideHomePage> createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {

  final FirebaseAuth auth = FirebaseAuth.instance;


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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: devSize.height*0.05,),
                Container(
                  width: devSize.width*0.85,
                  height: devSize.height*0.1,
                  alignment: Alignment.center,
                  child: Text("My Bookings",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: bl),
                  ),
                ),
                // Selectt(),
                SizedBox(height: devSize.height*0.03,),


                Places(),
                Hotels(),
                Cuisine(),




              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Places(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.515,
        width: devSize.width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: devSize.width*0.95,
                height: devSize.height*0.065,
                child: Text(
                  "Accepted Places Bookings"
                  ,style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),

            Container(
                width: devSize.width*0.95,
                height: devSize.height*0.45,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("PlacesBookings")
                        .where("status2", isEqualTo: "Accepted")
                        .snapshots(),
                    // builder: (context,snapshot)
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                        return
                          Container(
                            width: devSize.width*0.95,
                            height: devSize.height*0.45,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, int index) {
                                return auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['GUid'].toString() ?

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
                                      height: devSize.height*0.35, width: devSize.width*0.85,
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
                                                      child: Text("Booked By",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Text(streamSnapshot.data!.docs[index]['userName'].toString(),
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
                                                          Text("  OMR",
                                                            style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                        ],
                                                      ),
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
                                                      child: Text("Person\'s",
                                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                                Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                      child: Text(streamSnapshot.data!.docs[index]['person'].toString(),
                                                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                    )),
                                              ],
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                                                myImage : streamSnapshot.data!.docs[index]['userImage'].toString(),
                                                myName : streamSnapshot.data!.docs[index]['userName'].toString(),
                                                myId : streamSnapshot.data!.docs[index]['Uid'].toString(),
                                                guideName : streamSnapshot.data!.docs[index]['guideName'].toString(),
                                                guideImage : streamSnapshot.data!.docs[index]['guideImage'].toString(),
                                                guideId: streamSnapshot.data!.docs[index]['GUid'].toString(),
                                                userType: widget.userType,

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
                                              child: Text("Message",style: TextStyle(fontSize: 16,color: bl),),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),

                                  ),
                                ):

                                Container(
                                  // child: Center(
                                  //   child: Text("No Place\'s Booked",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                                  // ),
                                );
                              },
                              //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 2,
                              // ),

                            ),
                          );
                      }
                      else {
                        return Container(
                          // child: Center(
                          //   child: Text("No Place\'s Added",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                          // ),
                        );
                      }
                    }
                )



            )
          ],
        ),
      );
  }

  Widget Hotels(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.515,
        width: devSize.width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: devSize.width*0.95,
                height: devSize.height*0.065,
                child: Text(
                  "Accepted Hotels Bookings"
                  ,style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),

            Container(
                width: devSize.width*0.95,
                height: devSize.height*0.45,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("ResturantsBookings").where("status2", isEqualTo: "Accepted")
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
                              return auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['GUid'].toString() ?

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
                                    height: devSize.height*0.35, width: devSize.width*0.85,
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
                                                    child: Text("Booked By",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['userName'].toString(),
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

                                        Container(
                                          width: devSize.width*0.81,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                    child: Text("Person\'s",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['person'].toString(),
                                                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                                              myImage : streamSnapshot.data!.docs[index]['userImage'].toString(),
                                              myName : streamSnapshot.data!.docs[index]['userName'].toString(),
                                              myId : streamSnapshot.data!.docs[index]['Uid'].toString(),
                                              guideName : streamSnapshot.data!.docs[index]['guideName'].toString(),
                                              guideImage : streamSnapshot.data!.docs[index]['guideImage'].toString(),
                                              guideId: streamSnapshot.data!.docs[index]['GUid'].toString(),
                                              userType: widget.userType,


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
                                            child: Text("Message",style: TextStyle(fontSize: 16,color: bl),),
                                          ),
                                        )


                                      ],
                                    ),
                                  ),

                                ),
                              ):
                              Container(
                                // child: Center(
                                //   child: Text("No Resturant\'s Booked",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                                // ),
                              );
                            },
                            //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            // ),

                          );
                      }
                      else {
                        return Container(
                          // child: Center(
                          //   child: Text("No Resturant\'s Booked",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                          // ),
                        );
                      }
                    }
                )



            )
          ],
        ),
      );


  }

  Widget Cuisine(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.515,
        width: devSize.width,
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: devSize.width*0.95,
                height: devSize.height*0.065,
                child: Text(
                  "Accepted Cuisine Bookings"
                  ,style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: bl),)),


            Container(
                width: devSize.width*0.95,
                height: devSize.height*0.45,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("CuisinesBookings").where("status2", isEqualTo: "Accepted")
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
                              return auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['GUid'].toString() ?
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
                                    height: devSize.height*0.31, width: devSize.width*0.85,
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
                                                    child: Text("Booked By",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['userName'].toString(),
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

                                        Container(
                                          width: devSize.width*0.81,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0,top: 8),
                                                    child: Text("Person\'s",
                                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                              Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0,top: 8),
                                                    child: Text(streamSnapshot.data!.docs[index]['person'].toString(),
                                                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600,color: bl),),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                                              myImage : streamSnapshot.data!.docs[index]['userImage'].toString(),
                                              myName : streamSnapshot.data!.docs[index]['userName'].toString(),
                                              myId : streamSnapshot.data!.docs[index]['Uid'].toString(),
                                              guideName : streamSnapshot.data!.docs[index]['guideName'].toString(),
                                              guideImage : streamSnapshot.data!.docs[index]['guideImage'].toString(),
                                              guideId: streamSnapshot.data!.docs[index]['GUid'].toString(),
                                              userType: widget.userType,

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
                                            child: Text("Message",style: TextStyle(fontSize: 16,color: bl),),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),

                                ),
                              ):
                              Container(
                                // child: Center(
                                //   child: Text("No Cuisine Booked",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: onbText),),
                                // ),
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



            )


          ],
        ),
      );
  }

  // Widget Selectt(){
  //   final devSize = MediaQuery.of(context).size;
  //   return
  //     Container(
  //       width: devSize.width*0.95,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           GestureDetector(
  //             onTap: (){
  //               if(myBookings == true){
  //                 setState(() {
  //                   myBookings = false;
  //                   newBookings = false;
  //
  //                 });
  //               }
  //               else{
  //                 if(myBookings == false){
  //                   setState(() {
  //                     myBookings = true;
  //                     newBookings = false;
  //
  //                   });
  //                 }
  //               }
  //             },
  //             child: Container(
  //               width: devSize.width*0.38,
  //               height: devSize.height*0.065,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   color: myBookings == true ? bg2 : Colors.transparent,
  //                   border: Border.all(color: myBookings == true ? Colors.transparent : bg2),
  //                   borderRadius: BorderRadius.circular(25)
  //
  //               ),
  //               child: Text("My Bookings",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: bl),),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: (){
  //               if(newBookings == true){
  //                 setState(() {
  //                   myBookings = false;
  //                   newBookings = false;
  //
  //                 });
  //               }
  //               else{
  //                 if(newBookings == false){
  //                   setState(() {
  //                     myBookings = false;
  //                     newBookings = true;
  //
  //                   });
  //                 }
  //               }
  //             },
  //             child: Container(
  //               width: devSize.width*0.38,
  //               height: devSize.height*0.065,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   color: newBookings == true ? bg2 : Colors.transparent,
  //                   border: Border.all(color: newBookings == true ? Colors.transparent : bg2),
  //                   borderRadius: BorderRadius.circular(25)
  //
  //               ),
  //               child: Text("New Bookings",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: bl),),
  //             ),
  //           ),
  //
  //         ],
  //
  //       ),
  //     );
  // }
}
