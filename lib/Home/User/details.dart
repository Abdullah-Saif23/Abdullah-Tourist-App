import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourism/Home/User/dashboard_core_screen.dart';
import 'package:tourism/const/const.dart';


class Details extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userNo;
  final String placeImage;
  final String placeName;
  final String cityName;
  final String price;
  final String description;
  final String docId;
  final String Status;
  const Details({super.key, required this.placeImage,
    required this.placeName, required this.cityName,
    required this.price, required this.description,
    required this.docId, required this.Status, required this.userName,
    required this.userImage, required this.userNo});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;

  int People = 0;

  String? Name;
  String? Imagee;
  String? City;
  String? Description;
  String? Price;
  String? DocId;

  bool more = true;
  bool field = false;
  final TextEditingController _controllerPeople = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    // if(widget.Status == "Places"){
    //   setState(() {
    //     Name = widget.placeName;
    //     Imagee = widget.placeImage;
    //     City = widget.cityName;
    //     Price = widget.price;
    //     Description = widget.description;
    //     DocId = widget.docId;
    //   });
    // }

    print(widget.placeName);
    print(widget.placeImage);
    print(widget.cityName);
    print(widget.price);
    print(widget.description);
    print(widget.Status);
    print(widget.docId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(
        child: Container(
          height: devSize.height,
          width: devSize.width,
          child: Column(
            children: [

              Container(
                height: devSize.height*0.99,

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
                            image: NetworkImage(widget.placeImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Image.network(widget.placeImage),
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

                            SizedBox(height: devSize.height*0.03,),
                            Container(
                              width: devSize.width*0.85,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(widget.placeName,
                                    style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                  ),

                                  Row(
                                    children: [
                                      Text(widget.price,
                                        style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                      ),
                                      Text("\$",
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
                                    widget.Status == "Cuisines"?
                                        Container():

                                    Icon(Icons.location_on,color: bg2,size: 28,),
                                    SizedBox(width: 10,),

                                    widget.Status == "Cuisines"?
                                        Container():
                                    Text(widget.cityName,
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
                                child: Text("People",
                                  style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600,color: bl),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: devSize.width*0.85,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // more == true
                                    Visibility(
                                      visible: more,
                                      child: Container(
                                        width: devSize.width*0.7,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                print("We are in One Container");
                                                if(one == true){
                                                  setState(() {
                                                    one = false;
                                                    two = false;
                                                    three = false;
                                                    four = false;
                                                    five = false;
                                                    People = 0;
                                                  });
                                                }
                                                else{
                                                  if(one == false){
                                                    setState(() {
                                                      one = true;
                                                      two = false;
                                                      three = false;
                                                      four = false;
                                                      five = false;
                                                      People = 1;
                                                    });

                                                  }

                                                }
                                                print(one);
                                                print(People);

                                              } ,
                                              child: Container(
                                                width: 40,height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: one == true ? bg2 : bg2.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("1",
                                                  style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                                      color: one == true ?bl : bl),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                print("We are in two Container");
                                                if(two == true){
                                                  setState(() {
                                                    one = false;
                                                    two = false;
                                                    three = false;
                                                    four = false;
                                                    five = false;
                                                    People = 0;
                                                  });
                                                }
                                                else{
                                                  if(two == false){
                                                    setState(() {
                                                      one = false;
                                                      two = true;
                                                      three = false;
                                                      four = false;
                                                      five = false;
                                                      People = 2;
                                                    });

                                                  }

                                                }
                                                print(two);
                                                print(People);

                                              } ,
                                              child: Container(
                                                width: 40,height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: two == true ? bg2 : bg2.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("2",
                                                  style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                                      color: two == true ?bl : bl),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                print("We are in One Container");
                                                if(three == true){
                                                  setState(() {
                                                    one = false;
                                                    two = false;
                                                    three = false;
                                                    four = false;
                                                    five = false;
                                                    People = 0;
                                                  });
                                                }
                                                else{
                                                  if(three == false){
                                                    setState(() {
                                                      one = false;
                                                      two = false;
                                                      three = true;
                                                      four = false;
                                                      five = false;
                                                      People = 3;
                                                    });

                                                  }

                                                }
                                                print(three);
                                                print(People);

                                              } ,
                                              child: Container(
                                                width: 40,height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: three == true ? bg2 : bg2.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("3",
                                                  style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                                      color: three == true ?bl : bl),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                print("We are in One Container");
                                                if(four == true){
                                                  setState(() {
                                                    one = false;
                                                    two = false;
                                                    three = false;
                                                    four = false;
                                                    five = false;
                                                    People = 0;
                                                  });
                                                }
                                                else{
                                                  if(one == false){
                                                    setState(() {
                                                      one = false;
                                                      two = false;
                                                      three = false;
                                                      four = true;
                                                      five = false;
                                                      People = 4;
                                                    });

                                                  }

                                                }
                                                print(four);
                                                print(People);

                                              } ,
                                              child: Container(
                                                width: 40,height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: four == true ? bg2 : bg2.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("4",
                                                  style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                                      color: four == true ?bl : bl),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:(){
                                                print("We are in five Container");
                                                if(five == true){
                                                  setState(() {
                                                    one = false;
                                                    two = false;
                                                    three = false;
                                                    four = false;
                                                    five = false;
                                                    People = 0;
                                                  });
                                                }
                                                else{
                                                  if(one == false){
                                                    setState(() {
                                                      one = false;
                                                      two = false;
                                                      three = false;
                                                      four = false;
                                                      five = true;
                                                      People = 5;
                                                    });

                                                  }

                                                }
                                                print(five);
                                                print(People);

                                              } ,
                                              child: Container(
                                                width: 40,height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: five == true ? bg2 : bg2.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text("5",
                                                  style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                                      color: five == true ?bl : bl),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                    // Visibility(
                                    //   visible: field,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(
                                    //       top: 8.0,
                                    //     ),
                                    //     child: Container(
                                    //       // height: size.height * 0.1,
                                    //         width: devSize.width * 0.7,
                                    //         // decoration: BoxDecoration(
                                    //         //   border: Border.all(width: 2,color: Colors.blue),
                                    //         // ),
                                    //
                                    //         child: TextFormField(
                                    //           controller: _controllerPeople,
                                    //           keyboardType: TextInputType.number,
                                    //           decoration: InputDecoration(
                                    //             // prefixIcon: Icon(Icons.add,size:22,color: gc,),
                                    //
                                    //             contentPadding: EdgeInsets.only(left: 9.0),
                                    //             focusedBorder: OutlineInputBorder(
                                    //               borderRadius: BorderRadius.circular(5),
                                    //               borderSide:  BorderSide(
                                    //                   color: fieldborder,width: 1.5
                                    //               ),
                                    //             ),
                                    //             enabledBorder: OutlineInputBorder(
                                    //               borderRadius: BorderRadius.circular(5),
                                    //               borderSide: BorderSide(
                                    //                 color: fieldborder.withOpacity(0.5),
                                    //                 width: 1,
                                    //               ),
                                    //             ),
                                    //             hintText: ' Total Persons',
                                    //             hintStyle: TextStyle(color: fieldborder.withOpacity(0.5)),
                                    //           ),
                                    //           // validator: (value) {
                                    //           //   //EmailValidator.validate(value!);
                                    //           //   if (!EmailValidator.validate(_emailController.text)) {
                                    //           //     return 'Please provide valid email';
                                    //           //   }
                                    //           //   return null;
                                    //           // },
                                    //         )),
                                    //   ),
                                    // ),

                                    // GestureDetector(
                                    //   onTap:(){
                                    //     print("We are in More Container");
                                    //     if(more == true){
                                    //       setState(() {
                                    //         more == false;
                                    //         field == true;
                                    //       });
                                    //     }
                                    //     else{
                                    //       if(more == false){
                                    //         setState(() {
                                    //           more == true;
                                    //           field == false;
                                    //         });
                                    //
                                    //       }
                                    //
                                    //     }
                                    //     print("More $more");
                                    //     print("Field $field");
                                    //
                                    //   } ,
                                    //   child: Container(
                                    //     width: 40,height: 40,
                                    //     alignment: Alignment.center,
                                    //     decoration: BoxDecoration(
                                    //         color: more == false ? bg2 : bg2.withOpacity(0.2),
                                    //         borderRadius: BorderRadius.circular(10)
                                    //     ),
                                    //     child: Text(more == false ? "+" : "-",
                                    //       style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600,
                                    //           color: more == true ?bl : bl),
                                    //     ),
                                    //   ),
                                    // ),


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
                                height: devSize.height*0.2,
                                // color: Colors.red,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                      widget.description,
                                      textAlign: TextAlign.justify,
                                      maxLines: 100,style: TextStyle(fontSize: 15,color: bl),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: bookButton(),
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
                            child: Icon(Icons.arrow_back_ios,size: 25,color: bg2,)))

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget bookButton()=> ElevatedButton(
      onPressed: () async{
        if(widget.Status == "Places"){
          if(People == 0){
            Fluttertoast.showToast(
                msg:
                "Please Add Persons",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: rd,
                textColor: wc,
                timeInSecForIosWeb: 1);
          }

          else{
            try {

              FirebaseFirestore.instance
                  .collection('PlacesBookings')
                  .doc()
                  .set({
                "userImage": widget.userImage.toString().trim(),
                "userName": widget.userName.toString().trim(),
                "userNo": widget.userNo.toString().trim(),
                "placeImage": widget.placeImage.toString().trim(),
                "placeName": widget.placeName.toString().trim(),
                "cityName": widget.cityName.toString().trim(),
                "price": widget.price.toString().trim(),
                "description": widget.description.toString().trim(),
                "person": People.toString().trim(),
                "status": widget.Status.toString().trim(),
                "status2": "Pending",
                "Uid": auth.currentUser!.uid,
                "GUid": "",
                "guideName": "",
                "guideImage": "",


              }).then((value) => print('success'));

              Fluttertoast.showToast(
                msg: "Place Booked Successfully",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: gc,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: UserType)));
              setState(() {
                People = 0;


                // _isLoading = false;
              });
            }
            catch (e) {
              print("we are in catch");
              print(e);
              setState(() {
                // _isLoading = false;
              });
            }
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AppBottomNavigationBar(userType: 'User',)));



          }
        }
        else{
          if(widget.Status == "Resturants"){
            if(People == 0){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Persons",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }

            else{
              try {

                FirebaseFirestore.instance
                    .collection('ResturantsBookings')
                    .doc()
                    .set({
                  "userImage": widget.userImage.toString().trim(),
                  "userName": widget.userName.toString().trim(),
                  "userNo": widget.userNo.toString().trim(),
                  "placeImage": widget.placeImage.toString().trim(),
                  "placeName": widget.placeName.toString().trim(),
                  "cityName": widget.cityName.toString().trim(),
                  "price": widget.price.toString().trim(),
                  "description": widget.description.toString().trim(),
                  "person": People.toString().trim(),
                  "status": widget.Status.toString().trim(),
                  "status2": "Pending",
                  "Uid": auth.currentUser!.uid,
                  "GUid": "",


                }).then((value) => print('success'));

                Fluttertoast.showToast(
                  msg: "Resturant Booked Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: gc,
                  textColor: Colors.white,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                );
                setState(() {
                  People = 0;


                  // _isLoading = false;
                });
              }
              catch (e) {
                print("we are in catch");
                print(e);
                setState(() {
                  // _isLoading = false;
                });
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AppBottomNavigationBar(userType: "User")));



            }
          }
          else{
            if(widget.Status == "Cuisines"){
              if(People == 0){
                Fluttertoast.showToast(
                    msg:
                    "Please Add Persons",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: rd,
                    textColor: wc,
                    timeInSecForIosWeb: 1);
              }

              else{
                try {

                  FirebaseFirestore.instance
                      .collection('CuisinesBookings')
                      .doc()
                      .set({
                    "userImage": widget.userImage.toString().trim(),
                    "userName": widget.userName.toString().trim(),
                    "userNo": widget.userNo.toString().trim(),
                    "placeImage": widget.placeImage.toString().trim(),
                    "placeName": widget.placeName.toString().trim(),
                    "cityName": widget.cityName.toString().trim(),
                    "price": widget.price.toString().trim(),
                    "description": widget.description.toString().trim(),
                    "person": People.toString().trim(),
                    "status": widget.Status.toString().trim(),
                    "status2": "Pending",
                    "Uid": auth.currentUser!.uid,
                    "GUid": "",

                  }).then((value) => print('success'));

                  Fluttertoast.showToast(
                    msg: "Cuisine Booked Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: gc,
                    textColor: Colors.white,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                  );
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: UserType)));
                  setState(() {
                    People = 0;
                    // _isLoading = false;
                  });
                }
                catch (e) {
                  print("we are in catch");
                  print(e);
                  setState(() {
                    // _isLoading = false;
                  });
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AppBottomNavigationBar(userType: "User")));

              }
            }

          }

        }

        },

      style: ElevatedButton.styleFrom(
          primary: bg2,
          minimumSize: Size(300, 45),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(50),
          // )
      ),
      child: FittedBox(child: Text(
        widget.Status == "Places"?
        'Book Trip Now -->':
        widget.Status == "Resturants"?
        'Book Resturant Now -->':
        widget.Status == "Cuisines"?
        'Book Cuisine Now -->':
        'Book Now -->',

        style: TextStyle(fontSize: 17,fontWeight:FontWeight.w500,color: Colors.white),))
  );


}
