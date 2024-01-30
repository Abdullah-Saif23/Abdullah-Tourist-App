
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/auth/forgotPassword.dart';
import 'package:tourism/auth/input_validator.dart';
import 'package:tourism/const/const.dart';

enum ButtonState {init, loading, done}

class UserSignin extends StatefulWidget {
  final String userType;
  const UserSignin({Key? key, required this.userType}) : super(key: key);

  @override
  State<UserSignin> createState() => _UserSigninState();
}

class _UserSigninState extends State<UserSignin> {
  bool checkbox = false;
  bool isAnimating = true;
  ButtonState state = ButtonState.init;

  final TextEditingController _controllerEmailLogin = TextEditingController();
  final TextEditingController _controllerPasswordLogin = TextEditingController();

  int id = 1;
  int selectedIndex = 0;

  final InputValidator _inputValidator = InputValidator();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //MethodsHandler _methodsHandler = MethodsHandler();
  bool _isLoading = false;
  bool _isLoadingLoging = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    final width = MediaQuery.of(context).size.width*0.8;
    final height = MediaQuery.of(context).size.height*0.07;

    final isDone = state == ButtonState.done;
    final isStretched = isAnimating || state == ButtonState.init;

    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: devSize.height*0.1,
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 1500),

                  child: Container(
                      height: devSize.height*0.19,
                      width: devSize.width*0.5,
                      child: Image.asset('images/logo.png')

                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 1300),

                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: devSize.height*0.08,
                    width: devSize.width*0.8,
                    child: Text('Organ Donation for Royal Hospital',style: TextStyle(color: Colors.black,fontSize:17,),
                    ),
                  ),
                ),
                SizedBox(
                  height: devSize.height*0.1,
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 1100),

                  child: Padding(
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
                          controller: _controllerEmailLogin,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,size:22,color: bg1,),
                            contentPadding: EdgeInsets.only(left: 9.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:  BorderSide(
                                  color: Colors.green,width: 1.5
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:const BorderSide(
                                color: Color(0xff487f63),
                                width: 1,
                              ),
                            ),
                            hintText: 'Email',
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
                FadeInDown(
                  delay: Duration(milliseconds: 900),

                  child: Padding(
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
                          controller: _controllerPasswordLogin,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password_rounded,size:22,color: bg1,),
                            contentPadding: EdgeInsets.only(left: 9.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:  BorderSide(
                                  color: Colors.green,width: 1.5
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:const BorderSide(
                                color: Color(0xff487f63),
                                width: 1,
                              ),
                            ),
                            hintText: 'Password',
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
                FadeInDown(
                  delay: Duration(milliseconds: 700),

                  child: Container(
                    width: devSize.width*0.8,
                    child: Row(
                      children: [
                        Container(
                          height: devSize.height*0.08,
                          width: devSize.width*0.08,
                          child: Checkbox(
                            onChanged: (bool? value) { setState(() {
                              checkbox = value!;
                            }); },
                            value: checkbox,
                            checkColor: wc,
                            activeColor: bg1,
                          ),
                        ),
                        Container(
                          height: devSize.height*0.05,
                          alignment: Alignment.center,

                          child: Text('Remember me'),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(userType: widget.userType)));
                          },
                          child: Container(
                            height: devSize.height*0.05,
                            alignment: Alignment.center,

                            child: Text('Forgot Password\?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff487f63)),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: devSize.height*0.15,
                ),





                FadeInDown(
                  delay: Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    width: state == ButtonState.init ? width:150,
                    height: state == ButtonState.init ? height:50,
                    // onEnd: ()=>setState(()=> isAnimating = !isAnimating),
                    onEnd: ()=> setState(() {
                      isAnimating = !isAnimating;
                    }),
                    child: isStretched ? buildButton(): loadingButton(isDone),

                  ),
                ),







                // FadeInDown(
                //   delay: Duration(milliseconds: 500),
                //
                //   child: Container(
                //     height: devSize.height*0.07,
                //     width: devSize.width*0.8,
                //     child: ElevatedButton(
                //         onPressed: () {
                //           if(widget.userType=='user'){
                //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(userType: 'user')));
                //           }
                //           else if(widget.userType=='admin'){
                //             Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckRequests(userType: 'admin')));
                //
                //           }
                //           else if(widget.userType=='auditOfficer'){
                //             Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditOfficer(userType: 'auditOfficer')));
                //
                //           }
                //         },
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.all<Color>(gc),
                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //               RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20),
                //               )
                //           ),
                //         ),
                //         child: Text('Login',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),)
                //     ),
                //   ),
                // ),



                widget.userType=='user'

                ?FadeInDown(
                  delay: Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () async{
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup(userType: 'user',)));

                    },
                    child: Container(
                        height: devSize.height*0.05,
                        width: devSize.width*0.8,
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'Don\'t have an account\? ',
                                style: TextStyle(fontSize: 14,color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,color: Color(0xff487f63)),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                )
                :Container(),

              ],
            ),


          ),
        ),
      ),


    );
  }



  Widget buildButton()=> ElevatedButton(
      onPressed: () async{

        if (_inputValidator.validateEmail(
            _controllerEmailLogin.text) !=
            'success' &&
            _controllerEmailLogin.text.isNotEmpty) {
          Fluttertoast.showToast(
              msg:
              "Wrong email, please use a correct email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: wc,
              timeInSecForIosWeb: 1);
        }  else if ((_controllerPasswordLogin
            .text.length <
            7 &&
            _controllerPasswordLogin
                .text.isNotEmpty) &&
            (_controllerPasswordLogin.text.length <
                7 &&
                _controllerPasswordLogin
                    .text.isNotEmpty)) {
          Fluttertoast.showToast(
              msg: "Password length must be 8 char",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: wc,
              timeInSecForIosWeb: 1);
        } else {
          if (_controllerEmailLogin.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter Email Address",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: wc,
                timeInSecForIosWeb: 1);
          } else if (_controllerPasswordLogin
              .text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Enter Password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: wc,
                timeInSecForIosWeb: 1);
          }

          else {
            print('we are in top else');

            setState(() {
              // _isLoadingLoging = true;
              state = ButtonState.loading;
            }
            );
            //createAccount();
            //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
            SharedPreferences prefs =
            await SharedPreferences.getInstance();
            try {
              User? result = (await _auth
                  .signInWithEmailAndPassword(
                  email: _controllerEmailLogin.text.trim(),
                  password: _controllerPasswordLogin.text.trim())).user;

              // var user = result;
              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(user!.uid)
              //     .set({
              //   "email": _controllerEmail.text.trim(),
              //   "password":
              //       _controllerPassword.text.trim(),
              //   "userName":
              //       _controllerUserName.text.trim(),
              //   "confirmPassword":
              //       _controllerConfirmPass.text
              //           .trim(),
              //   "uid": user.uid,
              // }).then((value) => print('success'));
              // prefs.setString('userEmail',
              //     _controllerEmail.text.trim());
              // prefs.setString('userPassword',
              //     _controllerPassword.text.trim());
              // prefs.setString('userId', user.uid);
              // print('Account creation successful');

              prefs.setString('userEmail',
                  _controllerEmailLogin.text.trim());
              prefs.setString('userPassword',
                  _controllerPasswordLogin.text.trim());
              prefs.setString('userId', result!.uid);

              prefs.setString('userType', widget.userType);

              if(result != null) {

               if(widget.userType == 'admin' && _controllerEmailLogin.text == 'admiin.hiba@gmail.com' && _controllerPasswordLogin.text == '12345678'){
                 print('we are in admin');
                 setState(()=> state = ButtonState.done);
                 await Future.delayed(Duration(seconds: 1));

                 Fluttertoast.showToast(
                   msg: "Successfully Login",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   backgroundColor: bg2,
                   textColor: wc,
                   timeInSecForIosWeb: 4,
                 );
                 setState(() {
                   _isLoading = false;
                   //ButtonState.loading = false;
                   _controllerEmailLogin.clear();
                   _controllerPasswordLogin.clear();
                 });

                 // setState(()=> state = ButtonState.init);
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckRequests(userType: 'admin')));
                 await Future.delayed(Duration(seconds: 2));
                 setState(()=> state = ButtonState.init);


                 // Fluttertoast.showToast(
                //     msg: "Email and password doesnot match",
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.BOTTOM,
                //     backgroundColor: rd,
                //     textColor: wc,
                //     timeInSecForIosWeb: 1);
                // setState(()=> state = ButtonState.init);

              }


               else{
                 print('we are in last else');
                 print(widget.userType);
               if(widget.userType == 'auditOfficer'&& _controllerEmailLogin.text == 'audauditofficer@gmail.com' && _controllerPasswordLogin.text == '12345678'){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditOfficer(userType: 'auditOfficer',)));

                 print('we are audit Officer if');


                 setState(()=> state = ButtonState.done);
                await Future.delayed(Duration(seconds: 1));

                Fluttertoast.showToast(
                  msg: "Successfully Login",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: bg2,
                  textColor: wc,
                  timeInSecForIosWeb: 4,
                );
                setState(() {
                  _isLoading = false;
                  //   ButtonState.loading = false;
                  _controllerEmailLogin.clear();
                  _controllerPasswordLogin.clear();
                });

                // setState(()=> state = ButtonState.init);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuditOfficer(userType: 'auditOfficer')));
                await Future.delayed(Duration(seconds: 2));
                setState(()=> state = ButtonState.init);

              }
              else if(widget.userType == 'user') {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(userType: 'user',)));

                 print('we are user if');




                // setState(()=> state = ButtonState.loading);
                // await Future.delayed(Duration(seconds: 1));

                setState(()=> state = ButtonState.done);
                await Future.delayed(Duration(seconds: 1));
                Fluttertoast.showToast(
                  msg: "Successfully Login",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: bg2,
                  textColor: wc,
                  timeInSecForIosWeb: 4,
                );
                setState(() {
                  _isLoading = false;
                  //  ButtonState.loading = false;
                  _controllerEmailLogin.clear();
                  _controllerPasswordLogin.clear();
                });

                // setState(()=> state = ButtonState.init);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(userType: 'user')));
                await Future.delayed(Duration(seconds: 2));
                setState(()=> state = ButtonState.init);
              }
              else {
                 await Future.delayed(Duration(seconds: 1));
                 Fluttertoast.showToast(
                   msg: "Sorry Invalid Credentials",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   backgroundColor: rd,
                   textColor: wc,
                   timeInSecForIosWeb: 4,
                 );

                 setState(() {
                   _isLoading = false;
                   setState(()=> state = ButtonState.init);
                   //  ButtonState.loading = false;
                   _controllerEmailLogin.clear();
                   _controllerPasswordLogin.clear();
                 });
               }
               }






              }




            } on FirebaseAuthException catch (error) {
              print("we are here");

              if (error.code == 'user-not-found') {
                print('No user found for that email.');
                setState(() {
                  _isLoadingLoging = false;
                });
                Fluttertoast.showToast(
                  msg: "User with this email doesn't exist.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 4,
                );
                setState(()=> state = ButtonState.init);

              } else if (error.code == 'wrong-password') {
                setState(() {
                  _isLoadingLoging = false;
                });
                Fluttertoast.showToast(
                  msg: "Your password is wrong.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 4,
                );
                setState(()=> state = ButtonState.init);

                print('Wrong password provided for that user.');
              }

              // switch (error.code) {
              //   case "ERROR_INVALID_EMAIL":
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg: "Your email address appears to be malformed.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //     break;
              //   case "wrong-password":
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg: "Your password is wrong.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //     break;
              //   case "user-not-found":
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg: "User with this email doesn't exist.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //
              //     break;
              //   case "ERROR_USER_DISABLED":
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg: "User with this email has been disabled.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //
              //     break;
              //   case "ERROR_TOO_MANY_REQUESTS":
              //
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg:  "Too many requests. Try again later.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //
              //     break;
              //   case "ERROR_OPERATION_NOT_ALLOWED":
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg:  "Signing in with Email and Password is not enabled.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              //
              //     break;
              //   default:
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     Fluttertoast.showToast(
              //       msg:  "An undefined Error happened.",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       timeInSecForIosWeb: 4,
              //     );
              // }
              //
              setState(() {
                _isLoadingLoging = false;
              });
              return null;
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
          primary: bg2,
          minimumSize: Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
      child: FittedBox(child: Text('Login',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.white),))
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
        child:Lottie.asset('lottie/success1.json',repeat: false,),
      )
          : Container(
          alignment: Alignment.center,
          child: SpinKitCubeGrid(
            size: 50,
            color: bg2,
          )
      ),
    );
  }
}

