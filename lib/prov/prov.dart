import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';


class control extends ChangeNotifier {
  String ip = 'https://mydoctory.net';

  //String ip = 'http://192.168.1.2';

  late Box manyfackbox = Hive.box("manyfack");

  late Box idbox = Hive.box("idr");
  late Box f_namebox = Hive.box('f_namer');
  late Box l_namebox = Hive.box("l_namer");
  late Box phonebox = Hive.box("phoner");
  late Box emailbox = Hive.box("emailr");
  late Box passbox = Hive.box("passr");
  late Box monybox = Hive.box("monyr");
  late Box activebox = Hive.box("activer");
  late Box chosebox = Hive.box("choser");
  late Box randombox = Hive.box("randomr");
  late Box winbox = Hive.box("winr");
  late Box onewine = Hive.box("onewine");
  int vtowin = 0;
  double numberofscound = 10;
  int chose = 12;
  int win = 0;
  bool pl = false;

  checkmanyfack() {
    if (manyfackbox.isEmpty) {
      manyfackbox.put('manyfack', '100');
    }
  }

  checkomewine() {
    onewine.put('onewine', '0');
  }

  chosenumber(int i) {
    if (pl == false) {
      chose = i;
    }
    notifyListeners();
  }

  ////////////////
  double angle = 0;
  double counter = 0;
  loop() {
    if (angle >= 6.2) {
      angle = angle - 6.2;
    }
    if (angle < 6.2) {
      angle = angle + 0.1;
    }

    notifyListeners();
  }

  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 2), (Timer timer) {
      // Call your function here

      if (counter < numberofscound && pl == true && chose < 12) {
        counter = counter + 0.01;
        loop();
      }
      if (counter >= numberofscound) {
        Random random = Random();
        int randomNumber =
            random.nextInt(12); // Generates random number from 0 to 11
        print(randomNumber);
        if (vtowin % 2 == 0) {
          randomNumber = chose;
        }
        if (randomNumber == 1) {
          angle = 6;
        }
        if (randomNumber == 2) {
          angle = 0.25;
        }
        if (randomNumber == 3) {
          angle = 5.5;
        }
        if (randomNumber == 4) {
          angle = 0.75;
        }
        if (randomNumber == 5) {
          angle = 4.95;
        }
        if (randomNumber == 6) {
          angle = 1.3;
        }
        if (randomNumber == 7) {
          angle = 4.45;
        }
        if (randomNumber == 8) {
          angle = 1.8;
        }
        if (randomNumber == 9) {
          angle = 3.9;
        }
        if (randomNumber == 10) {
          angle = 2.4;
        }
        if (randomNumber == 11) {
          angle = 2.9;
        }
        if (randomNumber == 0) {
          angle = 3.4;
        }

        if (chose == randomNumber) {
          win = 2;

          manyfackbox.put(
              'manyfack', '${int.parse(manyfackbox.get('manyfack')) + 3}');
        } else {
          win = 1;
          manyfackbox.put(
              'manyfack', '${int.parse(manyfackbox.get('manyfack')) - 1}');
        }
        pl = false;
        counter = 0;
        vtowin++;
        //مهم لتثبيت الرول علي الرقم الفايز
        //c = c - 60;
      }
    });
    notifyListeners();
  }

  play() {
    if (pl == false) {
      counter = 0;
      angle = 0;
      pl = true;
      win = 0;
    }

    notifyListeners();
  }

  ///signup//////////////////////////////////////////////////
  TextEditingController f_name = new TextEditingController();
  TextEditingController l_name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String checksignup = '';
  signup() async {
    String url = "$ip/roulette/view/signup.php";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(<String, String>{
          'f_name': '${f_name.text}',
          'l_name': '${l_name.text}',
          'phone': '${phone.text}',
          'email': '${email.text}',
          'pass': '${pass.text}'
        }),
      );
      var responsebody = jsonEncode(response.body);
      checksignup = responsebody;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  //signin /////////////////////////////////////////////////////
  TextEditingController phonesignin = new TextEditingController();
  TextEditingController passsignin = new TextEditingController();
  var checksignin;

  void signin() async {
    checksignin = null;
    String url =
        "$ip/roulette/view/signin.php?phone=${phonesignin.text}&pass=${passsignin.text}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        checksignin = responsebody;
        idbox.put('id', checksignin[0]['id']);
        f_namebox.put('f_name', checksignin[0]['f_name']);
        l_namebox.put('l_name', checksignin[0]['l_name']);
        phonebox.put('phone', checksignin[0]['phone']);
        emailbox.put('email', checksignin[0]['email']);
        passbox.put('pass', checksignin[0]['pass']);
        monybox.put('mony', checksignin[0]['mony']);
        activebox.put('active', checksignin[0]['active']);
        chosebox.put('chose', checksignin[0]['chose']);
        randombox.put('random', checksignin[0]['random']);
        winbox.put('win', checksignin[0]['win']);
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  //signout
  signout() {
    idbox.put('id', '');
  }

  /////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //play real //////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  int chosereal = 12;
  int winreal = 0;
  bool plreal = false;
  chosenumberreal(int i) {
    if (plreal == false) {
      chosereal = i;
    }
    notifyListeners();
  }

  late int mony;
  double anglereal = 0;
  double counterreal = 0;
  loopreal() {
    if (anglereal >= 6.2) {
      anglereal = anglereal - 6.2;
    }
    if (anglereal < 6.2) {
      anglereal = anglereal + 0.1;
    }

    notifyListeners();
  }

  Timer? _timerreal;
  late int randomNumber;
  void startTimereal() {
    _timerreal = Timer.periodic(Duration(milliseconds: 2), (Timer timer) {
      // Call your function here

      if (counterreal < numberofscound && plreal == true && chosereal < 12) {
        counterreal = counterreal + 0.01;
        loopreal();
      }
      if (counterreal >= numberofscound) {
        Random random = Random();
        randomNumber =
            random.nextInt(12); // Generates random number from 0 to 11
        print(randomNumber);
        //في حاله لم يربح ابدا هنخليه يربح مرا
        if (onewine.get('onewine') == '0' &&
            int.parse(monybox.get('mony')) == 1) {
          randomNumber = chosereal;
          onewine.put('onewine', '1');
        }

        if (randomNumber == 1) {
          anglereal = 6;
        }
        if (randomNumber == 2) {
          anglereal = 0.25;
        }
        if (randomNumber == 3) {
          anglereal = 5.5;
        }
        if (randomNumber == 4) {
          anglereal = 0.75;
        }
        if (randomNumber == 5) {
          anglereal = 4.95;
        }
        if (randomNumber == 6) {
          anglereal = 1.3;
        }
        if (randomNumber == 7) {
          anglereal = 4.45;
        }
        if (randomNumber == 8) {
          anglereal = 1.8;
        }
        if (randomNumber == 9) {
          anglereal = 3.9;
        }
        if (randomNumber == 10) {
          anglereal = 2.4;
        }
        if (randomNumber == 11) {
          anglereal = 2.9;
        }
        if (randomNumber == 0) {
          anglereal = 3.4;
        }

        if (chosereal == randomNumber) {
          winreal = 2;
          mony = int.parse(monybox.get('mony')) + 3;

          //monybox.put('mony', '${int.parse(monybox.get('mony')) + 3}');
        } else {
          winreal = 1;
          mony = int.parse(monybox.get('mony')) - 1;
          //monybox.put('mony', '${int.parse(monybox.get('mony')) - 1}');
        }

        ///to send data play
        callplay();
        plreal = false;
        counterreal = 0;

        //مهم لتثبيت الرول علي الرقم الفايز
        //c = c - 60;
      }
    });
    notifyListeners();
  }

  playrealaple() {
    if (plreal == false) {
      counterreal = 0;
      anglereal = 0;
      plreal = true;
      winreal = 0;
    }

    notifyListeners();
  }

  //oprator online in homereal /////////////////////////////////////////
  ////check mony have
  List checmony = [
    {'id': 'not'}
  ];
  checkmony() async {
    checmony = [
      {'id': 'not'}
    ];
    String url =
        "$ip/roulette/view/pay.php?id_users=${idbox.get('id').toString()}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        checmony = responsebody;
        monybox.put('mony', '${checmony[0]['mony']}');
      }
    } catch (e) {
      print(e);
    }
    print(checmony[0]['id']);
    notifyListeners();
  }

  List callpl = [
    {'id': 'not'}
  ];
  callplay() async {
    callpl = [
      {'id': 'not'}
    ];

    //
    String url =
        "$ip/roulette/view/play.php?id=${idbox.get('id')}&mony=${mony.toString()}&win=${winreal.toString()}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        callpl = responsebody;

        checkmony();

        // monybox.put('mony', '${checmony[0]['mony']}');
      } else {
        callpl = [
          {'id': 'notenternet'}
        ];
      }
    } catch (e) {
      print(e);
      callpl = [
        {'id': 'notenternet'}
      ];
    }
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////
  ///pay//////////////////////////////////////////////////////
  File? image;
  String? base64image;
  var pickedImage;
  final imagePicker = ImagePicker();

  Future<void> getphoto() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      List<int> imagebytes = File(pickedImage.path).readAsBytesSync();
      base64image = base64Encode(imagebytes);
      debugPrint(base64image);
      print("length:${base64image?.length}");
      print("length:${base64image?.length}");
    } else {
      // إعلان خيار آخر في حالة عدم تحديد صورة
      // يمكنك إضافة المزيد من العمليات هنا بناءً على حالتك
    }
    notifyListeners();
  }

  Future<void> getcamera() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      List<int> imagebytes = File(pickedImage.path).readAsBytesSync();
      base64image = base64Encode(imagebytes);
      debugPrint(base64image);
      print("length:${base64image?.length}");
      print("length:${base64image?.length}");
    } else {
      // إعلان خيار آخر في حالة عدم تحديد صورة
      // يمكنك إضافة المزيد من العمليات هنا بناءً على حالتك
    }
    notifyListeners();
  }

  String dataimage = 'empty';

  uploadimage() async {
    String url = "$ip/roulette/view/pay.php";
    try {
      if (image != null) {
        var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(<String, String>{
            'image': '$base64image',
            'id': idbox.get('id').toString(),
            'f_name': f_namebox.get('f_name').toString(),
            'l_name': l_namebox.get('l_name').toString(),
            'phone': phonebox.get('phone').toString(),
            'email': emailbox.get('email').toString(),
            'date': DateTime.now().toString(),
          }),
        );
        var responsebody = jsonEncode(response.body);
        dataimage = responsebody;
      } else {
        dataimage = '\"not\"';
      }
    } catch (e) {
      print("error $e");
    }

    notifyListeners();
    checkuplioadimage();
  }

  uploadeditimage() async {
    String url = "$ip/roulette/view/pay.php";
    try {
      if (image != null) {
        var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(<String, String>{
            'imageedit': '$base64image',
            'id': idbox.get('id').toString()
          }),
        );
        var responsebody = jsonEncode(response.body);
        dataimage = responsebody;
      } else {
        dataimage = '\"not\"';
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  List checksimage = [
    {'mes': 'not'}
  ];
  checkuplioadimage() async {
    checksimage = [
      {'mes': 'not'}
    ];
    String url = "$ip/roulette/view/pay.php?id=${idbox.get('id').toString()}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        checksimage = responsebody;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  ///get mony ////////////////////////////////////////////////////////
  TextEditingController phoneget = new TextEditingController();
  TextEditingController monyget = new TextEditingController();
  TextEditingController passget = new TextEditingController();
  List checkgetmony = [
    {'id': 'not'}
  ];
  getmony() async {
    checkgetmony = [
      {'id': 'not'}
    ];
    int monyuser = int.parse(monybox.get('mony')) - int.parse(monyget.text);
    String url =
        "$ip/roulette/view/getmony.php?id=${idbox.get('id')}&mony=${monyget.text}&phone=${phoneget.text}&email=${emailbox.get('email').toString()}&monyuser=$monyuser&date=${DateTime.now().toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        checkgetmony = responsebody;
        monybox.put('mony', '${monyuser.toString()}');
        phoneget.text = '';
        passget.text = '';
        monyget.text = '';
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }


}
