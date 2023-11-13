import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../prov/prov.dart';

class pay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pay();
  }
}

class _pay extends State<pay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).checkuplioadimage();
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 5,
        title: Text(
          "ارفع صوره من رساله تحويل المبلغ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Consumer<control>(builder: (context, val, child) {
        return Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      //copy phone number
                      Clipboard.setData(ClipboardData(text: "01140374362"));
                    },
                    icon: Icon(Icons.copy)),
                Text(
                  "حول علي :01140374362",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            val.checksimage[0]['mes'] == 'not'
                ? Text(
                    "حاول ان تكون الصوره واضحه",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                : Text(
                    'سيتم شحن رصيدك خلال 60 دقيقه ',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              child: val.image == null
                  ? Image.asset(
                      'images/image1.png',
                      fit: BoxFit.contain,
                    )
                  : Image.file(
                      File(val.image!.path),
                      fit: BoxFit.contain,
                    ),
            ),
            Text(
              "اقصي حجم للملف 3 ميجا",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          val.getcamera();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("camera"),
                            Icon(
                              Icons.camera,
                              size: 40,
                              color: Colors.black,
                            ),
                          ],
                        ))),
                Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          val.getphoto();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("photo"),
                            Icon(
                              Icons.photo,
                              size: 40,
                              color: Colors.black,
                            ),
                          ],
                        ))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 5  horizontally
                      5.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],
              ),
              child: val.checksimage[0]['mes'] == 'not'
                  ? TextButton(
                      onPressed: () {
                        val.uploadimage();
                        _check_upload_image();
                      },
                      child: Text(
                        'ارفع الصوره',
                        style: TextStyle(color: Colors.black),
                      ))
                  : TextButton(
                      onPressed: () {
                        val.uploadeditimage();
                        _check_upload_image();
                      },
                      child: Text(
                        'تعديل',
                        style: TextStyle(color: Colors.black),
                      )),
            )
          ],
        );
      })),
    );
  }

  Future<void> _check_upload_image() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                      child: val.dataimage == "\"not\""
                          ? Text(
                              'لم يتم رفع الصوره',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            )
                          : val.dataimage == "\"good\""
                              ? Text(
                                  'تم رفع الصوره',
                                  style: TextStyle(
                                      color: Colors.greenAccent, fontSize: 15),
                                )
                              : CircularProgressIndicator()),
                ],
              );
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
