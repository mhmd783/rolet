import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).startTimer();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).checkmanyfack();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createacount();
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
              createacount();
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            )),
        title: TextButton(
          onPressed: () {
            createacount();
          },
          child: Text(
            'انشاءحساب',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        actions: [
          Consumer<control>(builder: (context, val, child) {
            return Container(
              height: double.infinity,
              //margin: EdgeInsets.only(right: 15),
              child: Center(
                child: Text(
                  '${val.manyfackbox.get('manyfack')}',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.black,
            ),
          ),
          // Consumer<control>(builder: (context, val, child) {
          //   return IconButton(
          //       onPressed: () {
          //         val.sendoulnotification("rolet", "جرب حظك اليوم واربح ");
          //       },
          //       icon: Icon(
          //         Icons.notification_add,
          //         color: Colors.black,
          //       ));
          // })
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
                          angle: val.angle,
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
                                          'time: ${val.counter.toStringAsFixed(1)}'))),
                              Expanded(
                                  child: Center(
                                      child: val.chose == 12
                                          ? Text('chose: ')
                                          : Text('chose: ${val.chose}'))),
                            ],
                          ));
                        }),
                      ),
                    ),
                  ],
                ),
                ////////
                Consumer<control>(builder: (context, val, child) {
                  return val.win > 0
                      ? Container(
                          width: 200,
                          height: 70,
                          //margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: val.win == 1
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )
                              //boxShadow: ,
                              ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Center(
                              child: val.win == 1
                                  ? Text(
                                      'حاول مره اخرى',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    )
                                  : Text(
                                      'مبروك الفوز ',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                            ),
                          ),
                        )
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
                            val.chosenumber(i);
                          },
                          child: Container(
                            height: 50,
                            //width: 100,

                            decoration: BoxDecoration(
                              color:
                                  val.chose == i ? Colors.grey : Colors.white,
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
                    if (val.chose == 12) {
                      mas();
                    } else {
                      val.play();
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

  Future<void> createacount() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('اربح معنا'),
          elevation: 10,
          content: Center(
              child: Text(
            textAlign: TextAlign.end,
            'انشئ حسابا علي روليت واربح 300% حقيقي علي كل من العملات المشاركه واحصل علي ارباحك علي محفظتك الاكترونيه',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("signup");
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
                child: Center(child: Text("انشاء حساب")),
              ),
            ),
          ],
        );
      },
    );
  }
}
