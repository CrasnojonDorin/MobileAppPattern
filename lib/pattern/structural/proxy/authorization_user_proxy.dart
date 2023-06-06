import 'package:flutter/cupertino.dart';
import 'package:proiect/model/car.dart';
import 'package:proiect/model/reservation.dart';
import 'package:proiect/pattern/structural/proxy/interface_authorization_user.dart';

class AuthorizationUserProxy implements IAuthorizationUser{

  final IAuthorizationUser _iAuthorizationUser;
  final String _role;
  AuthorizationUserProxy(this._iAuthorizationUser,this._role);

  @override
  void addCarModel(CarModel car, ) {
    (_role == 'admin')
      ?_iAuthorizationUser.addCarModel(car)
        :debugPrint('Acces neautorizat la metoda addCarModel');
    // TODO: implement addCarModel
  }

  @override
  void cancelReservation(ReservationModel reservation,String username ) {
    (_role == 'client')
        ?_iAuthorizationUser.cancelReservation(reservation,username)
        :debugPrint('Acces neautorizat la metoda cancelReservation');
    // TODO: implement cancelReservation
  }

  @override
  void makeReservation(ReservationModel reservation, String username) {
    (_role == 'client')
        ?_iAuthorizationUser.makeReservation(reservation,username)
        :debugPrint('Acces neautorizat la metoda makeReservation');
    // TODO: implement makeReservation
  }

  @override
  void removeCarModel(String car, ) {
    (_role == 'admin')
        ?_iAuthorizationUser.removeCarModel(car)
        :debugPrint('Acces neautorizat la metoda removeCarModel');
    // TODO: implement removeCarModel
  }
  
}