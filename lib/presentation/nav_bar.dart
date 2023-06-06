
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proiect/presentation/home/history/history_page.dart';
import 'package:proiect/presentation/home/home_list/home_page.dart';
import 'package:proiect/presentation/home/notification/notification_page.dart';
import 'package:proiect/presentation/home/profile/profile_page.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class NavigationBarWidget extends StatefulWidget {

  const NavigationBarWidget({

    super.key
  });

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {

    super.initState();

    // setState(() {
    //    _email =widget.email;
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CupertinoTabScaffold(

          tabBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            border: const Border(
                top: BorderSide(color: CustomColors.silverFoil,width: 0.5)
            ),
            height: 89,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 53,
                    width: 49,
                    child: Column(
                      children: const [
                       /* SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            'assets/svg/nav_bar_svg/home.svg',
                            color: CustomColors.argent,
                          ),
                        ),*/
                        Icon(CupertinoIcons.house_fill),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Acasă',
                          style: CustomTextStyle.interArgent12w400,
                        )
                      ],
                    )),
                activeIcon: SizedBox(
                    height: 53,
                    width: 49,
                    child: Column(
                      children: const [
                        Icon(CupertinoIcons.house_fill),

                       /* SvgPicture.asset(
                          'assets/svg/nav_bar_svg/home.svg',
                          height: 24,width: 24,
                          color: CustomColors.ufoGreen,
                        ),*/
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Acasă',
                          style: CustomTextStyle.interUfoGreen12w500,
                        )
                      ],
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 53,
                    width: 59,
                    child: Column(
                      children: const [
                        /*SvgPicture.asset('assets/svg/nav_bar_svg/bell.svg',
                          height: 24,width: 24,
                          color: CustomColors.argent,
                        ),*/
                        Icon(CupertinoIcons.bell_fill),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Notificări',
                          style: CustomTextStyle.interArgent12w400,
                        )
                      ],
                    )),
                activeIcon: SizedBox(
                    height: 53,
                    width: 59,
                    child: Column(
                      children: const [
                      /*  SvgPicture.asset('assets/svg/nav_bar_svg/bell.svg',
                            height: 24,width: 24,
                            color: CustomColors.ufoGreen),*/
                        Icon(CupertinoIcons.bell_fill),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Notificări',
                          style: CustomTextStyle.interUfoGreen12w500,
                        )
                      ],
                    )),
              ),

              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 53,
                    width: 53,
                    child: Column(
                      children: const [
                      /*  SvgPicture.asset(
                          'assets/svg/nav_bar_svg/history_icon.svg',
                          height: 24,width: 24,color: CustomColors.argent,
                        ),*/
                        Icon(Icons.history),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Istoric',
                          style: CustomTextStyle.interArgent12w400,
                        )
                      ],
                    )),
                activeIcon: SizedBox(
                    height: 53,
                    width: 53,
                    child: Column(
                      children: const [
                      /*  SvgPicture.asset(
                          'assets/svg/nav_bar_svg/history_icon.svg',
                          height: 24,width: 24,
                          color: CustomColors.ufoGreen,
                        ),*/
                        Icon(Icons.history),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Istoric',
                          style: CustomTextStyle.interUfoGreen12w500,
                        )
                      ],
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    height: 53,
                    width: 48,
                    child: Column(
                      children: const [
                      /*  SvgPicture.asset(
                          'assets/svg/nav_bar_svg/user.svg',
                          height: 24,width: 24,color: CustomColors.argent,
                        ),*/
                        Icon(CupertinoIcons.person_fill),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Profil',
                          style: CustomTextStyle.interArgent12w400,
                        )
                      ],
                    )),
                activeIcon: SizedBox(
                    height: 53,
                    width: 47,
                    child: Column(
                      children: const [
                      /*  SvgPicture.asset('assets/svg/nav_bar_svg/user.svg',
                            height: 24,width: 24, color: CustomColors.ufoGreen),*/
                        Icon(CupertinoIcons.person_fill),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Profil',
                          style: CustomTextStyle.interUfoGreen12w500,
                        )
                      ],
                    )),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return    CupertinoPageScaffold(
                    child: HomeClient(),
                  );
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return   CupertinoPageScaffold(
                    child: NotificationPage(),
                  );
                });
              case 2:
                return CupertinoTabView(builder: (context) {
                  return   CupertinoPageScaffold(
                    child: HistoryPage(),
                  );
                });
              case 3:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: ProfilePage(),
                  );
                });

              default:
                return CupertinoTabView(builder: (context) {
                  return  CupertinoPageScaffold(
                    backgroundColor: CustomColors.platinum,
                    child: Container(),
                  );
                });
            }
          },
        ));
  }

//_openSelectRestaurant(BuildContext context) => Navigator.of(context).pushNamed('/selectrestaurant');

}