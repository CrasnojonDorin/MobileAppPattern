import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_font.dart';


class CustomButtonGreen extends StatelessWidget {
  final String text;
  const CustomButtonGreen(
      {super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CustomColors.ufoGreen,
      ),
      width: 348.w,
      height: 56,
      child: Center(
          child: Text(
        text,
        style:  TextStyle(fontFamily: CustomFonts.inter,
            fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
      )),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
