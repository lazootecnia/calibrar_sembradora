class CalibracionTotalModel {
  final double distancia;
  final double areaTrabajo;
  final double parcialTotalKg;
  final double parcialTotalGr;
  final double totalPorLineaGr;

  CalibracionTotalModel(
      {required this.distancia,
      required this.areaTrabajo,
      required this.parcialTotalGr,
      required this.parcialTotalKg,
      required this.totalPorLineaGr});

  Map<String, dynamic> toJson() => {
        'distancia': distancia,
        'areaTrabajo': areaTrabajo,
        'parcialTotalKg': parcialTotalKg,
        'parcialTotalGr': parcialTotalGr,
        'totalPorLineaGr': totalPorLineaGr,
      };
}
