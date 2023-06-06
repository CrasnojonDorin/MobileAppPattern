import 'package:flutter/material.dart';
import 'package:proiect/pattern/behavioral/strategy/discount_stategy_impl.dart';
import 'package:proiect/pattern/behavioral/strategy/interface_discount_strategy.dart';

class ContextStrategy{

  late InterfaceDiscountStrategy strategy;
  DateTime startDate;
  DateTime endDate;
  int price;
  late double totalPrice;

  ContextStrategy(this.startDate,this.endDate,this.price);

  void setStrategy (){
    int totalDays = endDate.difference(startDate).inDays + 1;

    if (totalDays >= 7 && totalDays<30) {
      strategy = EarlyBirdDiscountStrategy();
    } else if (totalDays >= 30) {
      strategy = MonthDiscountStrategy();
    } else {
      strategy = NoDiscountStrategy();
    }
  }

  void applicationDiscount(){
    setStrategy();
    int totalDays = endDate.difference(startDate).inDays + 1;

     totalPrice = (totalDays * price).toDouble();

    double discount = strategy.calculateDiscount();
    double discountAmount = totalPrice * discount;
    totalPrice -= discountAmount;

  }
}