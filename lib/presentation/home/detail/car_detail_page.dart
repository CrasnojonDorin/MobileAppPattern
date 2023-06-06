import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:proiect/model/car.dart';
import 'package:proiect/presentation/home/home_list/widget/bottom_sheet_add_reservation.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class CarDetailPage extends StatefulWidget {
  final CarModel dataCar;
  CarDetailPage({Key? key, required this.dataCar}) : super(key: key);

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  late CarModel _dataCar;
  @override
  void initState() {
    _dataCar = widget.dataCar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.ufoGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (300+47+4).h,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(45)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: CustomColors.gunMetal,
                      size: 25,
                    )),
                SizedBox(
                  height: 20.h,
                ),
                if (_dataCar.pathImage!.isNotEmpty)
                  Center(
                    child: Container(
                      height: (300+47+4-100-1).h,
                        child: Image.asset(_dataCar.pathImage!,fit: BoxFit.contain,)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dataCar.marca,
                        style: CustomTextStyle.interWhite36w700,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: Colors.white
                        ),
                        child: Center(
                            child: Text(
                                _dataCar.tipMasina,
                              style: CustomTextStyle.interGunMetal16w700,
                            )
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        _dataCar.model,
                        style: CustomTextStyle.interWhite24w700,
                      ),
                      const SizedBox(width: 20,),
                      Text(
                        _dataCar.anFabricatie.toString(),
                        style: CustomTextStyle.interWhite30w700,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detalii motor',style: CustomTextStyle.interWhite18w600,),
const SizedBox(height: 8,),
                          Container(
                            padding: const EdgeInsets.all(15),
                            //height: 120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tip: ${_dataCar.tipMotor}',style: CustomTextStyle.interGunMetal18w400,),
                               const SizedBox(height: 8,),
                                if(_dataCar.tipMotor!='Electric')
                                Text('Capacitate: ${_dataCar.litraj.toString()} l',style: CustomTextStyle.interGunMetal18w400,),
                                if(_dataCar.tipMotor!='Electric')
                                const SizedBox(height: 8,),
                                Text('Putere: ${_dataCar.putere.toString()} Hp',style: CustomTextStyle.interGunMetal18w400,),
                                const SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('Consum: ${_dataCar.consum} ',style: CustomTextStyle.interGunMetal18w400,),
                                    Text((_dataCar.tipMotor!='Electric')?'l/100 km':'kw/h',style: CustomTextStyle.interGunMetal18w400,),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),


                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_dataCar.pretPerZi} \$ /Zi',
                        style: CustomTextStyle.interWhite24w700,
                      ),
                      GestureDetector(
                        onTap:()=>Get.bottomSheet(
                           BottomSheetAddReservation(
                             dataCar: _dataCar,
                           ),
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(45))
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(45)),
                          child: Row(
                            children: [
                              const Text('Arendă',
                                  style: CustomTextStyle.interGunMetal20w700),
                              SizedBox(width: 10,),
                              Icon(CupertinoIcons.arrow_right,color: CustomColors.gunMetal,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
