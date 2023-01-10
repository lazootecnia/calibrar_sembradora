import 'dart:io';

import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/model/calibracion_total_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";

class Resumen extends StatelessWidget {
  final double distanciaLineal;
  final double areaTrabajoMaquina;
  final double semillaTrabajoMaquinaKg;
  final double semillaTrabajoMaquinaGr;
  final double semillaPorLineaGr;

  const Resumen(
      {super.key,
      required this.distanciaLineal,
      required this.areaTrabajoMaquina,
      required this.semillaTrabajoMaquinaKg,
      required this.semillaTrabajoMaquinaGr,
      required this.semillaPorLineaGr});

  Resumen.fromModel(CalibracionTotalModel totalModel, {super.key})
      : distanciaLineal = totalModel.distancia,
        areaTrabajoMaquina = totalModel.areaTrabajo,
        semillaTrabajoMaquinaKg = totalModel.parcialTotalKg,
        semillaTrabajoMaquinaGr = totalModel.parcialTotalGr,
        semillaPorLineaGr = totalModel.totalPorLineaGr;

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPatternDigits(
        locale: Platform.localeName ?? "es_UY", decimalDigits: 2);

    return Center(
      child: Column(children: [
        _label("${LocaleKeys.resumen_distance.tr}:",
            "${numberFormat.format(distanciaLineal)} M"),
        _label("${LocaleKeys.resumen_area.tr}:",
            "${numberFormat.format(areaTrabajoMaquina)} M2"),
        _label("${LocaleKeys.resumen_amount_of_seed.tr}:",
            "${numberFormat.format(semillaTrabajoMaquinaKg)} Kg"),
        _label("${LocaleKeys.resumen_amount_of_seed.tr}:",
            "${numberFormat.format(semillaTrabajoMaquinaGr)} Gr"),
        _label("${LocaleKeys.resumen_amount_of_seed_per_linea.tr}:",
            "${numberFormat.format(semillaPorLineaGr)} Gr"),
      ]),
    );
  }

  Widget _label(String description, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _separador(),
        Flexible(child: Text(text))
      ],
    );
  }

  Widget _separador() {
    return const VerticalDivider(
      color: Colors.black,
      thickness: 2,
    );
  }
}
