import 'package:proiect/model/car.dart';
import 'package:proiect/pattern/behavioral/observer/interface_observer.dart';

class ClientObserver implements InterfaceObserver{
   @override
  String username;

   @override
  List<CarModel> listCar=[];

   ClientObserver(this.username);

  @override
  void onCarAdded(CarModel car) {
    listCar.add(car);
    // TODO: implement onCarAdded
  }

  @override
  void onCarRemoved(CarModel car) {

    // TODO: implement onCarRemoved
  }

}