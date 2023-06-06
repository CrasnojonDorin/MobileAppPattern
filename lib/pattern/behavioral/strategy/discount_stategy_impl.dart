import 'package:proiect/pattern/behavioral/strategy/interface_discount_strategy.dart';

class NoDiscountStrategy implements InterfaceDiscountStrategy {
  @override
  double calculateDiscount() {
    return 0.0; // Fără reducere
  }
}

class EarlyBirdDiscountStrategy implements InterfaceDiscountStrategy {
  @override
  double calculateDiscount() {

    return 0.05;

  }
}

class MonthDiscountStrategy implements InterfaceDiscountStrategy {
  @override
  double calculateDiscount() {
    return 0.10;

  }
}