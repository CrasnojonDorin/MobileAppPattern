import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:proiect/model/user.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/nav_bar.dart';
import 'package:proiect/presentation/resource/custom_button_green.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';
import 'package:proiect/presentation/resource/custom_textfield.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller=Get.put(LoginController());
  List<UserModel> userList=[
    UserModel('Admin@g.com', 'admin11', 'admin'),
    UserModel('Client@g.com', 'client1', 'client')
  ];
  bool checkUserExists(String username) {
    for (UserModel user in userList) {
      if (user.username == username) {
        return true;
      }
    }
    return false;
  }

  final formKey = GlobalKey<FormState>();
  bool? _passwordVisible = false;
  final loginInput = TextEditingController();
  final passwordInput = TextEditingController();
  late UserModel userExist;
  @override
  void dispose() {
    loginInput.dispose();
    passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (96.05).h,
                    ),
                    Text(
                      'Bine ai revenit!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 256.w,
                      child: Text(
                        'Ajută-ne să-ți găsim mașina potrivită',
                        style: CustomTextStyle.interSpanishGrey16w400,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                        text: 'Email',
                        typeinput: TextInputType.emailAddress,
                        input: loginInput,
                        conditionInput: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Câmpul trebuie completat';
                          } else if (value.isNotEmpty &&
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Email-ul nu este valid';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Câmpul trebuie completat';
                        } else if (value.isNotEmpty &&
                            !RegExp(r"[0-9]").hasMatch(value)) {
                          return 'Parola trebuie să conțină cifre';
                        } else if (value.isNotEmpty &&
                            !RegExp(r"[a-zA-z]").hasMatch(value)) {
                          return 'Parola trebuie să conțină litere';
                        } else if (value.isNotEmpty && value.length < 7) {
                          return 'Parola trebuie să aibă mai mult de 6 caractere';
                        }
                        return null;
                      },
                      controller: passwordInput,
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      style: CustomTextStyle.interRaisinBlack16w400,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible!;
                              });
                            },
                          ),
                          hintStyle: const TextStyle(
                              fontSize: 16, color: CustomColors.chineseSilver),
                          contentPadding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                          hintText: 'Introdu parola',
                          filled: true,
                          fillColor: Colors.white,
                          //errorText: widget.validate ? 'Câmpul trebuie completat': null,
                          // errorStyle: TextStyle(color: Colors.red),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  width: 1, color: CustomColors.brigthGrey)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  width: 1, color: CustomColors.brigthGrey))),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    GestureDetector(
                      onTap: (){}
                          ,
                      child:  Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Am uitat parola',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.ufoGreen),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 73.h,
                    ),
                GestureDetector(
                    onTap: () {
                    if(formKey.currentState!.validate()){
                     debugPrint(checkUserExists(loginInput.text).toString());
                   // userExist=userList.firstWhere((element) => element.username==loginInput.text);
                    if(checkUserExists(loginInput.text)){
                      controller.user.value=userList.firstWhere((element) => element.username==loginInput.text);

                      Get.to(()=>
                          NavigationBarWidget(
                            ),
                          transition: Transition.rightToLeft

                      );}
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Utilizatorul dat nu există")
                      ));
                    }
                    }else {
                      null;
                    };
            },
        child: const CustomButtonGreen(
        text: 'Loghează-te'),
    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                          'Nu ai cont? ',
                          style:
                          CustomTextStyle.interSpanishGrey16w400,
                        ),
                        GestureDetector(
                          onTap: (){}
                              ,
                          child:  Text(
                            'Înregistrează-te.',
                            style:
                            TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600, color: CustomColors.ufoGreen),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }


}
