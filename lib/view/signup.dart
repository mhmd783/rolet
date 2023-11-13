import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';

class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _signup();
  }
}

class _signup extends State<signup> {
  String date = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Form(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Consumer<control>(builder: (context, val, child) {
                  return Column(
                    children: [
                      Image.asset(
                        "images/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      Text("انشاء حساب جديد", style: TextStyle(fontSize: 30)),
                      ////

                      ///
                      TextFormField(
                        controller: val.f_name,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                                "[a-zA-Z0-9\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFBC1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFD\uFE70-\uFE74\uFE76-\uFEFC ]"),
                          ),
                        ],
                        maxLength: 15,
                        decoration: InputDecoration(
                          label: Text("اسمك"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.l_name,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                                "[a-zA-Z0-9\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFBC1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFD\uFE70-\uFE74\uFE76-\uFEFC ]"),
                          ),
                        ],
                        maxLength: 15,
                        decoration: InputDecoration(
                          label: Text("اسم الاب"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.phone,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text("رقم تلفونك"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.email,
                        maxLength: 255,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text("الايميل"),
                        ),
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(
                        //         r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'),
                        //   ),
                        // ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.pass,
                        maxLength: 8,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                        decoration: InputDecoration(
                          label: Text("الرقم السري"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        decoration: BoxDecoration(
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
                        child:
                            Consumer<control>(builder: (context, val, child) {
                          return MaterialButton(
                            onPressed: () async {
                              if (val.f_name.text != '' &&
                                  val.l_name.text != '' &&
                                  val.phone.text.length > 10 &&
                                  val.email.text != '' &&
                                  val.pass.text != '') {
                                val.signup();

                                _check();
                              } else {
                                _message();
                              }
                            },
                            child: Text(
                              "تسجيل",
                              style: TextStyle(fontSize: 17),
                            ),
                            color: Colors.white30,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 5),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("signin");
                          },
                          child: Text(
                            "تسجيل الدخول...",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  );
                }),
              ),
            )),
      ),
    );
  }

  Future<void> _check() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Center(
                child: val.checksignup == ''
                    ? Center(child: CircularProgressIndicator())
                    : val.checksignup == '"found"'
                        ? Center(child: Text('هذا الرقم مسجل'))
                        : Center(child: Text('تم تسجيل الحساب بنجاح!')),
              );
            }),
          ),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return val.checksignup != '' && val.checksignup != '"found"'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        child: Text("تسجل الدخول"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("signin");
                        },
                      ),
                    )
                  : Container();
            }),
          ],
        );
      },
    );
  }

  Future<void> _message() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Icon(
            Icons.error,
            color: Colors.redAccent,
          ),
          elevation: 10,
          content: Form(
            child: Center(child: Text('هناك خطاء في البيانات !!!')),
          ),
        );
      },
    );
  }
}
