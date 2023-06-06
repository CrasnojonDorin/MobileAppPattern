import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LoginController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.antiFlashWhiteBack,
      appBar: AppBar(
        backgroundColor: CustomColors.ufoGreen,
        toolbarHeight: 98,

        centerTitle: true,
        title: Text('Profil',style: CustomTextStyle.interWhite24w700,),
      ),
      body:  Padding(
        padding: const EdgeInsets.only(top: 50,right: 40,left: 40),
        child: Center(

            child: Column(

              children: [
                Container(
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                  ),
                    child: Column(
                      children: [
                        Icon(Icons.person,size: 35,),
                        Text(controller.user.value.username,style: CustomTextStyle.interGunMetal18w600,),
                      ],
                    )),
                Spacer(),
                GestureDetector(
                  onTap: ()=>Get.back(),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(color: CustomColors.deepCarmainePink)
                    ),
                    child: Center(child: Text('Deloghează-te',style: CustomTextStyle.interDeepCarmainePink18w600,)),
                  ),
                ),
                SizedBox(height: 50,)
              ],

          ),
        ),
      ),
    );
  }
}
