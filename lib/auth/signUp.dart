import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/auth/input_validator.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/const/const.dart';

enum ButtonState {init, loading, done}

class SignUp extends StatefulWidget {
  final String userType;

  const SignUp({super.key, required this.userType});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;
  String UserType = "";

  final InputValidator _inputValidator = InputValidator();


  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhNo = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  // EmailAuth emailAuth =  new EmailAuth(sessionName: "Sample session");

  int id = 1;
  int selectedIndex = 0;
  String? imagePhote;


  final FirebaseAuth _auth = FirebaseAuth.instance;

  getImages()  {
    print('we are here');
    FirebaseFirestore.instance.collection('Categories').where('uid', isEqualTo: uid).snapshots().forEach((element) {
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

          print(imagePhote.toString());
          // if(isProfile){
          //   FirebaseFirestore.instance
          //       .collection('users').doc(auth.currentUser!.uid).update({
          //     'profilePhoto': value.toString()
          //   }).then((value) {
          //     setState(() {
          //       isProfileLoading = false;
          //     });
          //     print('Success uploaded profile');
          //   });
          // }
          // else {
          //
          //   setState(() {
          //     _idCardImages.add(value);
          //   });
          //   FirebaseFirestore.instance
          //       .collection('Categories').doc(auth.currentUser!.uid).update({
          //     'profilePhoto': _idCardImages
          //   }).then((value) {
          //     setState(() {
          //       isLoading = false;
          //     });
          //     print('Success uploaded photos');
          //   });
          // }

          print("NUll");

        } else {
          print('sorry error');
        }
      });
    });
  }

  _imgFromGallery() async {


    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      print('List Printed');
      getUrl(_pickedFile!.path).then((value1) {
        // setState(() {
        //   _idCardImages.add(value1.toString());
        // });
        setState(() {
          imagePhote = value1.toString();
          isLoading = false;
        });
        print('value above');
        print(imagePhote.toString());
        print('Success uploaded photos');
        // FirebaseFirestore.instance
        //     .collection('users').doc(auth.currentUser!.uid).update({
        //   'profilePhoto': _idCardImages
        // }).then((value) {
        //   print(value1.toString());
        //   print('value abpve');
        //
        //   print('value abpve');
        //   print(imagePhote.toString());
        //   print('Success uploaded photos');
        // });
      });
    });
  }

  void _showPicker(context) {
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

                        _imgFromGallery();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(true);
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

    print(_idCardImages.length.toString() + " HTTPS://F");
    print(_idCardImages);
    print(_idCardImages);
  }

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

  File? image;

  @override
  void initState() {
    // TODO: implement initState
    UserType = widget.userType;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width*0.42;
    final height = MediaQuery.of(context).size.height*0.09;

    final isDone = state == ButtonState.done;
    final isStretched = isAnimating || state == ButtonState.init;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width:devSize.width*1,
            height: devSize.height*1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("SignUp",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: bg2),),
                SizedBox(height: 20,),

                FlipInX(
                  delay: Duration(milliseconds: 600),
                  child: Container(
                    height: devSize.height*0.78,
                    width: devSize.width,
                    child:Stack(
                      alignment: Alignment.center,
                      children: [
                        GlassContainer(
                          height: devSize.height*0.65, width: devSize.width*0.85,
                          color: login.withOpacity(0.6),
                          borderColor: bg2,
                          blur: 0,
                          elevation: 15,
                          isFrostedGlass: false,
                          shadowColor: login.withOpacity(0.1),
                          alignment: Alignment.center,
                          frostedOpacity: 1,
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15,bottom: 5
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
                                      cursorColor: fieldborder,
                                      style: TextStyle(fontSize: 19,color: fieldborder),

                                      decoration: InputDecoration(
                                        fillColor: fieldborder,
                                        suffixIcon: Icon(Icons.person,color: fieldborder,size: 25,),
                                        contentPadding: EdgeInsets.only(left: 9.0,top: 10),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: fieldborder,width: 1.5
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:const BorderSide(
                                            color: fieldborder,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'User Name',
                                        hintStyle: TextStyle(color: fieldborder),
                                      ),

                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15,bottom: 5
                                ),
                                child: Container(
                                  // height: size.height * 0.1,
                                    width: devSize.width * 0.8,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(width: 2,color: Colors.blue),
                                    // ),

                                    child: TextFormField(
                                      controller: _controllerEmail,
                                      keyboardType: TextInputType.text,
                                      cursorColor: fieldborder,
                                      style: TextStyle(fontSize: 19,color: fieldborder),

                                      decoration: InputDecoration(
                                        fillColor: fieldborder,
                                        suffixIcon: Icon(Icons.mail_rounded,color: fieldborder,size: 25,),
                                        contentPadding: EdgeInsets.only(left: 9.0,top: 10),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: fieldborder,width: 1.5
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:const BorderSide(
                                            color: fieldborder,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(color: fieldborder),
                                      ),

                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15,bottom: 5
                                ),
                                child: Container(
                                  // height: size.height * 0.1,
                                    width: devSize.width * 0.8,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(width: 2,color: Colors.blue),
                                    // ),

                                    child: TextFormField(
                                      controller: _controllerPhNo,
                                      keyboardType: TextInputType.phone,
                                      cursorColor: fieldborder,
                                      style: TextStyle(fontSize: 19,color: fieldborder),

                                      decoration: InputDecoration(
                                        fillColor: fieldborder,
                                        suffixIcon: Icon(Icons.phone,color: fieldborder,size: 25,),
                                        contentPadding: EdgeInsets.only(left: 9.0,top: 10),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: fieldborder,width: 1.5
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:const BorderSide(
                                            color: fieldborder,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'Phone Number',
                                        hintStyle: TextStyle(color: fieldborder),
                                      ),

                                    )),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,bottom: 5
                                ),
                                child: Container(
                                  // height: size.height * 0.1,
                                    width: devSize.width * 0.8,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(width: 2,color: Colors.blue),
                                    // ),

                                    child: TextFormField(
                                      controller: _controllerPassword,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      cursorColor: fieldborder,
                                      style: TextStyle(fontSize: 19,color: fieldborder),


                                      decoration: InputDecoration(
                                        fillColor: fieldborder,
                                        suffixIcon: Icon(Icons.key,color: fieldborder,size: 25,),
                                        contentPadding: EdgeInsets.only(left: 9.0,top: 10),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: fieldborder,width: 1.5
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:const BorderSide(
                                            color: fieldborder,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: fieldborder),
                                      ),

                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,bottom: 5
                                ),
                                child: Container(
                                  // height: size.height * 0.1,
                                    width: devSize.width * 0.8,
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(width: 2,color: Colors.blue),
                                    // ),

                                    child: TextFormField(
                                      controller: _controllerConfirmPassword,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      cursorColor: fieldborder,
                                      style: TextStyle(fontSize: 19,color: fieldborder),


                                      decoration: InputDecoration(
                                        fillColor: fieldborder,
                                        suffixIcon: Icon(Icons.key,color: fieldborder,size: 25,),
                                        contentPadding: EdgeInsets.only(left: 9.0,top: 10),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: fieldborder,width: 1.5
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:const BorderSide(
                                            color: fieldborder,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(color: fieldborder),
                                      ),

                                    )),
                              ),


                            ],
                          ),
                        ),
                        Positioned(
                          bottom: devSize.height*0.029,
                          child: FadeIn(
                            delay: Duration(milliseconds: 700),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              width: state == ButtonState.init ? width:100,
                              height: state == ButtonState.init ? height:30,
                              // onEnd: ()=>setState(()=> isAnimating = !isAnimating),
                              onEnd: ()=> setState(() {
                                isAnimating = !isAnimating;
                              }),
                              child: isStretched ? buildButton(): loadingButton(isDone),

                            ),
                          ),
                        ),
                        Positioned(
                          top: devSize.height*0.0,
                          child: FadeIn(
                            delay: Duration(milliseconds: 700),
                            child: Container(
                              height: devSize.height*0.125,
                              width: devSize.width*0.3,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  CircleAvatar(
                                    radius: 42,
                                    backgroundColor: bg2,
                                    child: CircleAvatar(
                                      backgroundColor:onbText,
                                      // backgroundImage: AssetImage('assets/icons/user.png',),
                                      backgroundImage: NetworkImage(
                                        imagePhote == null
                                            ? 'https://i.pinimg.com/originals/25/29/4d/25294d1003ffe106463b5484e19aab30.jpg'
                                            : imagePhote.toString(),
                                        // streamSnapshot.data!.docs[index]['profilePhoto'].toString()

                                      ),
                                      radius: 40,

                                    ),
                                  ),
                                  Positioned(
                                    top: 0,left: 75,
                                    child: GestureDetector(
                                      onTap: (){
                                        _showPicker(context);
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
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: widget.userType)));
                  },
                  child: Container(
                    height: devSize.height*0.08,
                    width: devSize.width*0.9,
                    alignment: Alignment.center,
                    child: Text("Already have an account? SignIn",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: bg2),),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildButton()=> ElevatedButton(
      onPressed: () async{
        print("We are in signup button");
        print(imagePhote.toString());
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
        else if (_inputValidator.validateEmail(
            _controllerEmail.text) !=
            'success' &&
            _controllerEmail.text.isNotEmpty) {
          Fluttertoast.showToast(
              msg:
              "Wrong email, please use a correct email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: Colors.white,
              timeInSecForIosWeb: 1);}

        else if (_inputValidator.validateMobile(
            _controllerPhNo.text) !=
            'success' &&
            _controllerEmail.text.isNotEmpty) {
          Fluttertoast.showToast(
              msg:
              "Wrong MobileNo",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: Colors.white,
              timeInSecForIosWeb: 1);
        } else if ((_controllerPassword.text.length <
            7 &&
            _controllerPassword
                .text.isNotEmpty) &&
            (_controllerConfirmPassword.text.length < 7 &&
                _controllerConfirmPassword
                    .text.isNotEmpty)) {
          Fluttertoast.showToast(
              msg: "Password length must be 8 char",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: Colors.white,
              timeInSecForIosWeb: 1);
        } else if (_controllerPassword.text !=
            _controllerConfirmPassword.text) {
          Fluttertoast.showToast(
              msg:
              "Password and confirm password must be same",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: Colors.white,
              timeInSecForIosWeb: 1);
        } else {
          if (_controllerUserName.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter UserName",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: Colors.white,
                timeInSecForIosWeb: 1);
          }
          else if (_controllerEmail.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter Email",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: Colors.white,
                timeInSecForIosWeb: 1);
          }else if (_inputValidator.validateMobile(
              _controllerPhNo.text) !=
              'success' &&
              _controllerEmail.text.isEmpty) {
            Fluttertoast.showToast(
                msg:
                "Wrong MobileNo",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: Colors.white,
                timeInSecForIosWeb: 1);
          }
          else if (_controllerPassword
              .text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter Password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: Colors.white,
                timeInSecForIosWeb: 1);
          } else if (_controllerConfirmPassword
              .text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter Confirm Password",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: rd,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
          }
          else {
            setState(() {
              // _isLoading = true;
              print('We are in loading');
              // state = ButtonState.loading;

            });

            setState(()=> state = ButtonState.loading);

            SharedPreferences prefs =
            await SharedPreferences.getInstance();
            try {
              print('we are shared prefenrences');
              User? result = (await _auth
                  .createUserWithEmailAndPassword(
                  email: _controllerEmail.text
                      .trim(),
                  password:
                  _controllerPassword.text
                      .trim()))
                  .user;
              var user = result;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .set({
                "email": _controllerEmail.text.trim(),
                "password": _controllerPassword.text.trim(),
                "userName": _controllerUserName.text.trim(),
                "confirmPassword": _controllerConfirmPassword.text.trim(),
                "MobileNo":_controllerPhNo.text.trim(),
                "uid": user.uid,
                "profilePhoto": imagePhote.toString().trim(),
                "UserType": UserType.toString().trim(),

              }).then((value) => print('success'));
              prefs.setString('userEmail',
                  _controllerEmail.text.trim());
              prefs.setString('userPassword',
                  _controllerPassword.text.trim());
              prefs.setString('userId', user.uid);
              print('Account creation successful');


              setState(()=> state = ButtonState.done);
              await Future.delayed(Duration(seconds: 1));

              // setState(()=> state = ButtonState.init);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(userType: 'user')));
              // await Future.delayed(Duration(seconds: 2));
              setState(()=> state = ButtonState.init);
              Fluttertoast.showToast(
                msg: "Account created successfully",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: gc,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
              );
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: UserType)));
              setState(() {
                selectedIndex = 0;
                _controllerUserName.clear();
                _controllerPhNo.clear();
                _controllerEmail.clear();
                _controllerPassword.clear();
                _controllerConfirmPassword.clear();

                // _isLoading = false;
              });
            }
            on FirebaseAuthException catch (e) {
              print("we are in fire base auth exception");
              print(e.code.toString());
              print("we are in fire base auth exception");

              // Fluttertoast.showToast(
              //   msg: e.toString(),
              //   toastLength: Toast.LENGTH_SHORT,
              //   backgroundColor: gc,
              //   textColor: Colors.white,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 4,
              // );
              if (e.code.toString() == 'email-already-in-use') {
                print('we are in last if');
                // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
                setState(() {
                  print(" We are in nmzxcbdhcvjhvdhjcvjhbscjhvbjhbchjhbcjh");
                  // state = ButtonState.loading;

                  // _isLoading = false;
                  setState(()=> state = ButtonState.init);

                });
              }
            } catch (e) {
              print("we are in catch");
              print(e);
              setState(() {
                // _isLoading = false;
                setState(()=> state = ButtonState.init);

              });
            }

            // catch (e) {
            //   setState(() {
            //     // _isLoading = false;
            //     setState(()=> state = ButtonState.init);
            //
            //   });
            //   return null;
            // }


          }
        }},

      style: ElevatedButton.styleFrom(
          primary: bg2,
          minimumSize: Size(100, 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
      child: FittedBox(child: Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.white),))
  );

  Widget loadingButton(isDone){
    final color = isDone ? Colors.transparent : Colors.transparent;

    return  Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: isDone
          ? Container(
        // height: state==ButtonState.done ? height:100,
        // width: 300,
        child:Lottie.asset('assets/lottie/success1.json',repeat: false,),
      )
          : Container(
          alignment: Alignment.center,
          child: SpinKitFadingCircle(
            size: 50,
            color: bg2,
          )
      ),
    );
  }
}
