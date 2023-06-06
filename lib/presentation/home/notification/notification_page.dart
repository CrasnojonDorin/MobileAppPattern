import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proiect/pattern/behavioral/observer/client_oberser.dart';
import 'package:proiect/pattern/behavioral/observer/interface_observer.dart';
import 'package:proiect/pattern/creational/database.dart';
import 'package:proiect/presentation/login/controller/login_controller.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final LoginController controller = Get.find();
  late bool switchRegisterNotify;
  Database database =Database.getInstance();
  late InterfaceObserver observer;
  @override
  void initState() {
    if(database.observers.isNotEmpty){
      for (InterfaceObserver observerExist in database.observers) {
        if (observerExist.username == controller.user.value.username) {
          switchRegisterNotify=true;
          observer = observerExist;
        }else{switchRegisterNotify=false;}
      }
    }else{
      switchRegisterNotify=false;
      observer= ClientObserver(controller.user.value.username);
    }


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: CustomColors.antiFlashWhiteBack,
      appBar: AppBar(
        backgroundColor: CustomColors.ufoGreen,
        toolbarHeight: 98,
        centerTitle: true,
        title: Text('Notificări',style: CustomTextStyle.interWhite24w700,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [

            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.topRight,
              child: CupertinoSwitch(
                  value: switchRegisterNotify,
                  onChanged: (value)=>setState(() {
                    switchRegisterNotify =value;
                    if(switchRegisterNotify==true){
                        database.registerObserver(observer);
                    }else{
                      database.unregisterObserver(controller.user.value.username);
                    }

                  })),
            ),
            (switchRegisterNotify ==true)
                ? (observer.listCar.isNotEmpty)
                ?Expanded(
                  child: ListView.separated(
              itemCount: observer.listCar.length,
                  separatorBuilder: (context,index)=>SizedBox(height: 8,),
                  itemBuilder: (context,index)=>Column(
                    children: [
                      Container(
                        width: double.infinity,
                        //height: 100,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: CustomColors.argent)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('A fost adăugat o nouă mașină în sistem !',style: CustomTextStyle.interGunMetal18w600,),
                            SizedBox(height: 8,),
                            Text('Categoria: ${observer.listCar[index].tipMasina}',style: CustomTextStyle.interGunMetal16w500,),
                            SizedBox(height: 8,),
                            Text('Model: ${observer.listCar[index].marca.toUpperCase()} ${observer.listCar[index].model}',style: CustomTextStyle.interGunMetal16w500,),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: CustomColors.ufoGreen
                                ),
                                child: Text(' ${observer.listCar[index].pretPerZi} \$/zi' ,style: CustomTextStyle.interWhite16w500,),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          observer.listCar.remove(observer.listCar[index]);
                          setState(() {

                          });
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 205,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green
                            ),
                            child: Row(
                              children: [
                                Text('Marchează ca citit',style: CustomTextStyle.interWhite18w600,),
                                Icon(Icons.verified_rounded,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
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
                children:const [
                  Icon(CupertinoIcons.exclamationmark_octagon_fill,size: 80,color: CustomColors.ufoGreen,),
                  // const Icon(Icons.error,size: 35,color: CustomColors.deepCarmainePink,),
                  Text('Dacă în sistem vor fi incluse noi mașini, aici vei primi notificări !',textAlign: TextAlign.center,style: CustomTextStyle.interGunMetal24w700,)
                ],
              ),
            )
                : Container(
                    height: 250,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const [
                        Icon(CupertinoIcons.exclamationmark_octagon_fill,size: 80,color: CustomColors.ufoGreen,),
                        // const Icon(Icons.error,size: 35,color: CustomColors.deepCarmainePink,),
                        Text('Înregistrează-te pentru a primi notificări !',textAlign: TextAlign.center,style: CustomTextStyle.interGunMetal24w700,)
                      ],
                    ),
                  ),


          ],
        ),
      ),
    );
  }
}
