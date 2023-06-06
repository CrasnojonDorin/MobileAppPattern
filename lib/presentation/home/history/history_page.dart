import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proiect/model/reservation.dart';
import 'package:proiect/pattern/creational/database.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_impl.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_proxy.dart';
import 'package:proiect/pattern/structural/proxy/interface_authorization_user.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final LoginController controller = Get.find();
  final Database database=Database.getInstance();
  List<ReservationModel> _reservationList=[];
  late IAuthorizationUser _acces;
  late IAuthorizationUser _proxy;
  @override
  void initState() {
    // TODO: implement initState
    _acces = AuthorizationUserImpl();
    _proxy = AuthorizationUserProxy(_acces, controller.user.value.role);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

   if(database.reservations.isNotEmpty && controller.user.value.role!='admin'){
    _reservationList=database.reservations[controller.user.value.username]!;
    debugPrint(_reservationList!.length.toString());}

    return Scaffold(
      backgroundColor: CustomColors.antiFlashWhiteBack,
      appBar: AppBar(
        backgroundColor: CustomColors.ufoGreen,
        toolbarHeight: 98,
        centerTitle: true,
        title: Text('Istoric rezervări',style: CustomTextStyle.interWhite24w700,),
      ),
      body:
          (controller.user.value.role!='admin')
              ?(_reservationList.isNotEmpty )
              ?ListView.separated(
            separatorBuilder: (context,index)=>const SizedBox(height: 8,),
            padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
            itemCount: _reservationList!.length,
              itemBuilder: (context,index)=>
                  Container(
                    height: 150,

                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(

                        boxShadow: const [BoxShadow( offset: Offset(
                          5.0,
                          5.0,
                        ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            color: CustomColors.philippineSilver
                        )],
                        borderRadius: BorderRadius.circular(45),

                        color: Colors.white
                    ),
                    child: Row(

                      children: [
                        Image.asset(
                            _reservationList![index].car.pathImage!,
                          width: 150,
                        ),

                        Expanded(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap:(){_proxy
        .cancelReservation(  _reservationList![index],controller.user.value.username);
                                  setState(() {

                                  });
                                  },
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(CupertinoIcons.trash_fill,color:CustomColors.deepCarmainePink,size: 30,),
                                ),
                              ),
                               Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_reservationList![index].car.marca,style: CustomTextStyle.interGunMetal18w600,),
                                    Text(_reservationList![index].car.model,style: CustomTextStyle.interGunMetal16w600,),

                                    Text(
    'Nr. de zile: ${_reservationList![index].endDate.difference(_reservationList![index].startDate).inDays+1}',
    style: CustomTextStyle.interGunMetal16w600,),
                                    const Spacer(),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text('${_reservationList![index].totalPrice} \$',
                                            style: CustomTextStyle.interGunMetal18w600,),
                                        ),

                                  ],
                                ),
                              
                            ],
                          ),
                        ),


                      ],
                    ),
                  )
          )
              :Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
            child: Container(
                height: 250,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Icon(CupertinoIcons.car_detailed,size: 80,color: CustomColors.ufoGreen,),
                   // const Icon(Icons.error,size: 35,color: CustomColors.deepCarmainePink,),
                    Text('Închiriează acum, pentru a vedea istoricul !',textAlign: TextAlign.center,style: CustomTextStyle.interGunMetal24w700,)
                  ],
                ),
            ),
          ),
              )
              :Container(
            height: 250,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                 const Icon(Icons.error,size: 80,color: CustomColors.deepCarmainePink,),
                Text('Admin-ul nu are acces la istoric !',textAlign: TextAlign.center,style: CustomTextStyle.interGunMetal24w700,)
              ],
            ),
          ),

    );
  }
}
