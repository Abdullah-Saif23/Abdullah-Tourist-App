import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:tourism/auth/signUp.dart';
import 'package:tourism/auth/signin.dart';
import 'package:tourism/const/const.dart';

enum ButtonState {init, loading, done}

class ForgotPassword extends StatefulWidget {
  final String userType;

  const ForgotPassword({super.key, required this.userType});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  final TextEditingController _controllerEmail = TextEditingController();


  late String _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;


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
                image: AssetImage("assets/images/forgotpassword.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: widget.userType)));

                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: devSize.height*0.15, width: devSize.width*0.85,

                        child: Icon(Icons.arrow_back_ios,size: 25,color: bg2,))
                ),
                Text("Reset Password",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: bg2),),
                SizedBox(height: 30,),
                FlipInX(
                  delay: Duration(milliseconds: 600),
                  child: Container(
                    height: devSize.height*0.3, width: devSize.width*0.85,

                    child:Stack(
                      alignment: Alignment.center,
                      children: [
                        GlassContainer(
                          height: devSize.height*0.2, width: devSize.width*0.85,
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
                                    top: 15,bottom: 10
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

                            ],
                          ),
                        ),
                        Positioned(
                          top: devSize.height*0.2,
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
                SizedBox(height: devSize.height*0.36,),


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildButton()=> ElevatedButton(
      onPressed: () async{

        if (_controllerEmail
            .text.isEmpty) {
          Fluttertoast.showToast(
              msg: "Please Enter Your Email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: rd,
              textColor: wc,
              timeInSecForIosWeb: 1);
        }

        else{
          setState(() {
            state = ButtonState.loading;
          });
          await _auth.sendPasswordResetEmail(email: _controllerEmail.text)
              .then((value){

            Fluttertoast.showToast(
              msg: "Check your Email Spam Folder for reset link",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: rd,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
            );
            setState(()=> state = ButtonState.done);

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: widget.userType)));

          }
          );
        }

      },
      style: ElevatedButton.styleFrom(
          primary: bg2,
          minimumSize: Size(120, 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
      ),
      child: FittedBox(child: Text('Reset Password',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.white),))
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
