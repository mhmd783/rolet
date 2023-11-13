import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolet/prov/prov.dart';
import 'package:rolet/view/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rolet/view/homereal.dart';
import 'package:rolet/view/pay.dart';
import 'package:rolet/view/signin.dart';
import 'dart:io';
import 'package:rolet/view/signup.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('manyfack');
  
  await Hive.openBox('idr');
  await Hive.openBox('f_namer');
  await Hive.openBox('l_namer');
  await Hive.openBox('phoner');
  await Hive.openBox('emailr');
  await Hive.openBox('passr');
  await Hive.openBox('monyr');
  await Hive.openBox('activer');
  await Hive.openBox('choser');
  await Hive.openBox('randomr');
  await Hive.openBox('winr');
  await Hive.openBox('onewine');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Box idbox = Hive.box("idr");
    return ChangeNotifierProvider(
        create: (context) {
          return control();
        },
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "home":(context) => home(),
        "signup":(context) => signup(),
        "signin":(context) => signin(),
        "homereal":(context) => homereal(),
        "pay":(context) => pay(),

      },
      home:idbox.get('id')!=null&&idbox.get('id')!=''?homereal(): home(),
    ));
  }
}


