class CarModel {
  int id;
  //String name;
  String marca;
  String model;
  int anFabricatie;
  String tipMasina;
  String tipMotor;
  double litraj;
  int putere;
  double consum;
  int pretPerZi;
  String? pathImage;

  CarModel(
  { required this.id,
     // this.name,
      required this.marca,
      required this.model,
      required this.anFabricatie,
      required this.tipMasina,
      required this.tipMotor,
      required this.litraj,
      required this.putere,
      required this.consum,
      required this.pretPerZi,
    this.pathImage='assets/png/no_image.png'
  }
      );
}