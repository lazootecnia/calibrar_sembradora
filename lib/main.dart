import 'package:campo_calibrador/controller/distancia_controller.dart';
import 'package:campo_calibrador/controller/home_controller.dart';
import 'package:campo_calibrador/controller/rueda_controller.dart';
import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/ui/main_tabs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(RuedaController());
    Get.put(DistanciaController());

    return GetMaterialApp(
      translationsKeys: AppTranslation.translations,
      locale: const Locale('es', 'UY'),
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.title.tr,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeTabs(),
    );
  }
}
