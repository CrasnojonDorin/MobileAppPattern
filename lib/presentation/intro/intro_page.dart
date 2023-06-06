import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:proiect/presentation/login/login_page.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';



class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.ufoGreen,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          width: 112.75.w,
          height: 112.69.h,
          //Container(color: Colors.white,width: 112.75.w,height: 112.69.h,),
          child: Center(
              child: SvgPicture.asset('assets/svg/logo.svg',
                  width: 57.08.w, height: 64.95.h,color: CustomColors.ufoGreen,)),
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration,() =>
        Get.to(()=>
         LoginPage(),
            transition: Transition.rightToLeft
        ),);
  }


}
