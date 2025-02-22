import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/login/driver_login_screen.dart';

void main() {
  runApp(CampusBusDriverApp());
}

class CampusBusDriverApp extends StatelessWidget {
  const CampusBusDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Bus Driver Panel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DriverLoginScreen(),
    );
  }
}
