
import 'package:proiect/model/car.dart';


class ReservationModel {
  CarModel car;
  DateTime startDate;
  DateTime endDate;
  bool? hasGps;
  int? hasChildChairs;
  bool? personalDriver;
  bool? wifi;
  bool? casco;
  double totalPrice;

  ReservationModel(this.car,this.totalPrice, this.startDate, this.endDate) {

    casco=false;
    personalDriver=false;
    wifi=false;
    hasChildChairs=0;
    hasGps=false;
  }



}
