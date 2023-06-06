
import 'package:flutter/material.dart';
import 'package:proiect/model/reservation.dart';

abstract class Reservation {

  void addOption(ReservationModel reservation);
}

class BasicReservation implements Reservation {
  //Database database=Database.getInstance();

  BasicReservation();

  @override
  void addOption(ReservationModel reservation) {

    //database.makeReservation(reservation);
  }
}

// Decoratorul abstract care extinde componenta
abstract class ReservationDecorator implements Reservation {
  Reservation decoratedReservation;

  ReservationDecorator(this.decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    return decoratedReservation.addOption(reservation);
  }
}

// Decoratorul concret care adaugă opțiunea de GPS
class GPSDecorator extends ReservationDecorator {
  @override
  Reservation decoratedReservation;

  GPSDecorator(this.decoratedReservation) : super(decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    super.addOption(reservation);
    reservation.hasGps = !reservation.hasGps!;
    if(reservation.hasGps==true){
      reservation.totalPrice+=10;}
    else{
      reservation.totalPrice-=10;
    }

  }
}

// Decoratorul concret care adaugă opțiunea de WiFi
class WifiDecorator extends ReservationDecorator {
  WifiDecorator(Reservation decoratedReservation) : super(decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    super.addOption(reservation);
    reservation.wifi = !reservation.wifi!;
    if(reservation.wifi==true){
      reservation.totalPrice+=4;}
    else{
      reservation.totalPrice-=4;
    }
  }
}

// Decoratorul concret care adaugă opțiunea de baby chair
class BabyChairDecorator extends ReservationDecorator {

  BabyChairDecorator(Reservation decoratedReservation)
      : super(decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    super.addOption(reservation);

      reservation.hasChildChairs =reservation.hasChildChairs!+1;
      reservation.totalPrice+=5;
  }
}

// Decoratorul concret care adaugă opțiunea de casco
class CascoDecorator extends ReservationDecorator {
  CascoDecorator(Reservation decoratedReservation)
      : super(decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    super.addOption(reservation);
    debugPrint(reservation.totalPrice.toString());
    reservation.casco = !reservation.casco!;
    if(reservation.casco==true){
    reservation.totalPrice+=30;}
    else{
      reservation.totalPrice-=30;
    }

  }
}

// Decoratorul concret care adaugă opțiunea de personal driver
class PersonalDriverDecorator extends ReservationDecorator {
  PersonalDriverDecorator(Reservation decoratedReservation)
      : super(decoratedReservation);

  @override
  void addOption(ReservationModel reservation) {
    super.addOption(reservation);
    reservation.personalDriver = !reservation.personalDriver! ;
    if(reservation.personalDriver==true){
      reservation.totalPrice+=70;}
    else{
      reservation.totalPrice-=70;
    }
  }
}