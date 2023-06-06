import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proiect/model/car.dart';
import 'package:proiect/model/reservation.dart';
import 'package:proiect/pattern/behavioral/strategy/context_stategy.dart';
import 'package:proiect/pattern/structural/decorator.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_impl.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_proxy.dart';
import 'package:proiect/pattern/structural/proxy/interface_authorization_user.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';
import 'package:table_calendar/table_calendar.dart';

class BottomSheetAddReservation extends StatefulWidget {

  final CarModel dataCar;
  const BottomSheetAddReservation({Key? key, required this.dataCar})
      : super(key: key);

  @override
  State<BottomSheetAddReservation> createState() =>
      _BottomSheetAddReservationState();
}

class _BottomSheetAddReservationState extends State<BottomSheetAddReservation> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late CarModel _dataCar;
   ContextStrategy? strategy;
    double totalPriceWithoutDiscount=0;
    double totalPrice=0;
    double discount=0;
    bool addOptions=false;
    ReservationModel? _reservationData;
  Reservation basicReservation = BasicReservation();
  Reservation? decoratedReservation;
  bool addChair=false;
  late IAuthorizationUser _acces;
  late IAuthorizationUser _proxy;
 final LoginController controller= Get.find();
  @override
  void initState() {
    _acces= AuthorizationUserImpl();
    _proxy= AuthorizationUserProxy(_acces, controller.user.value.role);
    _dataCar = widget.dataCar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('ro');
    return SizedBox(
      height: 650,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                color: CustomColors.ufoGreen),
            child: Center(
                child: Text((addOptions==false)
              ?'Setează timpul':'Adaugă opțiuni',
              style: CustomTextStyle.interWhite24w700,
            )),
          ),
          const SizedBox(
            height: 8,
          ),
          (addOptions==true)
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                const Text('Detalii rezervare:'),
                const SizedBox(height: 8,),
                Text(_reservationData!.car.marca,style: CustomTextStyle.interGunMetal24w600,),
                Text(_reservationData!.car.model,style: CustomTextStyle.interGunMetal18w400),
                const SizedBox(height: 32,),
                Text('Opțiuni:',style:  CustomTextStyle.interGunMetal24w600,),
                const SizedBox(height:15,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                        setState(() {


                        if (decoratedReservation is! CascoDecorator || decoratedReservation ==null) {
                          debugPrint('Initialization of CascoDecorator');
                          decoratedReservation =
                              CascoDecorator(basicReservation);
                        }
                        decoratedReservation!.addOption(_reservationData!);

                         })
                      ,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(
                                width:
                                ( _reservationData!.casco==true) ? 0 : 1,
                                color: CustomColors.argent),
                            color: ( _reservationData!.casco==true)
                                ? CustomColors.ufoGreen
                                : Colors.white),
                        child: Center(
                            child: Text(
                              'Casco',
                              style: ( _reservationData!.casco==true)
                                  ? CustomTextStyle.interWhite16w500
                                  : CustomTextStyle.interGunMetal16w500,
                            )),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Text('+30 \$',style:  CustomTextStyle.interGunMetal16w500,),

                  ],
                ),
                const SizedBox(height:15,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() {


                            if (decoratedReservation is! WifiDecorator || decoratedReservation ==null) {
                              debugPrint('Initialization of WifiDecorator');
                              decoratedReservation =
                                  WifiDecorator(basicReservation);
                            }
                            decoratedReservation!.addOption(_reservationData!);

                          })
                      ,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(
                                width:
                                ( _reservationData!.wifi==true) ? 0 : 1,
                                color: CustomColors.argent),
                            color: ( _reservationData!.wifi==true)
                                ? CustomColors.ufoGreen
                                : Colors.white),
                        child: Center(
                            child: /*Text(
                              '',
                              style: ( _reservationData!.casco==true)
                                  ? CustomTextStyle.interWhite16w500
                                  : CustomTextStyle.interGunMetal16w500,
                            )*/Icon(Icons.wifi,color:
                            ( _reservationData!.wifi==true)
                                ?Colors.white
                                :CustomColors.gunMetal
                              ,)
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Text('+4 \$',style:  CustomTextStyle.interGunMetal16w500,),

                  ],
                ),
                const SizedBox(height:15,),
                Text('GPS',style:  CustomTextStyle.interGunMetal16w500,),
                const SizedBox(height:8,),
                Row(
                  children: [

                    GestureDetector(
                      onTap: () =>
                          setState(() {


                            if (decoratedReservation is! GPSDecorator || decoratedReservation ==null) {
                              debugPrint('Initialization of GpsDecorator');
                              decoratedReservation =
                                  GPSDecorator(basicReservation);
                            }
                            decoratedReservation!.addOption(_reservationData!);

                          })
                      ,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(
                                width:
                                ( _reservationData!.hasGps==true) ? 0 : 1,
                                color: CustomColors.argent),
                            color: ( _reservationData!.hasGps==true)
                                ? CustomColors.ufoGreen
                                : Colors.white),
                        child: Center(
                            child: /*Text(
                              '',
                              style: ( _reservationData!.casco==true)
                                  ? CustomTextStyle.interWhite16w500
                                  : CustomTextStyle.interGunMetal16w500,
                            )*/Icon(Icons.gps_fixed,color:
                            ( _reservationData!.hasGps==true)
                                ?Colors.white
                                :CustomColors.gunMetal
                              ,)
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Text('+10 \$',style:  CustomTextStyle.interGunMetal16w500,),

                  ],
                ),
                const SizedBox(height:15,),
                Text('Șofer personal',style:  CustomTextStyle.interGunMetal16w500,),
                const SizedBox(height:8,),
                Row(
                  children: [

                    GestureDetector(
                      onTap: () =>
                          setState(() {


                            if (decoratedReservation is! PersonalDriverDecorator || decoratedReservation ==null) {
                              debugPrint('Initialization of PersonalDriverDecorator');
                              decoratedReservation =
                                  PersonalDriverDecorator(basicReservation);
                            }
                            decoratedReservation!.addOption(_reservationData!);

                          })
                      ,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(
                                width:
                                ( _reservationData!.personalDriver==true) ? 0 : 1,
                                color: CustomColors.argent),
                            color: ( _reservationData!.personalDriver==true)
                                ? CustomColors.ufoGreen
                                : Colors.white),
                        child: Center(
                            child: /*Text(
                              '',
                              style: ( _reservationData!.casco==true)
                                  ? CustomTextStyle.interWhite16w500
                                  : CustomTextStyle.interGunMetal16w500,
                            )*/Icon(Icons.person_add_alt_1,color:
                            ( _reservationData!.personalDriver==true)
                                ?Colors.white
                                :CustomColors.gunMetal
                              ,)
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Text('+70 \$',style:  CustomTextStyle.interGunMetal16w500,),

                  ],
                ),

                const SizedBox(height:15,),
                Text('Scaune pentru copii',style:  CustomTextStyle.interGunMetal16w500,),
                const SizedBox(height:8,),

                Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: CustomColors.ufoGreen
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){
                              setState(() {
                                if(_reservationData!.hasChildChairs!>0) {
                                  _reservationData!.hasChildChairs=_reservationData!.hasChildChairs!-1;
                                  _reservationData!.totalPrice-= 5;
                                }
                              });
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: const Icon(Icons.remove,color: CustomColors.ufoGreen,)),
                          ),
                          const SizedBox(width:15,),
                          SvgPicture.asset('assets/svg/child_seat.svg',height: 50,color: Colors.white,),
                          Text(_reservationData!.hasChildChairs.toString(),style: CustomTextStyle.interWhite18w600,),
                          const SizedBox(width:15,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if (decoratedReservation is! BabyChairDecorator || decoratedReservation==null) {
                                  debugPrint('Initialization of BabyChairDecorator');
                                  decoratedReservation=BabyChairDecorator(basicReservation);
                                }

                                decoratedReservation!.addOption(_reservationData!);
                              });
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: const Icon(Icons.add,color: CustomColors.ufoGreen,)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Text('+5 \$',style:  CustomTextStyle.interGunMetal16w500,),

                  ],
                ),
              ],
            ),
          )
          :TableCalendar(
            headerStyle:
                const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            calendarStyle: const CalendarStyle(isTodayHighlighted: false),
            startingDayOfWeek: StartingDayOfWeek.monday,
            locale: 'ro-RO',
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null; // Important to clean those
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });

              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
                if(_rangeEnd!=null && _rangeStart !=null){
                  ContextStrategy strategy=ContextStrategy(_rangeStart!, _rangeEnd!, _dataCar.pretPerZi);
                  strategy.applicationDiscount();
                  discount=strategy.strategy.calculateDiscount()*100;
                  totalPrice=strategy.totalPrice;
                  totalPriceWithoutDiscount=totalPrice*100/(100-discount);
                  debugPrint(totalPrice.toString());
                }
              });

            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),

          const Spacer(),
          if( totalPrice!= 0 && addOptions== false)
            Text('Suma închirierii: $totalPriceWithoutDiscount \$',style: CustomTextStyle.interGunMetal24w600,),
          if( totalPrice!= 0 && addOptions== false)
          Text('Reducere: ${discount.round()} %',style: CustomTextStyle.interGunMetal24w600,),
          if( totalPrice!= 0)
            Text('Suma închirierii: ${(_reservationData!=null)?_reservationData!.totalPrice:totalPrice} \$',style: CustomTextStyle.interGunMetal24w600,),

          const SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              if (_rangeEnd != null && _rangeStart != null && addOptions==false) {
                  setState(() {
                    addOptions=true;
                    _reservationData=ReservationModel(_dataCar, totalPrice, _rangeStart!, _rangeEnd!);
                  });
              }else{

                _proxy.makeReservation(
                  _reservationData!,controller.user.value.username
                  //  CarModel(1, 'Toyota', 'Camry', 2020, 'Sedan', 'Benzină', 2.5, 200, 8, 20,'assets/png/camry_010_s.jpg'),
                    );

                Get.back();
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: (_rangeEnd != null && _rangeStart != null)
                      ? CustomColors.ufoGreen
                      : CustomColors.argent),
              child: Center(
                child: Text((addOptions==false)
                  ?'Continuă':'Trimite',
                  style: CustomTextStyle.interWhite18w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
