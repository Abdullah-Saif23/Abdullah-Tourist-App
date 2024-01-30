import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourism/Home/Admin/Places/editPlaces.dart';
import 'package:tourism/const/const.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: devSize.height*0.9,
              width: devSize.width*0.98,
              child:  StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Places").orderBy('price',descending: false)
                      .snapshots(),
                  // builder: (context,snapshot)
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                      return  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, int index) {
                          return
                            Container(
                              height: devSize.height*0.9,
                              width: devSize.width*0.98,
                              child: Column(
                                children: [

                                  Container(
                                    height: devSize.height*0.9,
                                    width: devSize.width*0.98,

                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top:0,
                                          child: Container(
                                            width: devSize.width,
                                            height: devSize.height*0.4,
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(streamSnapshot.data!.docs[index]['placeImage'].toString(),),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Image.network(streamSnapshot.data!.docs[index]['placeImage'].toString(),fit: BoxFit.cover,),
                                          ),
                                        ),

                                        Positioned(
                                          top: devSize.height*0.3,
                                          child: Container(
                                            height: devSize.height*0.85,
                                            width: devSize.width,
                                            decoration: BoxDecoration(
                                              // color: bg2.withOpacity(0.1),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(35),
                                                topRight: Radius.circular(35),
                                              ),
                                            ),
                                            child: Column(

                                              children: [
                                                SizedBox(height: devSize.height*0.015,),

                                                Container(
                                                  width: devSize.width*0.85,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: (){
                                                          print(streamSnapshot.data!.docs[index].id);
                                                          FirebaseFirestore.instance.collection('Places')
                                                              .doc(streamSnapshot.data!.docs[index].id)
                                                              .delete()
                                                              .then((value) => print('Deleted Successfully'));
                                                          Fluttertoast.showToast(
                                                              msg: "Place Deleted Successfully",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              backgroundColor: rd,
                                                              textColor: Colors.white,
                                                              timeInSecForIosWeb: 1);
                                                        },
                                                        child: Image.asset('assets/icons/delete.png',width: 25,height: 25,),
                                                        style: ElevatedButton.styleFrom(
                                                          minimumSize: Size(40, 35),
                                                          shape: CircleBorder(),
                                                          primary: rd.withOpacity(0.6), // <-- Button color
                                                        ),
                                                      ),

                                                      ElevatedButton(
                                                        onPressed: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPlaces(
                                                            placeImage : streamSnapshot.data!.docs[index]['placeImage'].toString(),
                                                            placeName : streamSnapshot.data!.docs[index]['placeName'].toString(),
                                                            cityName : streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                            price : streamSnapshot.data!.docs[index]['price'].toString(),
                                                            description : streamSnapshot.data!.docs[index]['description'].toString(),
                                                            docId: streamSnapshot.data!.docs[index].id,
                                                            Status: "Edit",

                                                          )));
                                                        },
                                                        child: Image.asset('assets/icons/edit.png',width: 25,height: 25,),
                                                        style: ElevatedButton.styleFrom(
                                                          minimumSize: Size(40, 35),
                                                          shape: CircleBorder(),
                                                          primary: gc.withOpacity(0.6), // <-- Button color
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: devSize.height*0.015,),

                                                Container(
                                                  width: devSize.width*0.85,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Text(streamSnapshot.data!.docs[index]['placeName'].toString(),
                                                        style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600,color: bl),
                                                      ),

                                                      Row(
                                                        children: [
                                                          Text(streamSnapshot.data!.docs[index]['price'].toString(),
                                                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                                          ),
                                                          Text(" OMR",
                                                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Container(
                                                    width: devSize.width*0.89,
                                                    child: Row(
                                                      children: [

                                                        Icon(Icons.location_on,color: bg2,size: 28,),
                                                        SizedBox(width: 10,),

                                                        Text(streamSnapshot.data!.docs[index]['cityName'].toString(),
                                                          style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Container(
                                                    width: devSize.width*0.85,
                                                    child: Text("Description",
                                                      style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Container(
                                                    width: devSize.width*0.85,
                                                    height: devSize.height*0.3,
                                                    // color: Colors.red,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Text(
                                                        streamSnapshot.data!.docs[index]['description'].toString(),
                                                        textAlign: TextAlign.justify,
                                                        maxLines: 150,style: TextStyle(fontSize: 15,color: bl),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                            ),

                                          ),
                                        ),

                                        Positioned(
                                            top: devSize.height*0.07,left: devSize.width*0.06,
                                            child: GestureDetector(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.arrow_back_ios,size: 25,color: bg2,))),


                                      ],
                                    ),
                                  ),


                                ],
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

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: devSize.height*0.08,
                width: devSize.width*0.7,

                child: ElevatedButton(

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPlaces(
                      placeImage : "Null",
                      placeName : "Null",
                      cityName : "Null",
                      price : "0",
                      description : "Null",
                      docId: "Null",
                      Status: "Add",
                    )));

                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(onbText),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),

                        )
                    ),
                  ),
                  child: Text('Add Places',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: wc)),
                  // child: Text('Add',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
