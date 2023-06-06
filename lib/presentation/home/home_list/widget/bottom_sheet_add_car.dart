import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:proiect/pattern/creational/database.dart';
import 'package:proiect/pattern/creational/factory.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_impl.dart';
import 'package:proiect/pattern/structural/proxy/authorization_user_proxy.dart';
import 'package:proiect/pattern/structural/proxy/interface_authorization_user.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';
import 'package:proiect/presentation/resource/custom_textfield.dart';

class BottomSheetAddCar extends StatefulWidget {
  final int lastIdCar;
  const BottomSheetAddCar({Key? key, required this.lastIdCar}) : super(key: key);

  @override
  State<BottomSheetAddCar> createState() => _BottomSheetAddCarState();
}

class _BottomSheetAddCarState extends State<BottomSheetAddCar> {

  final List<String> _category = [
    'Sedan',
    'Compact',
    'Suv',
    'Sport',
  ];

  late IAuthorizationUser _acces;
  late IAuthorizationUser _proxy;
   int _lastIdCar=0;
  int _indexCategory=-1;
  late CarFactory _selectedFactory;
  final TextEditingController _brandCar = TextEditingController();
  final TextEditingController _modelCar = TextEditingController();
  int _selectedHorsePower = 0;
  double _selectedCapacityEngine = 0;
  String _selectedTypeEngine = '';
  double _selectedConsumption = 0;
  double _selectedConsumptionElectric=0;
  int _selectedPrice=0;
  int _selectedYear = 0;
  final List<double> _capacityList = [];
  final List<int> _horsePowerList = [];
  final List<double> _consumptionList = [];
  final List<double> _consumptionElectricList = [];
  final List<int>   _priceList=[];
  final LoginController controller =Get.find();
  @override
  void dispose() {
    debugPrint('Dispose Bottom Sheet');
    _brandCar.dispose();
    _modelCar.dispose();
    super.dispose();
  }

  @override
  void initState() {
    debugPrint('Ultimul id existent:${widget.lastIdCar}');
    if(_lastIdCar !=-1) {
      _lastIdCar=widget.lastIdCar;
    }
    _acces= AuthorizationUserImpl();
    _proxy= AuthorizationUserProxy(_acces, controller.user.value.role);
    double numar = 1.0;
    while (numar <= 7.0) {
      _capacityList.add(double.parse(numar.toStringAsFixed(1)));
      numar += 0.1;
    }
    int numar1 = 80;
    while (numar1 <= 700) {
      _horsePowerList.add(numar1);
      numar1 += 10;
    }
    double numar2 = 2.5;
    while (numar2 <= 25) {
      _consumptionList.add(double.parse(numar2.toStringAsFixed(1)));
      numar2 += 0.5;
    }
    double numar3 = 14;
    while (numar3 <= 30) {
      _consumptionElectricList.add(double.parse(numar3.toStringAsFixed(1)));
      numar3 += 0.5;
    }
    int numar4 = 10;
    while (numar4 <= 500) {
      _priceList.add(numar4);
      numar4 += 5;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: (_indexCategory == -1) ? 450 : 750,
        padding: const EdgeInsets.only( top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Adaugă o mașină',
                      style: CustomTextStyle.interGunMetal20w700,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Selectează tipul',
                    style: CustomTextStyle.interGunMetal16w700,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8.w,
                      ),
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          _indexCategory=index;
                          //_selectedCategory = _category[index];
                          (_indexCategory==0)
                              ?_selectedFactory=SedanFactory()
                              :(_indexCategory==1)
                          ?_selectedFactory=CompactCarFactory()
                          :(_indexCategory==2)
                              ?_selectedFactory=SUVFactory()
                          :_selectedFactory=SportCarFactory();
                          debugPrint(_selectedFactory.toString());
                        }),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              border: Border.all(
                                  width:
                                  (  _indexCategory==index) ? 0 : 1,
                                  color: CustomColors.argent),
                              color: (  _indexCategory==index)
                                  ? CustomColors.ufoGreen
                                  : Colors.white),
                          child: Center(
                              child: Text(
                                _category[index],
                                style: (  _indexCategory==index)
                                    ? CustomTextStyle.interWhite16w500
                                    : CustomTextStyle.interGunMetal16w500,
                              )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (_indexCategory != -1)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Introdu marca',
                            style: CustomTextStyle.interGunMetal16w700,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              text: 'Introdu marca',
                              typeinput: TextInputType.text,
                              input: _brandCar),
                          const Text(
                            'Introdu modelul',
                            style: CustomTextStyle.interGunMetal16w700,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              text: 'Introdu modelul',
                              typeinput: TextInputType.text,
                              input: _modelCar),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tip motor',
                                    style: CustomTextStyle.interGunMetal16w700,
                                  ),
                                  SizedBox(
                                    //height: 52,
                                    width: 140.w,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                            isExpanded: true,
                                            dropdownStyleData: DropdownStyleData(
                                              direction: DropdownDirection.textDirection,
                                              width: 138.w,
                                              offset: const Offset(1, 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  //border: Border.all(color: CustomColors.brigthGrey),

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(-1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                  ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                  borderRadius: BorderRadius.vertical(
                                                      bottom: Radius.circular(8))),
                                              maxHeight: 132,
                                            ),
                                            iconStyleData: const IconStyleData(
                                                openMenuIcon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: Icon(Icons.arrow_forward_ios)),
                                                icon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                    Icon(Icons.arrow_forward_ios))),
                                            buttonStyleData: ButtonStyleData(
                                              height: 52,
                                              //width:  121+24,
                                              padding:
                                              EdgeInsets.symmetric(horizontal: 20.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: CustomColors.argent,
                                                ),
                                              ),
                                            ),
                                            // buttonHeight: 70,
                                            //buttonWidth: 350,

                                            //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                            //dropdownDirection: DropdownDirection.right,

                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            hint: Text(
                                              'Select. motor',
                                              style:
                                              CustomTextStyle.interSpanishGrey16w500,
                                            ),
                                            //isExpanded: true,
                                            //isDense: true,
                                            // value: _selectedRoom,
                                            items: ['Benzin', 'Diesel', 'Electric']
                                                .map(
                                                  (minute) => DropdownMenuItem(
                                                value: minute,
                                                child: Text(
                                                  minute.toString(),
                                                  style: CustomTextStyle
                                                      .interRaisinBlack16w500,
                                                ),
                                              ),
                                            )
                                                .toList(),
                                            onChanged: (selectedItem) => setState(() {
                                              _selectedTypeEngine = selectedItem!;
                                              if(_selectedTypeEngine=='Electric') {
                                                _selectedConsumption=0;
                                                _selectedCapacityEngine=1;
                                              }
                                              if(_selectedTypeEngine == 'Benzin'||_selectedTypeEngine == 'Diesel'){
                                                _selectedConsumptionElectric=0;
                                              }
                                              _selectedPrice=0;
                                            })

                                          //controller.setSelectedMinutes(selectedItem),
                                          /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                        )),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'An de producție',
                                    style: CustomTextStyle.interGunMetal16w700,
                                  ),
                                  SizedBox(
                                    //height: 52,
                                    width: 140.w,
                                    // 164.w,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                            isExpanded: true,
                                            dropdownStyleData: DropdownStyleData(
                                              direction: DropdownDirection.textDirection,
                                              width: 138.w,
                                              offset: const Offset(1, 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  //border: Border.all(color: CustomColors.brigthGrey),

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(-1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                  ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                  borderRadius: BorderRadius.vertical(
                                                      bottom: Radius.circular(8))),
                                              maxHeight: 132,
                                            ),
                                            iconStyleData: const IconStyleData(
                                                openMenuIcon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: Icon(Icons.arrow_forward_ios)),
                                                icon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                    Icon(Icons.arrow_forward_ios))),
                                            buttonStyleData: ButtonStyleData(
                                              height: 52,
                                              //width:  121+24,
                                              padding:
                                              EdgeInsets.symmetric(horizontal: 20.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: CustomColors.argent,
                                                ),
                                              ),
                                            ),
                                            // buttonHeight: 70,
                                            //buttonWidth: 350,

                                            //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                            //dropdownDirection: DropdownDirection.right,

                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            hint: Text(
                                              'Select. an',
                                              style:
                                              CustomTextStyle.interSpanishGrey16w500,
                                            ),
                                            //isExpanded: true,
                                            //isDense: true,
                                            // value: _selectedRoom,
                                            items: [
                                              2023,
                                              2022,
                                              2021,
                                              2020,
                                              2019,
                                              2018,
                                              2017,
                                              2016,
                                              2015,
                                              2014,
                                              2013
                                            ]
                                                .map(
                                                  (minute) => DropdownMenuItem(
                                                value: minute,
                                                child: Text(
                                                  minute.toString(),
                                                  style: CustomTextStyle
                                                      .interRaisinBlack16w500,
                                                ),
                                              ),
                                            )
                                                .toList(),
                                            onChanged: (selectedItem) => setState(() {
                                              _selectedYear = selectedItem!;
                                            })

                                          //controller.setSelectedMinutes(selectedItem),
                                          /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_selectedTypeEngine == 'Benzin' ||
                                  _selectedTypeEngine == 'Diesel')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Capacitate cilindrică',
                                      style: CustomTextStyle.interGunMetal16w700,
                                    ),
                                    SizedBox(
                                      //height: 52,
                                      width: 140.w,
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                              isExpanded: true,
                                              dropdownStyleData: DropdownStyleData(
                                                direction:
                                                DropdownDirection.textDirection,
                                                width: 138.w,
                                                offset: const Offset(1, 8),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    //border: Border.all(color: CustomColors.brigthGrey),

                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(-1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(0, 1),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                    ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                    borderRadius: BorderRadius.vertical(
                                                        bottom: Radius.circular(8))),
                                                maxHeight: 132,
                                              ),
                                              iconStyleData: const IconStyleData(
                                                  openMenuIcon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios)),
                                                  icon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios))),
                                              buttonStyleData: ButtonStyleData(
                                                height: 52,
                                                //width:  121+24,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: CustomColors.argent,
                                                  ),
                                                ),
                                              ),
                                              // buttonHeight: 70,
                                              //buttonWidth: 350,

                                              //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                              //dropdownDirection: DropdownDirection.right,

                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              hint: Text(
                                                'Select. volum',
                                                style: CustomTextStyle
                                                    .interSpanishGrey16w500,
                                              ),
                                              //isExpanded: true,
                                              //isDense: true,
                                              // value: _selectedRoom,

                                              items: _capacityList
                                                  .map(
                                                    (minute) => DropdownMenuItem(
                                                  value: minute,
                                                  child: Text(
                                                    minute.toString(),
                                                    style: CustomTextStyle
                                                        .interRaisinBlack16w500,
                                                  ),
                                                ),
                                              )
                                                  .toList(),
                                              onChanged: (selectedItem) => setState(() {
                                                _selectedCapacityEngine =
                                                selectedItem!;
                                              })

                                            //controller.setSelectedMinutes(selectedItem),
                                            /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                          )),
                                    )
                                  ],
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Putere motor',
                                    style: CustomTextStyle.interGunMetal16w700,
                                  ),
                                  SizedBox(
                                    //height: 52,
                                    width: 140.w,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                            isExpanded: true,
                                            dropdownStyleData: DropdownStyleData(
                                              direction: DropdownDirection.textDirection,
                                              width: 138.w,
                                              offset: const Offset(1, 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  //border: Border.all(color: CustomColors.brigthGrey),

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(-1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                  ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                  borderRadius: BorderRadius.vertical(
                                                      bottom: Radius.circular(8))),
                                              maxHeight: 132,
                                            ),
                                            iconStyleData: const IconStyleData(
                                                openMenuIcon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: Icon(Icons.arrow_forward_ios)),
                                                icon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                    Icon(Icons.arrow_forward_ios))),
                                            buttonStyleData: ButtonStyleData(
                                              height: 52,
                                              //width:  121+24,
                                              padding:
                                              EdgeInsets.symmetric(horizontal: 20.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: CustomColors.argent,
                                                ),
                                              ),
                                            ),
                                            // buttonHeight: 70,
                                            //buttonWidth: 350,

                                            //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                            //dropdownDirection: DropdownDirection.right,

                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            hint: Text(
                                              'Select. Hp',
                                              style:
                                              CustomTextStyle.interSpanishGrey16w500,
                                            ),
                                            //isExpanded: true,
                                            //isDense: true,
                                            // value: _selectedRoom,
                                            items: _horsePowerList
                                                .map(
                                                  (minute) => DropdownMenuItem(
                                                value: minute,
                                                child: Text(
                                                  minute.toString(),
                                                  style: CustomTextStyle
                                                      .interRaisinBlack16w500,
                                                ),
                                              ),
                                            )
                                                .toList(),
                                            onChanged: (selectedItem) => setState(() {
                                              _selectedHorsePower = selectedItem!;
                                            })

                                          //controller.setSelectedMinutes(selectedItem),
                                          /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                        )),
                                  )
                                ],
                              ),
                              if(_selectedTypeEngine == 'Electric')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Consum ',
                                      style: CustomTextStyle.interGunMetal16w700,
                                    ),
                                    SizedBox(
                                      //height: 52,
                                      width: 140.w,
                                      // 164.w,
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                              isExpanded: true,
                                              dropdownStyleData: DropdownStyleData(
                                                direction:
                                                DropdownDirection.textDirection,
                                                width: 138.w,
                                                offset: const Offset(1, 8),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    //border: Border.all(color: CustomColors.brigthGrey),

                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(-1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(0, 1),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                    ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                    borderRadius: BorderRadius.vertical(
                                                        bottom: Radius.circular(8))),
                                                maxHeight: 132,
                                              ),
                                              iconStyleData: const IconStyleData(
                                                  openMenuIcon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios)),
                                                  icon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios))),
                                              buttonStyleData: ButtonStyleData(
                                                height: 52,
                                                //width:  121+24,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: CustomColors.argent,
                                                  ),
                                                ),
                                              ),
                                              // buttonHeight: 70,
                                              //buttonWidth: 350,

                                              //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                              //dropdownDirection: DropdownDirection.right,

                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              hint: Text(
                                                'Select. consum',
                                                style: CustomTextStyle
                                                    .interSpanishGrey16w500,
                                              ),
                                              //isExpanded: true,
                                              //isDense: true,
                                              // value: _selectedRoom,
                                              items: _consumptionElectricList
                                                  .map(
                                                    (minute) => DropdownMenuItem(
                                                  value: minute,
                                                  child: Text(
                                                    minute.toString(),
                                                    style: CustomTextStyle
                                                        .interRaisinBlack16w500,
                                                  ),
                                                ),
                                              )
                                                  .toList()
                                              ,
                                              onChanged: (selectedItem) => setState(() {
                                                _selectedConsumptionElectric = selectedItem!;
                                              })

                                            //controller.setSelectedMinutes(selectedItem),
                                            /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                          )),
                                    )
                                  ],
                                )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //  if (_selectedTypeEngine != '')
                              if(_selectedTypeEngine != 'Electric' && _selectedTypeEngine!='')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Consum ',
                                      style: CustomTextStyle.interGunMetal16w700,
                                    ),
                                    SizedBox(
                                      //height: 52,
                                      width: 140.w,
                                      // 164.w,
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField2(
                                              isExpanded: true,
                                              dropdownStyleData: DropdownStyleData(
                                                direction:
                                                DropdownDirection.textDirection,
                                                width: 138.w,
                                                offset: const Offset(1, 8),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    //border: Border.all(color: CustomColors.brigthGrey),

                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(-1, 0),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                      BoxShadow(
                                                          color: CustomColors.argent,
                                                          offset: Offset(0, 1),
                                                          spreadRadius: 0,
                                                          blurRadius: 0),
                                                    ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                    borderRadius: BorderRadius.vertical(
                                                        bottom: Radius.circular(8))),
                                                maxHeight: 132,
                                              ),
                                              iconStyleData: const IconStyleData(
                                                  openMenuIcon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios)),
                                                  icon: SizedBox(
                                                      height: 24,
                                                      width: 24,
                                                      child:
                                                      Icon(Icons.arrow_forward_ios))),
                                              buttonStyleData: ButtonStyleData(
                                                height: 52,
                                                //width:  121+24,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: CustomColors.argent,
                                                  ),
                                                ),
                                              ),
                                              // buttonHeight: 70,
                                              //buttonWidth: 350,

                                              //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                              //dropdownDirection: DropdownDirection.right,

                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                              hint: Text(
                                                'Select. consum',
                                                style: CustomTextStyle
                                                    .interSpanishGrey16w500,
                                              ),
                                              //isExpanded: true,
                                              //isDense: true,
                                              // value: _selectedRoom,
                                              items:_consumptionList
                                                  .map(
                                                    (minute) => DropdownMenuItem(
                                                  value: minute,
                                                  child: Text(
                                                    minute.toString(),
                                                    style: CustomTextStyle
                                                        .interRaisinBlack16w500,
                                                  ),
                                                ),
                                              )
                                                  .toList(),
                                              onChanged: (selectedItem) => setState(() {
                                                _selectedConsumption = selectedItem!;
                                              })

                                            //controller.setSelectedMinutes(selectedItem),
                                            /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                          )),
                                    )
                                  ],
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Preț \$/zi',
                                    style: CustomTextStyle.interGunMetal16w700,
                                  ),
                                  SizedBox(
                                    //height: 52,
                                    width: 140.w,
                                    // 164.w,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                            isExpanded: true,
                                            dropdownStyleData: DropdownStyleData(
                                              direction:
                                              DropdownDirection.textDirection,
                                              width: 138.w,
                                              offset: const Offset(1, 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  //border: Border.all(color: CustomColors.brigthGrey),

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(-1, 0),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                    BoxShadow(
                                                        color: CustomColors.argent,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                        blurRadius: 0),
                                                  ],
/*boxShadow:[BoxShadow(
      color: Colors.transparent,
      spreadRadius: 0,
      blurRadius: 0,
      offset: Offset(0,0), // changes position of shadow
      ),
      ],*/
                                                  borderRadius: BorderRadius.vertical(
                                                      bottom: Radius.circular(8))),
                                              maxHeight: 132,
                                            ),
                                            iconStyleData: const IconStyleData(
                                                openMenuIcon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                    Icon(Icons.arrow_forward_ios)),
                                                icon: SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                    Icon(Icons.arrow_forward_ios))),
                                            buttonStyleData: ButtonStyleData(
                                              height: 52,
                                              //width:  121+24,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: CustomColors.argent,
                                                ),
                                              ),
                                            ),
                                            // buttonHeight: 70,
                                            //buttonWidth: 350,

                                            //dropdownPadding: EdgeInsets.symmetric(horizontal: 72,),
                                            //dropdownDirection: DropdownDirection.right,

                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            hint: Text(
                                              'Select. preț',
                                              style: CustomTextStyle
                                                  .interSpanishGrey16w500,
                                            ),
                                            //isExpanded: true,
                                            //isDense: true,
                                            // value: _selectedRoom,
                                            items:_priceList
                                                .map(
                                                  (minute) => DropdownMenuItem(
                                                value: minute,
                                                child: Text(
                                                  minute.toString(),
                                                  style: CustomTextStyle
                                                      .interRaisinBlack16w500,
                                                ),
                                              ),
                                            )
                                                .toList(),
                                            onChanged: (selectedItem) => setState(() {
                                              _selectedPrice = selectedItem!;
                                            })

                                          //controller.setSelectedMinutes(selectedItem),
                                          /*if(_selectedObject=='Administrator')
                          _navigateToAdminRegisterPage(context);
                        else if(_selectedObject=='Chelner')
                          _navigateToWaiterRegisterPage(context);*/
                                        )),
                                  )
                                ],
                              ),

                              // else

                            ],
                          ),
                        ]),
                ],
              ),
            ),

          const Spacer(),
             GestureDetector(
               onTap:(){
               if(  _brandCar.text.isNotEmpty ||
                   _modelCar.text.isNotEmpty ||
                   _selectedHorsePower != 0 ||
                   _selectedCapacityEngine != 0 ||
                   _selectedTypeEngine != '' ||
                   _selectedConsumption != 0 &&
                       _selectedConsumptionElectric!=0 ||
                   _selectedPrice!=0 ||
                   _selectedYear != 0 )
               {
                   _proxy
                       .addCarModel(
                       _selectedFactory
                           .createCar(_lastIdCar+1, _brandCar.text, _modelCar.text, _selectedYear, _selectedTypeEngine, _selectedCapacityEngine, _selectedHorsePower, (_selectedConsumption!=0)?_selectedConsumption:_selectedConsumptionElectric, _selectedPrice,)
                   );
                   final Database database=Database.getInstance();
                   database.notifyCarAdded(_selectedFactory
                       .createCar(_lastIdCar+1, _brandCar.text, _modelCar.text, _selectedYear, _selectedTypeEngine, _selectedCapacityEngine, _selectedHorsePower, (_selectedConsumption!=0)?_selectedConsumption:_selectedConsumptionElectric, _selectedPrice,)
                   );
                   Get.back();
               }
               },

               child: Container(
              height: 50,
                  width: double.infinity,
                 color:(  _brandCar.text.isEmpty ||
                     _modelCar.text.isEmpty ||
                     _selectedHorsePower == 0 ||
                  _selectedCapacityEngine == 0 ||
                  _selectedTypeEngine == '' ||
                  _selectedConsumption == 0 &&
                  _selectedConsumptionElectric==0 ||
                  _selectedPrice==0 ||
                  _selectedYear == 0 )
                 ?CustomColors.argent
                 :CustomColors.ufoGreen,
                  child: Center(
                    child: Text(
                      'Înregistrează',
                    style: CustomTextStyle.interWhite16w600,
                    ),
                  ),
                ),
             ),


          ],
        ),
      ),
    );
  }
}
