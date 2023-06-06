import 'package:get/get.dart';
import 'package:proiect/model/user.dart';

class LoginController extends GetxController{
  Rx<UserModel> user=UserModel('', '', '').obs;

}