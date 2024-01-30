import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourism/const/const.dart';


class ChatScreen extends StatefulWidget {
  final String myImage;
  final String myName;
  final String myId;
  final String guideImage;
  final String guideName;
  final String guideId;
  final String userType;

  const ChatScreen({super.key, required this.myImage,
    required this.myName, required this.myId, required this.guideImage,
    required this.guideName, required this.guideId, required this.userType});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _sendMessage = TextEditingController();
  final ScrollController listScrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: gc,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: wc,)
        ),
        centerTitle: true,
        title: Container(
          width: devSize.width*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: devSize.width*0.58,
                alignment: Alignment.center,
                child: Text(
                widget.userType == "User"?
                widget.guideName:
                widget.myName

                ,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: wc),),
              ),
              CircleAvatar(
                radius: 31,
                backgroundColor: gc,
                child: CircleAvatar(
                  backgroundColor:Color(0xffEEFEED),
                  // backgroundImage: AssetImage('images/Profile-pic.png',),
                  backgroundImage: NetworkImage(
                      widget.userType == "User"?
                      widget.guideImage:
                      widget.myImage,

                  ),
                  radius: 30,

                ),
              ),
            ],
          ),
        ),


      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Container(
              //   height: devSize.height*0.74,
              //   color: Colors.red,
              //   child: Column(
              //     children: [
              //
              //     ],
              //   ),
              // ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: devSize.height*0.005,
                    ),
                    Center(
                      child: Container(
                        height: devSize.height*0.75,
                        width:devSize.width*0.95,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Chattting")
                                .doc(widget.myId)
                                .collection("messages")
                                .doc(widget.guideId)
                                .collection("chats")
                                .orderBy("Date",descending: true)
                                .snapshots(),
                            // builder: (context,snapshot)
                            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);

                                if(streamSnapshot.data!.docs.length<1){
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Connect With: ",style: TextStyle(
                                            fontSize: 18,fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                        ),
                                        Text(widget.guideName,style: TextStyle(
                                            fontSize: 18,fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      itemCount: streamSnapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      reverse: true,
                                      controller: listScrollController,
                                      itemBuilder: (context, int index) {
                                        print("THis is last else Statement");

                                        bool ?isMe;
                                        bool ?isGuide;
                                        if(widget.userType == "User"){
                                           isMe = streamSnapshot.data!.docs[index]['SenderId'].toString() == widget.myId.toString();


                                           print(widget.userType);
                                           print(widget.myId);
                                        }
                                        else{
                                          if(widget.userType == "Guide"){
                                             isMe = streamSnapshot.data!.docs[index]['SenderId'].toString() == widget.guideId.toString();

                                             print(widget.userType);
                                             print(widget.guideId);
                                          }
                                        }

                                        return
                                          // auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['uid'].toString()

                                          Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              // crossAxisAlignment: isMe! ?CrossAxisAlignment.end : CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: isMe!? MainAxisAlignment.end
                                                      :MainAxisAlignment.start,
                                                  // crossAxisAlignment: isMe!? CrossAxisAlignment.end
                                                  // :CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child:
                                                      ClipRRect(
                                                        borderRadius: isMe!?
                                                        const BorderRadius.only(
                                                          topRight: Radius.circular(20),
                                                          bottomLeft: Radius.circular(20),
                                                          topLeft: Radius.circular(20),
                                                        ):
                                                        const BorderRadius.only(
                                                          topRight: Radius.circular(20),
                                                          bottomLeft: Radius.circular(20),
                                                          bottomRight: Radius.circular(20),
                                                        ),
                                                        child:Container(
                                                            child:Stack(
                                                                children:[
                                                                  // blur effect
                                                                  BackdropFilter(
                                                                    filter:ImageFilter.blur(
                                                                      sigmaX:2,
                                                                      sigmaY:2,
                                                                    ),// ImageFilter.blur
                                                                    child:Container(),
                                                                  ),// BackdropFilter
                                                                  // gradient effect
                                                                  Row(
                                                                    mainAxisAlignment: isMe? MainAxisAlignment.end
                                                                        :MainAxisAlignment.start,
                                                                    children: [
                                                                      Flexible(
                                                                        child: Container(
                                                                          decoration:BoxDecoration(
                                                                            border:Border.all(color:Colors.white.withOpacity(0.2)),
                                                                            borderRadius: isMe?
                                                                            BorderRadius.only(
                                                                              topRight: Radius.circular(20),
                                                                              bottomLeft: Radius.circular(20),
                                                                              topLeft: Radius.circular(20),
                                                                            ):
                                                                            BorderRadius.only(
                                                                              topRight: Radius.circular(20),
                                                                              bottomLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20),
                                                                            ),
                                                                            gradient:LinearGradient(
                                                                              begin:Alignment.topLeft,
                                                                              end:Alignment.bottomRight,
                                                                              colors: isMe?
                                                                              [
                                                                                gc.withOpacity(0.45),
                                                                                gc.withOpacity(0.35)

                                                                              ]
                                                                                  :
                                                                              [
                                                                                bg2.withOpacity(0.45),
                                                                                bg2.withOpacity(0.35),

                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(10),
                                                                            child: Text(streamSnapshot.data!.docs[index]['message'].toString(),
                                                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),
                                                                              maxLines: 50,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ]
                                                            )

                                                        ),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                                Container(
                                                  height: devSize.height*0.015,
                                                ),
                                              ],
                                            ),
                                          );
                                        // : Container(
                                        //   child: Lottie.asset('lottie/nodata.json'),
                                        //   // child: Text('No Data Found',style: TextStyle(color: Colors.black,fontSize: 15),
                                        // );

                                      }
                                  );

                                }
                              }
                              else {
                                return Center(
                                    child: SpinKitFadingCircle(
                                      size: 100,
                                      color: Colors.white,
                                    )
                                );
                              }
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                width: devSize.width,

                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Container(
                          // height: size.height * 0.1,
                            width: devSize.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2,color: Colors.white),
                            ),

                            child: TextFormField(
                              controller: _sendMessage,
                              keyboardType: TextInputType.text,
                              cursorColor: gc,
                              style: TextStyle(color: gc),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 9.0,top: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  BorderSide(
                                      color: gc,
                                      width: 1.5
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                hintText: 'Enter Your Message',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              // validator: (value) {
                              //   //EmailValidator.validate(value!);
                              //   if (!EmailValidator.validate(_emailController.text)) {
                              //     return 'Please provide valid email';
                              //   }
                              //   return null;
                              // },
                            )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async{

                        if(_sendMessage.text.isNotEmpty){
                          await FirebaseFirestore.instance
                              .collection("Chattting")
                              .doc(widget.myId)
                              .collection("messages")
                              .doc(widget.guideId)
                              .collection("chats")
                              .add({
                            "SenderId":widget.myId,
                            "RecieverId":widget.guideId,
                            "message":_sendMessage.text.trim(),
                            "type":"text",
                            "Date":DateTime.now(),
                          }).then((value){
                            FirebaseFirestore.instance
                                .collection("Chattting")
                                .doc(widget.myId)
                                .collection("messages")
                                .doc(widget.guideId)
                                .set({
                              "LastMessage":_sendMessage.text.trim()
                            });
                          });


                          await FirebaseFirestore.instance
                              .collection("Chattting")
                              .doc(widget.guideId)
                              .collection("messages")
                              .doc(widget.myId)
                              .collection("chats")
                              .add({
                            "SenderId":widget.myId,
                            "RecieverId":widget.guideId,
                            "message":_sendMessage.text.trim(),
                            "type":"text",
                            "Date":DateTime.now(),
                          }).then((value){
                            FirebaseFirestore.instance
                                .collection("Chattting")
                                .doc(widget.guideId)
                                .collection("messages")
                                .doc(widget.myId)
                                .set({
                              "LastMessage":_sendMessage.text.trim()
                            });
                          });

                          _sendMessage.clear();
                          print("This is the messsage i have sent");
                          print(_sendMessage.text.toString());

                        }

                        else{
                          Fluttertoast.showToast(
                              msg:
                              "Please Type Your Message",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: rd,
                              textColor: wc,
                              timeInSecForIosWeb: 1);
                        }

                      },
                      child: Container(
                        height: devSize.height*0.1,
                        width: devSize.width*0.13,
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.send_outlined,size: 22,color: Colors.white,),

                      ),
                    ),
                    Spacer(),

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
