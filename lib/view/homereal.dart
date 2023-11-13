import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';

class homereal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homereal();
  }
}

class _homereal extends State<homereal> {
  
  @override
  void dispose() {
    // TODO: Add your code here
    super.dispose();
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).checkomewine();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).checkmony();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).startTimereal();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pay();
    });

    //createacount();
  }

  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
            onPressed: () {
              showprofile();
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            )),
        actions: [
          Consumer<control>(builder: (context, val, child) {
            return Container(
              height: double.infinity,
              child: Center(
                child: Text(
                  '${val.monybox.get('mony')}',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            );
          }),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              payment();
            },
            icon: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Consumer<control>(builder: (context, val, child) {
                        return Transform.rotate(
                          origin: Offset(0, 0),
                          angle: val.anglereal,
                          child: Container(
                            child: Image.asset(
                              'images/rolet.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.9),
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            )
                            //boxShadow: ,
                            ),
                      ),
                    ]),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                          //boxShadow: ,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child:
                            Consumer<control>(builder: (context, val, child) {
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: Text(
                                          'timer: ${val.counterreal.toStringAsFixed(1)}'))),
                              Expanded(
                                  child: Center(
                                      child: val.chosereal == 12
                                          ? Text('chose: ')
                                          : Text('chose: ${val.chosereal}'))),
                            ],
                          ));
                        }),
                      ),
                    ),
                  ],
                ),
                ////////
                Consumer<control>(builder: (context, val, child) {
                  return val.winreal > 0
                      ? val.callpl[0]['id'] == 'good'
                          ? Container(
                              width: 200,
                              height: 70,
                              //margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: val.winreal == 1
                                      ? Colors.red.withOpacity(0.5)
                                      : Colors.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )
                                  //boxShadow: ,
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Center(
                                  child: val.winreal == 1
                                      ? Text(
                                          'حاول مره اخرى',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black),
                                        )
                                      : Text(
                                          'مبروك الفوز ',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                            )
                          : val.callpl[0]['id'] == 'notenternet'
                              ? Container(
                                  width: 200,
                                  height: 70,
                                  //margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )
                                      //boxShadow: ,
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    child: Center(
                                        child: Text(
                                      'لا يوجد انترنت ',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    )),
                                  ),
                                )
                              : SizedBox()
                      : SizedBox();
                }),
              ]),

              Consumer<control>(builder: (context, val, child) {
                return Container(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: 12,
                      itemBuilder: (context, i) {
                        return MaterialButton(
                          onPressed: () {
                            val.chosenumberreal(i);
                          },
                          child: Container(
                            height: 50,
                            //width: 100,

                            decoration: BoxDecoration(
                              color: val.chosereal == i
                                  ? Colors.grey
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
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
                            child: Center(child: Text("$i")),
                          ),
                        );
                      }),
                );
              }),

              ///
              Container(
                  child: Consumer<control>(builder: (context, val, child) {
                return MaterialButton(
                  onPressed: () {
                    if (val.chosereal == 12) {
                      mas();
                    } 
                    else if (val.monybox.get('mony') == '0') {
                      pay();
                    } 
                    else {
                      val.playrealaple();
                    }
                    //to scrol to top screen if this in bottom
                    _scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                    child: Center(child: Text("العب 1 جنيه ")),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }

  //mes told you not chose number
  Future<void> mas() async {
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
                      child: Text(
                    'لم تختار رقم !!',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )),
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

  Future<void> showprofile() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: Row(
              children: [
                Icon(Icons.person),
                Text(
                    '${val.f_namebox.get('f_name')} ${val.l_namebox.get('l_name')}'),
              ],
            ),
            elevation: 10,
            content: Center(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.phone)),
                    Text(
                      textAlign: TextAlign.end,
                      '${val.phonebox.get('phone')}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.email)),
                    Text(
                      textAlign: TextAlign.end,
                      '${val.emailbox.get('email')}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.account_balance_wallet_outlined)),
                    Text(
                      textAlign: TextAlign.end,
                      '${val.monybox.get('mony')}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            )),
            actions: <Widget>[
              Consumer<control>(builder: (context, val, child) {
                return MaterialButton(
                  onPressed: () {
                    val.signout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                  },
                  child: Container(
                    height: 50,
                    //width: 100,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                    child: Center(child: Text('تسجل الخروج')),
                  ),
                );
              }),
            ],
          );
        });
      },
    );
  }

  //pay or get mony
  Future<void> payment() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined),
                Text('${val.monybox.get('mony')} '),
              ],
            ),
            elevation: 10,
            content: val.monybox.get('mony') == '0'
                ? Text(
                    textAlign: TextAlign.end,
                    'اشحن اقل مبلغ 5 جنيهات لتلعب معنا لتكون ارباحك 300% واستلم ارباحك علي محفظتك الاكترونيه',
                    style: TextStyle(color: Colors.black),
                  )
                : SizedBox(),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("pay");
                      },
                      child: Container(
                        height: 50,
                        //width: 100,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
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
                        child: Center(child: Text('اشحن')),
                      ),
                    ),
                  ),
                  // val.monybox.get('mony') == '0'
                  //     ? SizedBox()
                  //     :
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        getmony();
                      },
                      child: Container(
                        height: 50,
                        //width: 100,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
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
                        child: Center(child: Text("اسحب")),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> pay() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: val.monybox.get('mony') == '0'
                ? Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined),
                      Text('${val.monybox.get('mony')} '),
                    ],
                  )
                : SizedBox(),
            content: val.monybox.get('mony') == '0'
                ? Text(
                    textAlign: TextAlign.end,
                    'اشحن اقل مبلغ 5 جنيهات لتلعب معنا لتكون ارباحك 300% واستلم ارباحك علي محفظتك الاكترونيه',
                    style: TextStyle(color: Colors.black),
                  )
                : Text(
                    textAlign: TextAlign.center,
                    'اهلا بك ',
                    style: TextStyle(color: Colors.black),
                  ),
            elevation: 10,
            actions: <Widget>[
              val.monybox.get('mony') == '0'
                  ? MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("pay");
                      },
                      child: Container(
                        height: 50,
                        //width: 100,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
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
                        child: Center(child: Text('اشحن')),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        });
      },
    );
  }

  Future<void> getmony() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined),
                Text('${val.monybox.get('mony')} '),
              ],
            ),
            elevation: 10,
            content: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    //initialValue: val.phonebox.get('phone'),
                    controller: val.phoneget,
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("رقم المحفظه لسحب اموالك"),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  TextFormField(
                    controller: val.monyget,
                    maxLength: 8,
                    //obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    decoration: InputDecoration(
                      label: Text("المبلغ المراد سحبه"),
                    ),
                  ),
                  TextFormField(
                    controller: val.passget,
                    maxLength: 8,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    decoration: InputDecoration(
                      label: Text("كلمه سر حسابك"),
                    ),
                  ),
                ],
              ),
            )),
            actions: <Widget>[
              Consumer<control>(builder: (context, val, child) {
                return MaterialButton(
                  onPressed: () {
                    if (val.phoneget.text.length > 10 &&
                        val.passget.text == val.passbox.get('pass') &&
                        val.monyget.text != '' &&
                        int.parse(val.monyget.text) <=
                            int.parse(val.monybox.get('mony')) &&
                        int.parse(val.monyget.text) >= 5) {
                      val.getmony();
                      checkgetmony();
                    } else {
                      _message();
                    }
                  },
                  child: Container(
                    height: 50,
                    //width: 100,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                    child: Center(child: Text("اسحب")),
                  ),
                );
              }),
            ],
          );
        });
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
            child: Center(
                child: Text(
              textAlign: TextAlign.end,
              'هناك خطاء في البيانات يجب التاكد من رقم التلفون ورقم السري والمبلغ المراد سحبه يكون مساوي او اقل من رصيدك وان يكون رصيدك اكبر من 4 جنيه لتتم عمليه السحب!!!',
              style: TextStyle(color: Colors.black),
            )),
          ),
        );
      },
    );
  }

  Future<void> checkgetmony() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: val.checkgetmony[0]['id'] == 'good'
                ? Icon(
                    Icons.offline_pin_outlined,
                    color: Colors.greenAccent,
                  )
                : Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  ),
            elevation: 10,
            content: Center(
                child: val.checkgetmony[0]['id'] == 'good'
                    ? Text(
                        'تم سترسل الاموال خلال 60 دقيقه',
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(
                        'هناك خطاء !!! في الانترنت',
                        style: TextStyle(color: Colors.black),
                      )),
          );
        });
      },
    );
  }
}
