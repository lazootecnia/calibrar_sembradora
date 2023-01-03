import 'package:campo_calibrador/controller/home_controller.dart';
import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/ui/main_distancia.dart';
import 'package:campo_calibrador/ui/main_rueda.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabs extends GetView<HomeController> {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(text: LocaleKeys.tabs_wheel.tr),
            Tab(text: LocaleKeys.tabs_distance.tr)
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          MainRueda(),
          MainDistancia(),
        ],
      ),
    );
  }
}
