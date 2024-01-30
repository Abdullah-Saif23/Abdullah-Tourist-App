import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/Home/Admin/adminHome.dart';
import 'package:tourism/Home/Guide/guideHome.dart';
import 'package:tourism/Home/Guide/guideNavBar.dart';
import 'package:tourism/Home/User/UserHomePage.dart';
import 'package:tourism/Home/User/dashboard_core_screen.dart';
import 'package:tourism/auth/forgotPassword.dart';
import 'package:tourism/auth/input_validator.dart';
import 'package:tourism/auth/signUp.dart';
import 'package:tourism/const/const.dart';

enum ButtonState {init, loading, done}

class Signin extends StatefulWidget {
  final String userType;

  const Signin({super.key, required this.userType});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  final InputValidator _inputValidator = InputValidator();

  final FirebaseAuth _auth = FirebaseAuth.instance;



  final TextEditingController _controllerEmailLogin = TextEditingController();
  final TextEditingController _controllerPasswordLogin = TextEditingController();
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
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: bg2),),
                SizedBox(height: 30,),

                FlipInX(
                  delay: Duration(milliseconds: 600),
                  child: Container(
                    height: devSize.height*0.45, width: devSize.width*0.85,

                    child:Stack(
                      alignment: Alignment.center,
                      children: [

                        GlassContainer(
                          height: devSize.height*0.35, width: devSize.width*0.85,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,bottom: 15
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword(userType: widget.userType)));
                                  },

                                  child: Container(
                                    width: devSize.width*0.8,
                                    alignment: Alignment.centerRight,
                                    child: Text("Forgot Password ?",style: TextStyle(fontSize: 16,color: fieldborder.withOpacity(0.5)),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: devSize.height*0.35,
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

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(userType: widget.userType)));

                  },
                  child: Container(
                  height: devSize.height*0.08,
                  width: devSize.width*0.9,
                  alignment: Alignment.center,
                  child: Text("Don't have an account? SignUp",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: bg2),),
                              ),
                )

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

              prefs.setString('userEmail',
                  _controllerEmailLogin.text.trim());
              prefs.setString('userPassword',
                  _controllerPasswordLogin.text.trim());
              prefs.setString('userId', result!.uid);

              prefs.setString('userType', widget.userType);

              if(result != null) {



               if(widget.userType == 'User' ||widget.userType == 'Admin' || widget.userType == 'Guide' ) {

                print('we are user if');

                setState(()=> state = ButtonState.done);
                await Future.delayed(Duration(seconds: 1));
                Fluttertoast.showToast(
                  msg: "Successfully Login",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: gc,
                  textColor: wc,
                  timeInSecForIosWeb: 4,
                );
                setState(() {
                  // _isLoading = false;
                  //  ButtonState.loading = false;
                  _controllerEmailLogin.clear();
                  _controllerPasswordLogin.clear();
                });

                // setState(()=> state = ButtonState.init);
                if(widget.userType == "User"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AppBottomNavigationBar(userType: widget.userType)));
                  await Future.delayed(Duration(seconds: 2));
                  setState(()=> state = ButtonState.init);
                }
                else{
                  if(widget.userType == "Admin"){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage(userType: widget.userType)));
                    await Future.delayed(Duration(seconds: 2));
                    setState(()=> state = ButtonState.init);
                  }
                  else{
                    if(widget.userType == "Guide"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GuideNqavBar(userType: widget.userType)));
                      await Future.delayed(Duration(seconds: 2));
                      setState(()=> state = ButtonState.init);
                    }
                  }
                }

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
                  // _isLoading = false;
                  setState(()=> state = ButtonState.init);
                  //  ButtonState.loading = false;
                  // _controllerEmailLogin.clear();
                  // _controllerPasswordLogin.clear();
                });
              }
              }
            } on FirebaseAuthException catch (error) {
              print("we are here");

              if (error.code == 'user-not-found') {
                print('No user found for that email.');
                setState(() {
                  // _isLoadingLoging = false;
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
                  // _isLoadingLoging = false;
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
              setState(() {
                // _isLoadingLoging = false;
              });
              return null;
            }
          }

        }},

      style: ElevatedButton.styleFrom(
          primary: bg2,
          minimumSize: Size(100, 80),
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
