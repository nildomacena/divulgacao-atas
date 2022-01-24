import 'package:divulgacao_atas/initial_binding.dart';
import 'package:divulgacao_atas/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:divulgacao_atas/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Divulgação de Atas',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      getPages: AppPages.pages,
      initialRoute: Routes.listaAtas,
    );
  }
}
