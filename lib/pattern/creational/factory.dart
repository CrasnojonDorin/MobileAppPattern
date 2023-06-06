import 'package:proiect/model/car.dart';

abstract class CarFactory {
  CarModel createCar( int id,

  String marca,
  String model,
  int anFabricatie,
  String tipMotor,
  double litraj,
  int putere,
  double consum,
  int pretPerZi,);
}

class SUVFactory implements CarFactory {
  @override
  CarModel createCar(int id, String marca, String model, int anFabricatie, String tipMotor, double litraj, int putere, double consum, int pretPerZi) {

    //  CarModel suv = CarModel(id, marca, model, anFabricatie, 'Suv', tipMotor, litraj, putere, consum, pretPerZi,'');
    CarModel suv=CarModel(
        id: id,
        marca: marca,
        model: model,
        anFabricatie: anFabricatie,
        tipMasina: 'Suv',
        tipMotor: tipMotor,
        litraj: litraj,
        putere: putere,
        consum: consum,
        pretPerZi: pretPerZi);
      //Database.getInstance().addCarModel(suv);
      return suv;

  }

}

class SedanFactory implements CarFactory {
  @override
  CarModel createCar(int id, String marca, String model, int anFabricatie, String tipMotor, double litraj, int putere, double consum, int pretPerZi) {
    CarModel sedan =CarModel(
        id: id,
        marca: marca,
        model: model,
        anFabricatie: anFabricatie,
        tipMasina: 'Sedan',
        tipMotor: tipMotor,
        litraj: litraj,
        putere: putere,
        consum: consum,
        pretPerZi: pretPerZi); //Database.getInstance().addCarModel(sedan);
    return sedan;
  }

}

class CompactCarFactory implements CarFactory {
  @override
  CarModel createCar(int id, String marca, String model, int anFabricatie, String tipMotor, double litraj, int putere, double consum, int pretPerZi) {
    CarModel compactCar = CarModel(
        id: id,
        marca: marca,
        model: model,
        anFabricatie: anFabricatie,
        tipMasina: 'Compact',
        tipMotor: tipMotor,
        litraj: litraj,
        putere: putere,
        consum: consum,
        pretPerZi: pretPerZi);// Database.getInstance().addCarModel(compactCar);
    return compactCar;
  }

}

class SportCarFactory implements CarFactory {
  @override
  CarModel createCar(int id,

      String marca,
      String model,
      int anFabricatie,
      String tipMotor,
      double litraj,
      int putere,
      double consum,
      int pretPerZi,) {
    CarModel sportCar = CarModel(
        id: id,
        marca: marca,
        model: model,
        anFabricatie: anFabricatie,
        tipMasina: 'Sport',
        tipMotor: tipMotor,
        litraj: litraj,
        putere: putere,
        consum: consum,
        pretPerZi: pretPerZi);// Database.getInstance().addCarModel(sportCar);
    return sportCar;
  }
}