import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourism/auth/input_validator.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/auth/usertype.dart';
import 'package:tourism/const/const.dart';


class UserProfile extends StatefulWidget {
  final String userType;

  const UserProfile({super.key, required this.userType});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _controllerUserName = TextEditingController();
  final InputValidator _inputValidator = InputValidator();


  String? profileImage;

  bool isProfileLoading = false;
  bool isLoading = false;
  String? selected;
  PickedFile? _pickedFile;
  static int y=0;
  String? uid;


  // DocumentSnapshot? snap;
  static List<String> _idCardImages = [];


  QuerySnapshot? snapshots;
  int? selectedIndex;

  File? image;



  void initState() {
    // TODO: implement initState
    super.initState();
    // print(auth.currentUser!.uid);
    getImages();
    getUserData();
    setState(() {
      _idCardImages.clear();
      selected = 'profile';
    });
  }

  getImages()  {
    print('we are here');
    FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).snapshots().forEach((element) {
      for(int i=0 ; i<element.docs[0]['photos'].length;i++){
        setState(() {
          selectedIndex = element.docs[0]['star'];

        });
        if(y==0){
          _idCardImages.add(element.docs[0]['photos'][i]);

        }

      }
      y++;
      print('we are here idcard');
      print(_idCardImages);


    });
  }

  _imgFromCamera(bool isProfile) async {
    if(isProfile == true){
      setState(() {
        isProfileLoading = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;
    setState(() {
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {

          if(isProfile){
            FirebaseFirestore.instance
                .collection('users').doc(auth.currentUser!.uid).update({
              'profilePhoto': value.toString()
            }).then((value) {
              setState(() {
                isProfileLoading = false;
              });
              print('Success uploaded profile');
            });
          }
          else {

            setState(() {
              _idCardImages.add(value);
            });
            FirebaseFirestore.instance
                .collection('users').doc(auth.currentUser!.uid).update({
              'profilePhoto': _idCardImages
            }).then((value) {
              setState(() {
                isLoading = false;
              });
              print('Success uploaded photos');
            });
          }


        } else {
          print('sorry error');
        }
      });
    });
  }

  _imgFromGallery(bool isProfile) async {
    if(isProfile == true){
      setState(() {
        isProfileLoading = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {

        if (value != null) {
          if(isProfile){

            FirebaseFirestore.instance
                .collection('users').doc(auth.currentUser!.uid).update({
              'profilePhoto': value.toString()
            }).then((value) {
              setState(() {
                isProfileLoading = false;
              });
              print('Success uploaded profile');
            });
          }
          else{

            setState(() {
              _idCardImages.add(value);
            });
            FirebaseFirestore.instance
                .collection('users').doc(auth.currentUser!.uid).update({
              'profilePhoto': _idCardImages
            }).then((value) {
              setState(() {
                isLoading = false;
              });
              print('Success uploaded photos');
            });
          }


        } else {
          print('sorry error');
        }
      });
    });
  }

  void _showPicker(context, bool isProfile) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {

                        _imgFromGallery(isProfile);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(isProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("image" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }
    //   print(_imagePath);


  }

  getUserData()  {
    print('we are here image');
    FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: auth.currentUser!.uid).snapshots().forEach((element) {

      // _currentRangeValues =   RangeValues(double.parse(element.docs[0]['prefereAgeStart']), double.parse(element.docs[0]['prefereAgeEnd']));
      // _currentRangeValues1 =   RangeValues(double.parse(element.docs[0]['prefereHeightStart']), double.parse(element.docs[0]['prefereHeightEnd']));

      setState(() {
        _controllerUserName.text = element.docs[0]['userName'].toString();
      });


      print(_controllerUserName.text);


    });
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: gc,
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: (){
          //       Navigator.pop(context);
          //     },
          //     child: Icon(Icons.arrow_back_ios,size: 20,color: wc,)
          // ),
          centerTitle: true,
          title: Text('Edit Profile',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: wc),),


        ),

        body:StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            // builder: (context,snapshot)
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                //return CircularProgressIndicator(color: indCo,strokeWidth: 10,);
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      return auth.currentUser!.uid.toString() == streamSnapshot.data!.docs[index]['uid'].toString() ?
                      SingleChildScrollView(
                        child: Center(
                          child: Container(
                            height: devSize.height*0.95,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: devSize.height * 0.03,
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
                                      Container(
                                        height: devSize.height*0.203,
                                        width: devSize.width*0.35,
                                        child: Stack(
                                          alignment: AlignmentDirectional.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 61,
                                              backgroundColor: gc,
                                              child: CircleAvatar(
                                                backgroundColor:Color(0xffEEFEED),
                                                // backgroundImage: AssetImage('images/Profile-pic.png',),
                                                backgroundImage: NetworkImage(streamSnapshot.data!.docs[index]['profilePhoto'].toString()),
                                                radius: 60,

                                              ),
                                            ),
                                            Positioned(
                                              top: 30,left: 95,
                                              child: GestureDetector(
                                                onTap: (){
                                                  _showPicker(context, true);
                                                  print('camera');
                                                },
                                                child: Container(
                                                  height: devSize.height*0.2,
                                                  width: devSize.width*0.08,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: gc
                                                  ),

                                                  child: Icon(Icons.add_a_photo,size: 15,color: Colors.white,),

                                                ),
                                              ),
                                            ),
                                          ],
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
                                              )));
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


                                Container(
                                  height: devSize.height * 0.06,
                                  width: devSize.width * 0.9,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    streamSnapshot.data!.docs[index]['userName'],
                                    style: TextStyle(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: gc)),
                                ),
                                Container(
                                  height: devSize.height * 0.035,
                                  width: devSize.width * 0.9,
                                  alignment: Alignment.center,
                                  child: Text(
                                    streamSnapshot.data!.docs[index]['email'],
                                    style:TextStyle(fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: gc)),
                                ),
                                SizedBox(
                                  height: devSize.height * 0.03,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Container(
                                    // height: size.height * 0.1,
                                      width: devSize.width * 0.8,
                                      // decoration: BoxDecoration(
                                      //   border: Border.all(width: 2,color: Colors.blue),
                                      // ),

                                      child: TextFormField(
                                        controller: _controllerUserName,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person, size: 22, color: gc,),

                                          contentPadding: EdgeInsets.only(
                                              left: 9.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            borderSide: BorderSide(
                                                color: fieldborder, width: 1.5
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            borderSide:  BorderSide(
                                              color: fieldborder.withOpacity(0.4),
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'Enter your Username',
                                          hintStyle: TextStyle(
                                              color: Colors.grey),
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

                                SizedBox(
                                  height: devSize.height * 0.04,
                                ),

                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      // SizedBox(
                                      //   width: devSize.width*0.4465,
                                      // ),
                                      // Container(
                                      //   height: devSize.height * 0.08,
                                      //   width: devSize.width * 0.4,
                                      //   child: ElevatedButton(
                                      //     onPressed: () {
                                      //       setState(() {
                                      //         _controllerUserName.clear();
                                      //       });
                                      //     },
                                      //     style: ButtonStyle(
                                      //       backgroundColor: MaterialStateProperty
                                      //           .all<Color>(rd),
                                      //       shape: MaterialStateProperty.all<
                                      //           RoundedRectangleBorder>(
                                      //           RoundedRectangleBorder(
                                      //             borderRadius: BorderRadius
                                      //                 .circular(10),
                                      //
                                      //           )
                                      //       ),
                                      //     ),
                                      //     child: Text(
                                      //       'Cancel', style:TextStyle(fontSize: 15,
                                      //             fontWeight: FontWeight.w600,
                                      //             color: wc)),
                                      //     // child: Text('Cancel',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),
                                      //
                                      //   ),
                                      // ),

                                      Container(
                                        height: devSize.height * 0.08,
                                        width: devSize.width * 0.4,

                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_inputValidator.validateName(
                                                _controllerUserName.text) !=
                                                'success' &&
                                                _controllerUserName.text.isNotEmpty) {
                                              Fluttertoast.showToast(
                                                  msg: "Invalid UserName ",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: rd,
                                                  textColor: Colors.white,
                                                  timeInSecForIosWeb: 1);
                                            }
                                            else{
                                              if (_controllerUserName.text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg: "Enter UserName",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    backgroundColor: rd,
                                                    textColor: Colors.white,
                                                    timeInSecForIosWeb: 1);
                                              }
                                              try {

                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .update({

                                                  "userName":
                                                  _controllerUserName.text.trim(),
                                                }).then((value) => print('success'));

                                                Fluttertoast.showToast(
                                                    msg: "UserName Updated",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    backgroundColor: gc,
                                                    textColor: Colors.white,
                                                    timeInSecForIosWeb: 1);

                                                setState(() {
                                                  print(_controllerUserName.text);
                                                  print('username updated');

                                                });
                                              }catch(e){
                                                Fluttertoast.showToast(
                                                    msg: "Error",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    backgroundColor: rd,
                                                    textColor: Colors.white,
                                                    timeInSecForIosWeb: 1);
                                              }

                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all<Color>(gc),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(10),

                                                )
                                            ),
                                          ),
                                          child: Text(
                                            'Update', style: TextStyle(fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: wc)
                                          ),
                                          // child: Text('Add',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: devSize.height * 0.06,
                                ),

                                Container(
                                  height: devSize.height * 0.08,
                                  width: devSize.width * 0.8,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   _controllerUserName.clear();
                                      // });

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserType()));

                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all<Color>(rd),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(10),

                                          )
                                      ),
                                    ),
                                    child: Text(
                                        'Sign Out', style:TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: wc)),
                                    // child: Text('Cancel',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

                                  ),
                                ),


                              ],
                            ),

                          ),
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
        )
    );

  }
}
