import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:proiect/model/car.dart';

import 'package:proiect/pattern/creational/database.dart';

import 'package:proiect/presentation/home/detail/car_detail_page.dart';
import 'package:proiect/presentation/home/home_list/widget/bottom_sheet_add_car.dart';
import 'package:proiect/presentation/home/home_list/widget/bottom_sheet_add_reservation.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_font.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> with TickerProviderStateMixin {
  Database database = Database.getInstance();
  int lastIdCar = -1;

  final List<String> category = [
    'Sedan',
    'Compact',
    'Suv',
    'Sport',
  ];
  /*final List<CarModel> carList=[
    CarModel(1, 'Toyota', 'Camry', 2020, 'Sedan', 'Benzină', 2.5, 200, 8, 20,'assets/png/camry_010_s.jpg'),

  ];*/

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: category.length);


  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TextEditingController searchInput = TextEditingController();
    //HomeClientController controller = Get.find();
    if (database.availableCarModels.isNotEmpty) {
      lastIdCar = database.availableCarModels.last.id;
    }
    return Scaffold(
        backgroundColor: CustomColors.antiFlashWhiteBack,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: const Color(0xFF437AD0),
                  forceElevated: innerBoxIsScrolled,
                  titleSpacing: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(45))),
                  //titleSpacing: 40,
                  toolbarHeight: (205 - 30).h,
                  automaticallyImplyLeading: false,
                  title: Stack(
                    children: [
                      Image.asset('assets/svg/wave.png'),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*   const Text(
                                        'Buna ziua, [Nume]',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: CustomFonts.inter,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.gunMetal),
                                      ),*/
                            Text(
                              'Alege o mașină',
                              style: CustomTextStyle.interWhite24w700,
                            ),
                            const SizedBox(
                              height: 19,
                            ),
                            SizedBox(
                              height: 48,
                              child: TextFormField(
                                //controller: searchInput,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      //Padding(
                                      //  padding: EdgeInsets.only(
                                      //    left: 19, top: 15, bottom: 15),
                                      //child:
                                      Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: SvgPicture.asset(
                                            'assets/svg/client_svg/reservation_svg/search.svg')),
                                  ),
                                  //  ),
                                  hintStyle: const TextStyle(
                                      color: CustomColors.spanishGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: CustomFonts.inter),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  hintText: 'Introdu marca ',
                                  filled: true,
                                  fillColor: Colors.white,
                                  // icon:SvgPicture.asset('assets/search-icon.svg',height: 5,width: 5,color: CustomColors.GreyForButtonNavigation,),

                                  //errorText: widget.validate ? 'Câmpul trebuie completat': null,
                                  // errorStyle: TextStyle(color: Colors.red),

                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color: CustomColors.spanishGrey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          width: 0.5,
                                          color: CustomColors.spanishGrey)),
                                ),
                                onChanged: (value) {
                                  //controller.filterByName.value = value;
                                  // controller.filteredElements();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //SvgPicture.asset('assets/svg/wave.svg'),

                  // toolbarHeight: 100,
                  /*title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Buna ziua, [Nume]',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: CustomFonts.inter,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.gunMetal),
                          ),
                          SizedBox(height: 19,),
                          SizedBox(
                            height: 48,
                            child: TextFormField(
                              //controller: searchInput,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                prefixIcon:
                                //Padding(
                                //  padding: EdgeInsets.only(
                                //    left: 19, top: 15, bottom: 15),
                                //child:
                                const Icon(
                                  Icons.search,
                                  color: CustomColors.silverFoil,
                                ),
                                //  ),
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Introdu localul',
                                filled: true,
                                fillColor: Colors.white,
                                // icon:SvgPicture.asset('assets/search-icon.svg',height: 5,width: 5,color: CustomColors.GreyForButtonNavigation,),

                                //errorText: widget.validate ? 'Câmpul trebuie completat': null,
                                // errorStyle: TextStyle(color: Colors.red),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        width: 1,
                                        color: CustomColors.philippineSilver)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        width: 1,
                                        color: CustomColors.philippineSilver)),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                  stretch: true,
                  floating: true,
                  pinned: true,
                  snap: true,
                  //forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(28 + 15 + 2 + 3),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15 + 1,
                        ),
                        TabBar(
                          controller: _tabController,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          labelPadding: const EdgeInsets.only(right: 24),
                          indicatorPadding: const EdgeInsets.only(right: 24),
                          labelStyle: CustomTextStyle.interWhite16w600,
                          unselectedLabelColor: CustomColors.spanishGrey,
                          labelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.white,
                          isScrollable: true,
                          tabs: category.map((category) {
                            return SizedBox(
                                height: 30,
                                child: Text(category.toUpperCase()));
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(top: 28 + 15 + 2 + 3 + 18.h),
            child: Stack(
              children: [
                TabBarView(controller: _tabController, children: [
                  _buildCarListByType('Sedan'),
                  _buildCarListByType('Compact'),
                  _buildCarListByType('Suv'),
                  _buildCarListByType('Sport'),
                ]),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20.h),
                  child: GestureDetector(
                      onTap: () => Get.bottomSheet(
                          BottomSheetAddCar(
                            lastIdCar: lastIdCar,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45))),
                          backgroundColor: Colors.white,
                          isScrollControlled: true),
                      /*  CarFactory car=SUVFactory();
                          _proxy.addCarModel(
                            //  CarModel(1, 'Toyota', 'Camry', 2020, 'Sedan', 'Benzină', 2.5, 200, 8, 20,'assets/png/camry_010_s.jpg'),
                             car.createCar(1, 'Toyota', 'Camry', 2020, 'Benzină', 2.5, 200, 8, 20,));


                          setState(() {
                          });*/

                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.ufoGreen),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              )))),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildCarListByType(String type) {
    List<CarModel> filteredList = database.availableCarModels
        .where((car) => car.tipMasina == type)
        .toList();

    return (filteredList.isNotEmpty)
        ? GridView.builder(
            //padding: EdgeInsets.symmetric(horizontal: 40.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
            //padding: const EdgeInsets.symmetric(horizontal: 40),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              CarModel car = filteredList[index];
              return GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(
                      builder: (context) => CarDetailPage(
                        dataCar: car,
                      ),
                    ))
                    .then((value) => setState(() {})),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                color: CustomColors.philippineSilver)
                          ],
                          borderRadius: BorderRadius.circular(45),
                          color: Colors.white),

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (car.pathImage != '')
                                ? Center(
                                    child: Image.asset(
                                    car.pathImage!,
                                    height: 116,
                                  ))
                                : const SizedBox(),
                            Text(
                              '${car.marca} ${car.model}',
                              style: CustomTextStyle.interGunMetal16w500,
                            ),

                            const Spacer(),
                            // Text('Ziua',style: CustomTextStyle.interGunMetal16w400,),

                            Text(
                              '${car.pretPerZi} \$ /Zi',
                              style: CustomTextStyle.interGunMetal16w500,
                            ),
                          ]),
                      // Alte detalii despre mașină
                    ),
                    GestureDetector(
                      onTap: () => Get.bottomSheet(
                        BottomSheetAddReservation(
                          dataCar: car,
                        ),
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45))),
                        backgroundColor: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 100,
                          height: 45,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: CustomColors.ufoGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  bottomRight: Radius.circular(45))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Arendă',
                                style: CustomTextStyle.interWhite14w500,
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        : Center(
            child: Column(
              children: [
                Text(
                  'Nu există înregistrări !',
                  style: CustomTextStyle.interGunMetal18w600,
                )
              ],
            ),
          );
  }
}
