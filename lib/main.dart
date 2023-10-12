import 'package:equipment_check_sheet/component/scanqrcode.dart';
import 'package:equipment_check_sheet/pages/home.dart';
import 'package:equipment_check_sheet/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkAccount();
  runApp(const MyApp());
}

String initPage = '/home';
Future checkAccount() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String chkLogin = prefs.getString('code') ?? '';
  if (chkLogin == '' || chkLogin.isEmpty) {
    initPage = '/login';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Equipment Check Sheet',
      debugShowCheckedModeBanner: false,
      initialRoute: initPage,
      getPages: [
        GetPage(
            name: '/login',
            page: () => const LoginPage(),
            transition: Transition.cupertino),
        GetPage(
            name: '/home',
            page: () => const HomePage(),
            transition: Transition.cupertino),
        GetPage(
            name: '/qrcode',
            page: () => const QrcodeScanner(),
            transition: Transition.cupertino)
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent[700]!),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
