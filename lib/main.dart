import 'dart:math';

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
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calibrar Sembradora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calibrar Sembradora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final diametroRuedaController = TextEditingController();
  final cantidadVueltasRuedaController = TextEditingController();
  final anchoTrabajoController = TextEditingController();
  final cantidadKgPorHectareaController = TextEditingController();
  final cantidadLineasController = TextEditingController();

  @override
  void dispose() {
    diametroRuedaController.dispose();
    cantidadVueltasRuedaController.dispose();
    anchoTrabajoController.dispose();
    cantidadKgPorHectareaController.dispose();
    cantidadLineasController.dispose();
    super.dispose();
  }

  void _calcularSiembra() {
    if (_formKey.currentState!.validate()) {
      double diametro = double.parse(diametroRuedaController.text);
      double perimetro = diametro * pi;
      double cantVueltas = double.parse(cantidadVueltasRuedaController.text);
      double distanciaEnM = (perimetro * cantVueltas) / 100.0;
      double areaTrabajo =
          double.parse(anchoTrabajoController.text) * distanciaEnM;

      double kgSemillaPorHectarea =
          double.parse(cantidadKgPorHectareaController.text);

      double parcialTotalKg = (areaTrabajo * kgSemillaPorHectarea) / 10000;
      double parcialTotalGr = parcialTotalKg * 1000;
      double totalGr =
          parcialTotalGr / double.parse(cantidadLineasController.text);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Resumen(
                distanciaLineal: perimetro,
                areaTrabajoMaquina: areaTrabajo,
                semillaTrabajoMaquinaKg: parcialTotalKg,
                semillaTrabajoMaquinaGr: parcialTotalGr,
                semillaPorLineaGr: totalGr),
            // content: Text(
            //     "Distancia: $distanciaEnM metros Area:$areaTrabajo SubTotalKg:$parcialTotalKg SubTotalGr:$parcialTotalGr"),
          );
        },
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _Titulo(),
                  _diametroRueda(),
                  _separador(),
                  _cantidadVueltas(),
                  _separador(),
                  _anchoTrabajo(),
                  _separador(),
                  _kgPorHectarea(),
                  _separador(),
                  _cantidadLineas(),
                  _separador(),
                  _calcular()
                ],
              ),
            ),
          )),
    );
  }

  Widget _separador() {
    return const SizedBox(
      height: 30.0,
    );
  }

  Widget _calcular() {
    return MaterialButton(
      minWidth: 200.0,
      height: 40.0,
      onPressed: () {
        _calcularSiembra();
      },
      color: Colors.lightBlue,
      child: const Text('Calcular', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _diametroRueda() {
    return TextFormField(
      decoration: inputDecoration.copyWith(
        hintText: 'Diametro Rueda',
      ),
      controller: diametroRuedaController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el diametro de la rueda';
        }
        return null;
      },
    );
  }

  Widget _cantidadVueltas() {
    return TextFormField(
      decoration: inputDecoration.copyWith(
        hintText: 'cantidad de vueltas',
      ),
      controller: cantidadVueltasRuedaController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese la cantidad de vueltas que desea realizar';
        }
        return null;
      },
    );
  }

  Widget _anchoTrabajo() {
    return TextFormField(
      decoration: inputDecoration.copyWith(
        hintText: 'Ancho trabajo de la maquina, en Metros',
      ),
      controller: anchoTrabajoController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el ancho de trabajo de la sembradora';
        }
        return null;
      },
    );
  }

  Widget _kgPorHectarea() {
    return TextFormField(
      decoration: inputDecoration.copyWith(
        hintText: 'Kilos por Hectarea',
      ),
      controller: cantidadKgPorHectareaController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese los kilos por hectarea de semilla';
        }
        return null;
      },
    );
  }

  Widget _cantidadLineas() {
    return TextFormField(
      decoration: inputDecoration.copyWith(
        hintText: 'Cantidad Lineas',
      ),
      controller: cantidadLineasController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese la cantidad de lineas';
        }
        return null;
      },
    );
  }

  Widget _Titulo() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 64.0,
      ),
      child: Text(
        'Calcular Gramos por Linea',
        style: TextStyle(
          color: Colors.green,
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

const InputDecoration inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  fillColor: Color.fromARGB(255, 140, 255, 174),
);
*/