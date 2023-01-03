import 'package:campo_calibrador/controller/distancia_controller.dart';
import 'package:campo_calibrador/generated/locales.g.dart';
import 'package:campo_calibrador/model/calibracion_total_model.dart';
import 'package:campo_calibrador/ui/resumen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDistancia extends GetView<DistanciaController> {
  const MainDistancia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _titulo(),
              _inputText(
                LocaleKeys.distance_distance.tr,
                LocaleKeys.distance_distance_error.tr,
                controller.distancia,
              ),
              _separador(),
              _inputText(
                LocaleKeys.distance_broad.tr,
                LocaleKeys.distance_broad_error.tr,
                controller.anchoTrabajo,
              ),
              _separador(),
              _inputText(
                LocaleKeys.distance_kilos.tr,
                LocaleKeys.distance_kilos_error.tr,
                controller.cantidadKgPorHectarea,
              ),
              _separador(),
              _inputText(
                LocaleKeys.distance_lines.tr,
                LocaleKeys.distance_lines_error.tr,
                controller.cantidadLineas,
              ),
              _separador(),
              _calcular(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _separador() {
    return const SizedBox(
      height: 30.0,
    );
  }

  Widget _calcular(BuildContext context) {
    return MaterialButton(
      minWidth: 200.0,
      height: 40.0,
      onPressed: () {
        CalibracionTotalModel? total = controller.calcular();

        if (total != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(LocaleKeys.dialog_title.tr),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Resumen.fromModel(total),
                    ],
                  ),
                  actions: [
                    TextButton(
                        child: Text(LocaleKeys.dialog_exit.tr),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                        child: Text(LocaleKeys.dialog_save.tr),
                        onPressed: () {
                          controller.save(total);
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              });
        }
      },
      color: Colors.green,
      child: Text(LocaleKeys.distance_calculate.tr,
          style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _titulo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 64.0,
      ),
      child: Text(
        LocaleKeys.distance_title.tr,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _inputText(String labelText, String errorText,
      TextEditingController textController) {
    return TextFormField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
      controller: textController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return double.tryParse(value) == null
            ? LocaleKeys.distance_number_error.tr
            : null;
      },
    );
  }
}
