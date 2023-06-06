import 'package:proiect/model/car.dart';
import 'package:proiect/model/reservation.dart';


abstract class IAuthorizationUser{

  void addCarModel(CarModel car) {
  }

  void removeCarModel(String car) {
  }

  void makeReservation(ReservationModel reservation,String username) {
  }

  void cancelReservation(ReservationModel reservation,String username) {
  }

}