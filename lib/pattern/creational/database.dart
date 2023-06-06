import 'package:flutter/material.dart';
import 'package:proiect/model/car.dart';
import 'package:proiect/model/reservation.dart';
import 'package:proiect/pattern/behavioral/observer/interface_observer.dart';

class Database {
  static Database? _instance;

  late List<CarModel> availableCarModels;
  late Map<String,List<ReservationModel>> reservations;
  late List<InterfaceObserver> observers;

  factory Database.getInstance() {
    _instance ??= Database._internal();
    return _instance!;
  }

  Database._internal() {
    availableCarModels = [ CarModel(
        id: 1,
        marca: 'Toyota',
        model: 'Camry',
        anFabricatie: 2020,
        tipMasina: 'Sedan',
        tipMotor: 'Benzin',
        litraj: 2.5,
        putere: 200,
        consum: 8.5,
        pretPerZi: 30,
        pathImage:'assets/png/camry_010_s.jpg'
    )];
    reservations = {};
    observers=[];
  }

  void addCarModel(CarModel car) {
    availableCarModels.add(car);
    notifyCarAdded(car);
  }

  void removeCarModel(String car) {
   // notifyCarRemoved(availableCarModels.singleWhere((element) => element.model==car));
    availableCarModels.removeWhere((c) => c.model == car);
  }

  void makeReservation(ReservationModel reservation,String username) {
    reservations.putIfAbsent(username, () => [reservation]);
    reservations[username]!.add(reservation);
    availableCarModels.remove(reservation.car);
  }

  void cancelReservation(ReservationModel reservation) {
    reservations.remove(reservation);
    availableCarModels.add(reservation.car);
    notifyCarAdded(reservation.car);
  }

  void registerObserver(InterfaceObserver observer) {
    observers.add(observer);
    debugPrint('Înregistrat pentru notificări ${observers.map((e) => e.username)}');

  }

  void unregisterObserver(String username) {
    observers.removeWhere((element) => element.username==username);
    debugPrint('Nu primește notificări ${observers.map((e) => e.username)}');
  }

  void notifyCarAdded(CarModel car) {
    for (var observer in observers) {
      observer.onCarAdded(car);
    }
  }

 /* void notifyCarRemoved(CarModel car) {
    for (var observer in observers) {
      observer.onCarRemoved(car);
    }
  }*/

 /* void notifyReservationMade(ReservationModel reservation) {
    for (var observer in observers) {
      observer.onReservationMade(reservation);
    }
  }*/
}

/*void main() {
  var rentalManager = Database();
  rentalManager.addCarModel(CarModel(1, 'CarModel 1', 'Marca 1', 'Model 1', 2023, 'Tip 1',
      'Motor 1', 2.0, 150, 8.5, 20.0));
  rentalManager.addCarModel(CarModel(2, 'CarModel 2', 'Marca 2', 'Model 2', 2022, 'Tip 2',
      'Motor 2', 2.5, 180, 9.0, 25.0));

  var rentalBuilder = rentalManager.createRental();
  rentalBuilder
      .selectCarModel('CarModel 1')
      .setStartDate(DateTime(2023, 6, 1))
      .setEndDate(DateTime(2023, 6, 5))
      .reserve();

  rentalManager.printStatus(); // Afișează starea

  rentalBuilder = rentalManager.createRental();
  rentalBuilder
      .selectCarModel('CarModel 2')
      .setStartDate(DateTime(2023, 6, 10))
      .setEndDate(DateTime(2023, 6, 15))
      .reserve();

  rentalManager.printStatus(); // Afișează starea actualizată
}*/
