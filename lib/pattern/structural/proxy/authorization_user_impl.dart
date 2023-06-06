import 'package:flutter/material.dart';
import 'package:proiect/model/car.dart' ;
import 'package:proiect/model/reservation.dart';
import 'package:proiect/pattern/creational/database.dart';

import 'package:proiect/pattern/structural/proxy/interface_authorization_user.dart';

class AuthorizationUserImpl implements IAuthorizationUser{
  Database rentalManager = Database.getInstance();
  @override
  void addCarModel(CarModel car) {
    rentalManager.availableCarModels.add(car);
    //rentalManager.addCarModel(car);
    // TODO: implement addCarModel
  }

  @override
  void cancelReservation(ReservationModel reservation,String username) {
    //rentalManager.cancelReservation(reservation);
    rentalManager.reservations[username]!.remove(reservation);
    rentalManager.availableCarModels.add(reservation.car);
    // TODO: implement cancelReservation
  }

  @override
  void makeReservation(ReservationModel reservation,String username) {
    //rentalManager.makeReservation(reservation);
   // rentalManager.reservations[username]!.add(reservation);
    if (rentalManager.reservations.containsKey(username)) {
      rentalManager.reservations[username]!.add(reservation);
    } else {
      rentalManager.reservations[username] = [reservation];
    }
   // rentalManager.reservations.putIfAbsent(username, () => [reservation]);
    rentalManager.availableCarModels.remove(reservation.car);
    debugPrint(rentalManager.reservations[username]!.length.toString());
    // TODO: implement makeReservation
  }

  @override
  void removeCarModel(String car) {
   // rentalManager.removeCarModel(car);
    rentalManager.availableCarModels.removeWhere((c) => c.model == car);
    // TODO: implement removeCarModel
  }



}