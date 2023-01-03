// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:campo_calibrador/controller/calcular.dart';
import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/model/calibracion_model.dart';
import 'package:campo_calibrador/model/calibracion_total_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DistanciaController extends GetxController {
  final distancia = TextEditingController();
  final anchoTrabajo = TextEditingController();
  final cantidadKgPorHectarea = TextEditingController();
  final cantidadLineas = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String _STORAGE_NAME = "calibar_distancia";
  final String _STORAGE_TOTAL_NAME = "total_distancia";

  final storage = GetStorage();

  late CalibracionRuedaModel calibracion;

  @override
  void onReady() {
    super.onReady();
    cargar();
  }

  CalibracionTotalModel? calcular() {
    if (formKey.currentState!.validate()) {
      CalibracionDistanciaModel calibrar = CalibracionDistanciaModel(
          distancia: double.parse(distancia.text),
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
      CalibracionDistanciaModel calibrar =
          CalibracionDistanciaModel.fromJson(jsonDecode(calibrarString));

      distancia.text = calibrar.distancia.toString();
      anchoTrabajo.text = calibrar.anchoTrabajo.toString();
      cantidadKgPorHectarea.text = calibrar.cantidadKgPorHectarea.toString();
      cantidadLineas.text = calibrar.cantidadLineas.toString();

      refresh();
    }
  }
}
