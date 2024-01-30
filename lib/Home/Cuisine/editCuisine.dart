import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourism/const/const.dart';

class EditCuisine extends StatefulWidget {
  final String cuisineImage;
  final String cuisineName;
  final String cityName;
  final String price;
  final String description;
  final String docId;
  final String Status;
  const EditCuisine({super.key, required this.cuisineImage,
    required this.cuisineName, required this.cityName,
    required this.price, required this.description, required this.docId, required this.Status});

  @override
  State<EditCuisine> createState() => _EditCuisineState();
}

class _EditCuisineState extends State<EditCuisine> {
  final TextEditingController _controllerPlace = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();


  final FirebaseAuth auth = FirebaseAuth.instance;

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
  String? imagePhote;

  String? DocId;


  void initState() {
    if(widget.Status == "Edit"){
      imagePhote = widget.cuisineImage;
      _controllerPlace.text = widget.cuisineName;
      _controllerCity.text = widget.cityName;
      _controllerPrice.text = widget.price;
      _controllerDescription.text = widget.description;
      DocId = widget.docId;
    }
    else{
      if(widget.Status == "Add"){
        imagePhote = "https://image.shutterstock.com/image-vector/hand-drawn-set-healthy-food-260nw-532470079.jpg";
        _controllerPlace.text.isEmpty;
        _controllerCity.text.isEmpty;
        _controllerPrice.text.isEmpty;
        _controllerDescription.text.isEmpty;
        DocId = widget.docId;
      }
    }
    // TODO: implement initState
    super.initState();
    // print(auth.currentUser!.uid);
    getImages();
    setState(() {
      _idCardImages.clear();
      selected = 'profile';
    });

    print('add ');

  }

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
                .collection('Categories').doc(auth.currentUser!.uid).update({
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

  _imgFromGallery() async {


    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      print('List Printed');
      getUrl(_pickedFile!.path).then((value1) {
        setState(() {
          _idCardImages.add(value1.toString());
        });
        setState(() {
          imagePhote = value1.toString();
          isLoading = false;
        });
        print('value abpve');
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


  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return  Scaffold(
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
        title: Text('Edit Cuisine',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: wc)),
      ),


      body: Container(
        height: devSize.height*0.87,
        width: devSize.width*1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: devSize.height*0.08,
                ),
                Container(
                  height: devSize.height*0.27,
                  width: devSize.width*0.8,
                  color: onbText,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: devSize.width*0.79,
                        height: devSize.height*0.3,
                        decoration: BoxDecoration(
                            color: onbText,
                            border: Border.all(color: onbText)
                        ),

                        child: Container(
                          width: devSize.width*0.73,
                          height: devSize.height*0.29,
                          child: Image.network(
                            imagePhote == "Null"
                                ?
                                "https://image.shutterstock.com/image-vector/hand-drawn-set-healthy-food-260nw-532470079.jpg"
                                : imagePhote.toString(),
                            fit: BoxFit.cover,
                          ),


                        ),
                      ),
                      Positioned(
                        top: devSize.height*0.13,
                        right: devSize.width*0.37,
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

                Container(
                  height: devSize.height*0.07,
                  width: devSize.width*0.5,
                  alignment: Alignment.center,
                  child: Text('Add Cuisine Image',style:TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: gc)),
                ),
                SizedBox(
                  height: devSize.height*0.05,
                ),
                Container(
                  height: devSize.height*0.05,
                  width: devSize.width*0.83,
                  alignment: Alignment.centerLeft,
                  child: Text('Enter Cuisine Name',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: gc)),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Container(
                    // height: size.height * 0.1,
                      width: devSize.width * 0.85,
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 2,color: Colors.blue),
                      // ),

                      child: TextFormField(
                        controller: _controllerPlace,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.add,size:22,color: gc,),

                          contentPadding: EdgeInsets.only(left: 9.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:  BorderSide(
                                color: fieldborder,width: 1.5
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: fieldborder.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          hintText: ' Cuisine Name',
                          hintStyle: TextStyle(color: fieldborder.withOpacity(0.5)),
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
                  height: devSize.height*0.01,
                ),
                // Container(
                //   height: devSize.height*0.05,
                //   width: devSize.width*0.83,
                //   alignment: Alignment.centerLeft,
                //   child: Text('Enter City Name',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: gc)),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 8.0,
                //   ),
                //   child: Container(
                //     // height: size.height * 0.1,
                //       width: devSize.width * 0.85,
                //       // decoration: BoxDecoration(
                //       //   border: Border.all(width: 2,color: Colors.blue),
                //       // ),
                //
                //       child: TextFormField(
                //         controller: _controllerCity,
                //         keyboardType: TextInputType.text,
                //         decoration: InputDecoration(
                //           // prefixIcon: Icon(Icons.add,size:22,color: gc,),
                //
                //           contentPadding: EdgeInsets.only(left: 9.0),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide:  BorderSide(
                //                 color: fieldborder,width: 1.5
                //             ),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(
                //               color: fieldborder.withOpacity(0.5),
                //               width: 1,
                //             ),
                //           ),
                //           hintText: ' City name',
                //           hintStyle: TextStyle(color: fieldborder.withOpacity(0.5)),
                //         ),
                //         // validator: (value) {
                //         //   //EmailValidator.validate(value!);
                //         //   if (!EmailValidator.validate(_emailController.text)) {
                //         //     return 'Please provide valid email';
                //         //   }
                //         //   return null;
                //         // },
                //       )),
                // ),

                SizedBox(
                  height: devSize.height*0.01,
                ),
                Container(
                  height: devSize.height*0.05,
                  width: devSize.width*0.83,
                  alignment: Alignment.centerLeft,
                  child: Text('Enter Price',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: gc)),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Container(
                    // height: size.height * 0.1,
                      width: devSize.width * 0.85,
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 2,color: Colors.blue),
                      // ),

                      child: TextFormField(
                        controller: _controllerPrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.add,size:22,color: gc,),

                          contentPadding: EdgeInsets.only(left: 9.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:  BorderSide(
                                color: fieldborder,width: 1.5
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: fieldborder.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          hintText: ' Price',
                          hintStyle: TextStyle(color: fieldborder.withOpacity(0.5)),
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
                  height: devSize.height*0.01,
                ),
                Container(
                  height: devSize.height*0.05,
                  width: devSize.width*0.83,
                  alignment: Alignment.centerLeft,
                  child: Text('Enter Description',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: gc)),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Container(
                      height: devSize.height*0.18,
                      width: devSize.width * 0.85,
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 2,color: Colors.blue),
                      // ),

                      child: TextFormField(
                        controller: _controllerDescription,
                        keyboardType: TextInputType.text,
                        maxLines: 100,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.add,size:22,color: gc,),

                          contentPadding: const EdgeInsets.only(left: 9.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: fieldborder,width: 1.5
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: fieldborder.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          hintText: ' Description',
                          hintStyle: TextStyle(color: fieldborder.withOpacity(0.5)),
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
                  height: devSize.height*0.01,
                ),



                SizedBox(
                  height: devSize.height*0.07,
                ),

                Container(
                  height: devSize.height*0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SizedBox(
                      //   width: devSize.width*0.4465,
                      // ),
                      Container(
                        height: devSize.height*0.08,
                        width: devSize.width*0.4,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(rd),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),

                                )
                            ),
                          ),
                          child: Text('Cancel',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: wc)),
                          // child: Text('Cancel',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

                        ),
                      ),

                      widget.Status == "Add"?
                      AddButton()
                          :EditButton(),

                    ],
                  ),
                ),

                SizedBox(
                  height: devSize.height*0.07,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget AddButton(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.08,
        width: devSize.width*0.4,

        child: ElevatedButton(
          onPressed: (){
            if(imagePhote ==  "https://image.shutterstock.com/image-vector/hand-drawn-set-healthy-food-260nw-532470079.jpg"){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Cuisine Image",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }
            else if(_controllerPlace.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Cuisine Name",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }

            else if(_controllerPrice.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Price",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }
            else if(_controllerDescription.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Description",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }

            else{
              try {

                FirebaseFirestore.instance
                    .collection('Cuisine')
                    .doc()
                    .set({
                  "cuisineImage": imagePhote.toString().trim(),
                  "cuisineName": _controllerPlace.text.trim(),
                  "cityName": _controllerCity.text.trim(),
                  "price": _controllerPrice.text.trim(),
                  "description": _controllerDescription.text.trim(),

                }).then((value) => print('success'));

                Fluttertoast.showToast(
                  msg: "Cuisine Added Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: gc,
                  textColor: Colors.white,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: UserType)));
                setState(() {
                  selectedIndex = 0;
                  _controllerPlace.clear();
                  _controllerCity.clear();
                  _controllerPrice.clear();
                  _controllerDescription.clear();

                  // _isLoading = false;
                });
              }
              catch (e) {
                print("we are in catch");
                print(e);
                setState(() {
                  // _isLoading = false;
                });
              }            }



          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(onbText),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                )
            ),
          ),
          child: Text('Add',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: wc)),
          // child: Text('Add',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

        ),
      );

  }

  Widget EditButton(){
    final devSize = MediaQuery.of(context).size;

    return
      Container(
        height: devSize.height*0.08,
        width: devSize.width*0.4,

        child: ElevatedButton(
          onPressed: (){
            if(imagePhote ==  "https://image.shutterstock.com/image-vector/hand-drawn-set-healthy-food-260nw-532470079.jpg"){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Cuisine Image",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }
            else if(_controllerPlace.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Cuisine Name",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }

            else if(_controllerPrice.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Price",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }
            else if(_controllerDescription.text.isEmpty){
              Fluttertoast.showToast(
                  msg:
                  "Please Add Description",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: rd,
                  textColor: wc,
                  timeInSecForIosWeb: 1);
            }

            else{
              try {

                FirebaseFirestore.instance
                    .collection('Cuisine')
                    .doc(DocId)
                    .update({
                  "cuisineImage": imagePhote.toString().trim(),
                  "cuisineName": _controllerPlace.text.trim(),
                  "cityName": _controllerCity.text.trim(),
                  "price": _controllerPrice.text.trim(),
                  "description": _controllerDescription.text.trim(),

                }).then((value) => print('success'));

                Fluttertoast.showToast(
                  msg: "Cuisine Updated Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: gc,
                  textColor: Colors.white,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(userType: UserType)));
                setState(() {
                  selectedIndex = 0;
                  _controllerPlace.clear();
                  _controllerCity.clear();
                  _controllerPrice.clear();
                  _controllerDescription.clear();

                  // _isLoading = false;
                });
              }
              catch (e) {
                print("we are in catch");
                print(e);
                setState(() {
                  // _isLoading = false;
                });
              }            }



          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(onbText),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                )
            ),
          ),
          child: Text('Update',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: wc)),
          // child: Text('Add',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color:Colors.white),),

        ),
      );

  }
}
