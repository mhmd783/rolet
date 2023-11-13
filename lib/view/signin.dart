import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';

class signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _signin();
  }
}

class _signin extends State<signin> {
  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<control>(context, listen: false).getonepatient();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Image.asset(
                    "images/logo.png",
                    height: 200,
                    width: 200,
                  ),
                  Text("تسجيل الدخول", style: TextStyle(fontSize: 30)),
                  TextFormField(
                    controller: val.phonesignin,
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    decoration: InputDecoration(
                      label: Text("رقم تلفونك"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 8,
                    controller: val.passsignin,
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
                  MaterialButton(
                    onPressed: () async {
                      if (val.phonesignin.text != '' &&
                          val.phonesignin.text.length >= 10 &&
                          val.passsignin.text != '') {
                        val.signin();
                        _check();
                      } else {
                        _message();
                      }
                    },
                    child: Text(
                      "دخول",
                      style: TextStyle(fontSize: 17),
                    ),
                    color: Colors.white30,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("signup");
                      },
                      child: Text(
                        "...انشاء حساب",
                        style: TextStyle(fontSize: 17),
                      ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  ///
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
                child: val.checksignin == null
                    ? Center(child: CircularProgressIndicator())
                    : val.checksignin[0]['id'] != 'not'
                        ? Center(child: Text('مرحبا بك !'))
                        : Center(child: Text('لا يوجد الحساب!')),
              );
            }),
          ),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return val.checksignin != null
                  ? val.checksignin[0]['id'] != 'not'
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50)),
                          child: MaterialButton(
                            child: Text("دخول"),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'homereal', (route) => false);
                            },
                          ),
                        )
                      : Container()
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
