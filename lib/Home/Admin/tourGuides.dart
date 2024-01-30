import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourism/const/const.dart';

class TourGuides extends StatefulWidget {
  final String userType;

  const TourGuides({super.key, required this.userType});

  @override
  State<TourGuides> createState() => _TourGuidesState();
}

class _TourGuidesState extends State<TourGuides> {
  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: gc,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: wc,)
        ),
        centerTitle: true,
        title: Text('Tour Guides',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: wc)),
      ),


      body:Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").where("UserType", isEqualTo: "Guide")
              // .orderBy('userName',descending: false)
                  .snapshots(),
              // builder: (context,snapshot)
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                  return  ListView.builder(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        return
                          // auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['uid'].toString()

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: devSize.height*0.1,
                                                  // width: devSize.width*0.8,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[100],
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: gc),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey.shade500,
                                                            offset: Offset(4,4),
                                                            blurRadius: 10,
                                                            spreadRadius: 1
                                                        ),
                                                        BoxShadow(
                                                            color: Colors.white,
                                                            offset: Offset(-4,-4),
                                                            blurRadius: 10,
                                                            spreadRadius: 1
                                                        ),
                                                      ]
                                                  ),
                                                  child:Container(
                                                    height: devSize.height*0.1,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: devSize.width*0.05,
                                                        ),
                                                        CircleAvatar(
                                                          radius: 25.5,
                                                          backgroundColor: gc,
                                                          child: CircleAvatar(
                                                            radius: 24,
                                                            backgroundImage: NetworkImage(
                                                                streamSnapshot.data!.docs[index]['profilePhoto'].toString()
                                                              // UserImage[index].toString()
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: devSize.width*0.01,
                                                        ),

                                                        Container(
                                                          height: devSize.height*0.08,
                                                          width: devSize.width*0.45,
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              streamSnapshot.data!.docs[index]['userName'].toString(),
                                                              // UserName[index],
                                                              style:TextStyle(fontSize: 15,color: bl)),
                                                        ),



                                                        // ElevatedButton(
                                                        //   onPressed: (){},
                                                        //   child: Icon(Icons.edit,size: 20,color: wc,),
                                                        //   style: ElevatedButton.styleFrom(
                                                        //     minimumSize: Size(40, 35),
                                                        //     shape: CircleBorder(),
                                                        //     primary: gc, // <-- Button color
                                                        //   ),
                                                        // ),

                                                        ElevatedButton(
                                                          onPressed: (){
                                                            print(streamSnapshot.data!.docs[index].id);
                                                            FirebaseFirestore.instance.collection('users')
                                                                .doc(streamSnapshot.data!.docs[index].id)
                                                                .delete()
                                                                .then((value) => print('Deleted Successfully'));
                                                            Fluttertoast.showToast(
                                                                msg: "Guide Deleted Successfully",
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


                                                      ],
                                                    ),

                                                  ),

                                                ),



                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          );
                        // : Container(
                        //   child: Lottie.asset('lottie/nodata.json'),
                        //   // child: Text('No Data Found',style: TextStyle(color: Colors.black,fontSize: 15),
                        // );

                      }
                  );
                }
                else {
                  return Container();
                }
              }
          )





        // StreamBuilder(
        //     stream: FirebaseFirestore.instance.collection("users").orderBy('userName',descending: false).snapshots(),
        //     // builder: (context,snapshot)
        //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        //       if (streamSnapshot.hasData) {
        //         //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
        //         return
        //       }
        //       else {
        //         return Container();
        //       }
        //     }
        // )
        //










      ),









    );
  }

}
