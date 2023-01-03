abstract class CalibracionModel {
  final double anchoTrabajo;
  final double cantidadKgPorHectarea;
  final double cantidadLineas;

  CalibracionModel(
      {required this.anchoTrabajo,
      required this.cantidadKgPorHectarea,
      required this.cantidadLineas});

  CalibracionModel.fromJson(Map<String, dynamic> json)
      : anchoTrabajo = json['anchoTrabajo'],
        cantidadKgPorHectarea = json['cantidadKgPorHectarea'],
        cantidadLineas = json['cantidadLineas'];

  Map<String, dynamic> toJson() => {
        'anchoTrabajo': anchoTrabajo,
        'cantidadKgPorHectarea': cantidadKgPorHectarea,
        'cantidadLineas': cantidadLineas,
      };
}

class CalibracionDistanciaModel extends CalibracionModel {
  final double distancia;

  CalibracionDistanciaModel(
      {required this.distancia,
      required double anchoTrabajo,
      required double cantidadKgPorHectarea,
      required double cantidadLineas})
      : super(
            anchoTrabajo: anchoTrabajo,
            cantidadKgPorHectarea: cantidadKgPorHectarea,
            cantidadLineas: cantidadLineas);

  CalibracionDistanciaModel.fromJson(Map<String, dynamic> json)
      : distancia = json['distancia'],
        super(
            anchoTrabajo: json['anchoTrabajo'],
            cantidadKgPorHectarea: json['cantidadKgPorHectarea'],
            cantidadLineas: json['cantidadLineas']);

  @override
  Map<String, dynamic> toJson() => {
        'distancia': distancia,
        'anchoTrabajo': anchoTrabajo,
        'cantidadKgPorHectarea': cantidadKgPorHectarea,
        'cantidadLineas': cantidadLineas,
      };
}

class CalibracionRuedaModel extends CalibracionModel {
  final double diametroRueda;
  final int cantidadVueltas;

  CalibracionRuedaModel(
      {required this.diametroRueda,
      required this.cantidadVueltas,
      required double anchoTrabajo,
      required double cantidadKgPorHectarea,
      required double cantidadLineas})
      : super(
            anchoTrabajo: anchoTrabajo,
            cantidadKgPorHectarea: cantidadKgPorHectarea,
            cantidadLineas: cantidadLineas);

  CalibracionRuedaModel.fromJson(Map<String, dynamic> json)
      : diametroRueda = json['diametroRueda'] ?? 0.0,
        cantidadVueltas = json['cantidadVueltas'] ?? 0,
        super(
            anchoTrabajo: json['anchoTrabajo'] ?? 0.0,
            cantidadKgPorHectarea: json['cantidadKgPorHectarea'] ?? 0.0,
            cantidadLineas: json['cantidadLineas'] ?? 0.0);

  @override
  Map<String, dynamic> toJson() => {
        'diametroRueda': diametroRueda,
        'cantidadVueltas': cantidadVueltas,
        'anchoTrabajo': anchoTrabajo,
        'cantidadKgPorHectarea': cantidadKgPorHectarea,
        'cantidadLineas': cantidadLineas,
      };
}
