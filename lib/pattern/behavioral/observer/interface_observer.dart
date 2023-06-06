import 'package:proiect/model/car.dart';

abstract class InterfaceObserver {
  List<CarModel> get listCar;
  String get username;
  void onCarAdded(CarModel car);
  void onCarRemoved(CarModel car);

}
