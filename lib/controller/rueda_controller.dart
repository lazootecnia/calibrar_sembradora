// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:campo_calibrador/controller/calcular.dart';
import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/model/calibracion_model.dart';
import 'package:campo_calibrador/model/calibracion_total_model.dart';
import 'package:campo_calibrador/ui/resumen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RuedaController extends GetxController {
  final diametroRueda = TextEditingController();
  final cantidadVueltas = TextEditingController();
  final anchoTrabajo = TextEditingController();
  final cantidadKgPorHectarea = TextEditingController();
  final cantidadLineas = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String _STORAGE_NAME = "calibar_rueda";
  final String _STORAGE_TOTAL_NAME = "total_rueda";

  final storage = GetStorage();

  late CalibracionRuedaModel calibracion;

  @override
  void onReady() {
    super.onReady();
    cargar();
  }

  CalibracionTotalModel? calcular() {
    if (formKey.currentState!.validate()) {
      CalibracionRuedaModel calibrar = CalibracionRuedaModel(
          diametroRueda: double.parse(diametroRueda.text),
          cantidadVueltas: int.parse(cantidadVueltas.text),
          anchoTrabajo: double.parse(anchoTrabajo.text),
          cantidadKgPorHectarea: double.parse(cantidadKgPorHectarea.text),
          cantidadLineas: double.parse(cantidadLineas.text));

      CalibracionTotalModel total = calcularModel(calibrar);

      storage.write(_STORAGE_NAME, jsonEncode(calibrar.toJson()));

      return total;
    }
  }

  void save(CalibracionTotalModel total) {
    storage.write(_STORAGE_TOTAL_NAME, jsonEncode(total.toJson()));
    Get.snackbar(
      LocaleKeys.dialog_seve_title.tr,
      LocaleKeys.dialog_seve_ok.tr,
    );
  }

  void cargar() {
    String calibrarString = storage.read(_STORAGE_NAME) ?? "";
    if (calibrarString.isNotEmpty) {
      CalibracionRuedaModel calibrar =
          CalibracionRuedaModel.fromJson(jsonDecode(calibrarString));

      diametroRueda.text = calibrar.diametroRueda.toString();
      cantidadVueltas.text = calibrar.cantidadVueltas.toString();

      anchoTrabajo.text = calibrar.anchoTrabajo.toString();
      cantidadKgPorHectarea.text = calibrar.cantidadKgPorHectarea.toString();
      cantidadLineas.text = calibrar.cantidadLineas.toString();

      refresh();
    }
  }
}
