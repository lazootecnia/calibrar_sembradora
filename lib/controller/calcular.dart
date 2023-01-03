import 'dart:math';

import 'package:campo_calibrador/model/calibracion_model.dart';
import 'package:campo_calibrador/model/calibracion_total_model.dart';

CalibracionTotalModel calcularModel(CalibracionModel calibracion) {
  if (calibracion is CalibracionRuedaModel) {
    CalibracionRuedaModel aux = calibracion;

    double distanciaMetros = calcularDistanciaMetros(
        calcularPerimetroCm(aux.diametroRueda), aux.cantidadVueltas);

    return calcular(distanciaMetros, aux.anchoTrabajo, aux.cantidadLineas,
        aux.cantidadKgPorHectarea);
  } else {
    CalibracionDistanciaModel aux = calibracion as CalibracionDistanciaModel;

    return calcular(aux.distancia, aux.anchoTrabajo, aux.cantidadLineas,
        aux.cantidadKgPorHectarea);
  }
}

CalibracionTotalModel calcular(
    double distanciaMetros,
    double anchoTrabajoMetros,
    double cantidadLineas,
    double cantidadKgPorHectarea) {
  double areaTrabajo = anchoTrabajoMetros * distanciaMetros;
  double parcialTotalKg = (areaTrabajo * cantidadKgPorHectarea) / 10000;
  double parcialTotalGr = parcialTotalKg * 1000;
  double totalGr = parcialTotalGr / cantidadLineas;

  return CalibracionTotalModel(
      areaTrabajo: areaTrabajo,
      distancia: distanciaMetros,
      parcialTotalGr: parcialTotalGr,
      parcialTotalKg: parcialTotalKg,
      totalPorLineaGr: totalGr);
}

double calcularPerimetroCm(double diametroRuedaCm) {
  return diametroRuedaCm * pi;
}

double calcularDistanciaMetros(double perimetroCm, int cantidadVueltas) {
  return perimetroCm * pi / 100.0;
}
