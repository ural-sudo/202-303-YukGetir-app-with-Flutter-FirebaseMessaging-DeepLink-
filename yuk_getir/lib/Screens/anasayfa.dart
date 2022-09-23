import 'dart:async';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yuk_getir/Screens/deneme_page.dart';
import 'package:yuk_getir/Service/models/cargo_model.dart';
import 'package:yuk_getir/Service/models/favorites_model.dart';
import 'package:yuk_getir/Service/models/owner_model.dart';
import 'package:yuk_getir/Service/models/publish_model.dart';
import 'package:yuk_getir/Service/web_services/cargo_services/cargo_service.dart';
import 'package:yuk_getir/Service/web_services/favorites_services/fovarite_services.dart';
import 'package:yuk_getir/Service/web_services/firebase_services/firebase_deepLinkService.dart';
import 'package:yuk_getir/Service/web_services/firebase_services/firebase_notification_service.dart';
import 'package:yuk_getir/main.dart';

import '../Service/models/date_model.dart';



class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}
//AIzaSyDmi172zOClthnZNz1CJWJjgwgtOVxYnxc  = MAP TOKEN

class _AnasayfaState extends State<Anasayfa> {

    final Completer<GoogleMapController> _controller =  Completer();
    final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4
    );

    final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 4
    );
   
    late final Publish publish;
    late final Owner owner;
    late final Date date;
    List<CargoModel>? items;
    late IFavoriteService favoriteCervise;
    late ICargoService cargoService;
    late final NotificationService notifService = NotificationService();

    Future<void> getCargos() async {
      items = await cargoService.fetchCargo();
    }

    Future<void> addToFavotire(Favorite  model) async {
      await favoriteCervise.addToFavorite(model);
    }
     Future<void> removeFromFavorite(String cargoId) async {   
      await favoriteCervise.removeFromFavorite(cargoId);
    }
    Future<void> addCargo (CargoModel model) async {
      await cargoService.addCargo(model);
    } 
    late final FireBaseDeepLink deepLink;
    Future<void> initDeepp() async {
      deepLink.init();
    } 
    
     //FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
      //void initDeep() async {
        //dynamicLinks.onLink;
        /* if(dynamicLinks.onLink != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Deneme();
          }));
        } */
      //}
    

    @override
  void initState() {
    super.initState();
    deepLink = FireBaseDeepLink();
    initDeepp();
    notifService.connection();
    cargoService = CargoService();
    favoriteCervise = FavoriteCervise();
    getCargos();
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    const String logoPath = "assets/images/logo2.png";
    const String inviteIconName = "Davet Et";
    const String notifIconName = "Bildirimler";
    const String favorIconName = "Favorilerim";

//**************   Scaffold    ******************** */
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          owner = Owner(
              id: "OwnerId",
              name: "Deneme LTDİ ŞTİ"
          );
          date = Date(
            endDate: "End date",
            endOption: "End Option",
            startDate: "Start Date",
            startOption: "StartOption"
          );
          publish = Publish(
            type: "type",
            currency: "currency",
            date:date ,
            hasBargain: false,
            offerPrice: 2080,
            paymentMethod: "WihtPhone",
            vatIncluded: false
          );
          final cargoModel = CargoModel(
            id: "Cargonun Id si",
            distance: "Mesafe bilgisi",
            publish:publish,
            status: "status",
            loadStartDate: "loadStartDate",
            loadEndDate: "loadEndDate",
            loadFrom: "loadFrom",
            loadFromTown: "loadFromTown",
            unLoadDate: "unloadDate",
            unLoadTo: "unloadTo",
            unLoadToTown: "unLoadTown",
            weight: 27,
            weightUnit: "Ton",
            number: 1,
            owner: owner,
          );
          addCargo(cargoModel);
        },
        mini: true,
        child: Icon(Icons.add,color: Theme.of(context).colorScheme.onSurface,),
      ),
      bottomNavigationBar: BottomAppBarWidget(size: size),
      appBar: AppBar(
        title: Image.asset(logoPath,width: size.width*0.33,),
        toolbarHeight: size.height*0.12,
        actions: [
          AppBarActionWidget(
            icon: Icons.share_outlined,
            iconName: inviteIconName,
            iconColor: Theme.of(context).colorScheme.primary,
            press: (){
              Share.share('https://myexaple.page.link/deneme');
              //https://myaxaple.page.link/deneme
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width*0.03,left: size.width*0.03),
            child: AppBarActionWidget(
              icon: Icons.notifications,
              iconName: notifIconName,
              iconColor: Theme.of(context).colorScheme.primary,
              press: (){},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width*0.05),
            child: AppBarActionWidget(
              icon: Icons.favorite_outlined,
              iconName: favorIconName,
              iconColor: Theme.of(context).colorScheme.secondary,
              press: (){},
            ),
          ), 
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(right: size.width*0.05,left:size.width*0.05 ),
        child: Column(
          children: [
            HomeSearchWidget(size: size),
            const DescribeRow(vitrinText: "Vitrindekiler",),
            VitrinComponent(kGooglePlex: _kGooglePlex, controller: _controller, items: items),
            const DescribeRow(vitrinText: "Güncel İlanlar",),
            SizedBox(
            height: size.height*0.26,
            child: Card(
              color: Colors.white,
              child: ListView.builder(
                itemCount: items?.length,
                itemBuilder: (context, index) {
            var offerPrice;
            final publish = items?[index].publish;
            if(publish != null){
              offerPrice = publish.offerPrice;
            }else{
              offerPrice = "";
            }
            String loadTime = items?[index].loadStartDate ?? "";
            List<String> result = loadTime.split("T");
            String loadEndTime = items?[index].loadEndDate ?? "";
            List<String> resultEnd = loadEndTime.split("T");
            return SizedBox(
              height: size.height*0.3,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProjectElevButtons(
                          text:"Peşin - Alıcı Ödemeli",
                          textColor:Theme.of(context).colorScheme.primary,
                          primary: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          ProjectElevButtons(
                          text:"Detay Gör",
                          textColor:Theme.of(context).colorScheme.onSurface,
                          primary: Theme.of(context).colorScheme.primary,
                          ),
                          GestureDetector(
                            onTap: (){
                              
                              if(isFavorite == false){
                                final model = Favorite(
                                  cargoId: "${items?[index].id ?? ''}"
                                );
                                 addToFavotire(model);
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              }else{
                                 removeFromFavorite("${items?[index].id}");
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              }
                            },
                            child:isFavorite ? HomePageCircleAvatarWidget(
                              background:Theme.of(context).scaffoldBackgroundColor,
                              iconData: Icons.favorite,
                            )
                            : HomePageCircleAvatarWidget(
                            background:Theme.of(context).scaffoldBackgroundColor,
                            iconData: Icons.favorite_border,
                            ),
                          )
                        ],
                      ),
                       Padding(
                         padding: EdgeInsets.only(top: 3),
                         child: VehicleRoadInfoWidget(model: items?[index], offerPrice: offerPrice),
                       ),
                       Row(
                      children: [
                        Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.secondary,size: 22,),
                        Text(
                          "Yükleme tarihi: ${result[0]} - ${resultEnd[0]}",
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.background,),
                            Text("Araç Tipi : Tır 13.60 Açık",style: TextStyle(color: Colors.black,fontSize: 10),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.background,),
                            Text("Kiralama Tipi : Komple",style: TextStyle(color: Colors.black,fontSize: 11),),
                          ],
                        ),
                                
                      ],
                    ),
                    VehicleWeightInfoWidget(model: items?[index])
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
        )
          ],
        ),
      ),
    );
  }
}

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color:Theme.of(context).colorScheme.onSurface,
      child: SizedBox(
        height: size.height*0.086,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
               BottomNavigationItemWidget(
                 iconName: "Anasasyfa",
                 icon: Icons.home_filled,
                 ),
               Padding(
                 padding:EdgeInsets.only(top: size.height*0.01),
                 child: Column(
                  children: [
                    IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      hoverColor: Colors.red,
                      onPressed: (){},
                      icon:Icon(
                        Icons.search,
                        color:Theme.of(context).colorScheme.primary,)
                      ),
                    SizedBox(
                      height: 20,
                      width: 40,
                      child: Text(
                        "Yakınımda Ne Var ?",
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: size.width*0.02,
                          overflow: TextOverflow.fade,
                        ) ,
                      ),
                    ),
                  ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.only(top: size.height*0.04),
                 child: Text("Yüküm Var",style: TextStyle(
                  color:Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold 
                ),
                ),
               ),
              BottomNavigationItemWidget(iconName: "İlanlarım",
                icon: Icons.shopping_cart_checkout_sharp,
              ),
               BottomNavigationItemWidget(iconName: "Hesabım",
                icon: Icons.person,
              ),
               
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationItemWidget extends StatelessWidget {
    BottomNavigationItemWidget({
    Key? key,
    required this.iconName,
    this.fontSize = 0.03,
    required this.icon,
    
  }) : super(key: key);

  
  final String iconName;
  final IconData icon;
  double fontSize; 
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:EdgeInsets.only(top: size.height*0.01),
      child: Column(
       children: [
         IconButton(
            onPressed: (){},
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(icon,color: Theme.of(context).colorScheme.primary,)
         ),
         Text(
           iconName,
           style:TextStyle(
             color: Theme.of(context).colorScheme.primary,
             fontSize: size.width*fontSize,
           ) ,
         ),
       ],
      ),
    );
  }
}

class VehicleWeightInfoWidget extends StatelessWidget {
  const VehicleWeightInfoWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  
  final CargoModel? model;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.background,),
        Text("Tonaj : ${model?.weight ?? ''} ${model?.weightUnit ?? ''}",style: TextStyle(color: Theme.of(context).colorScheme.background,fontSize:size.width*0.029,fontWeight: FontWeight.bold),)
      ],
    );
  }
}

class VehicleRoadInfoWidget extends StatelessWidget {
  const VehicleRoadInfoWidget({
    Key? key,
    required this.model,
    required this.offerPrice,
  }) : super(key: key);

  final CargoModel? model;
  final  offerPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
       Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(model?.loadFrom ?? "" ,style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold)),
         Text(model?.loadFromTown ?? "",style: TextStyle(color: Theme.of(context).colorScheme.primary)),
       ],
     ),
     Padding(
       padding: EdgeInsets.symmetric(horizontal: 10),
       child: Column(
         children: [
           Text(model?.distance ?? "",style: TextStyle(color: Colors.black),),
           Icon(Icons.arrow_right_alt_outlined,color:Colors.black,),
         ],
       ),
     ),
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(model?.unLoadTo ?? "",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),
         Text(model?.unLoadToTown ?? "Off",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
       ],
     ),
       ],
     ),
     Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         Text(
         "${offerPrice} TL",
         style:TextStyle(color: Theme.of(context).colorScheme.error,fontWeight: FontWeight.bold)),
         Text("+KDV",style: TextStyle(color: Colors.black),)
       ],
     )
    ],
    );
  }
}

class VitrinComponent extends StatelessWidget {
   const VitrinComponent({
    Key? key,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
    required this.items,
  }) : _kGooglePlex = kGooglePlex, _controller = controller, super(key: key);

  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;
  final List<CargoModel>? items;
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height*0.32,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:_kGooglePlex,
                  onMapCreated:(GoogleMapController controller){
                    _controller.complete(controller);
                  }, 
                  ),
                  const Positioned(
                    bottom: 6,
                    left: 8,
                    child: ProjectElevButtons(
                      primary: Colors.white,
                      text: "Peşin - Alıcı ödemeli",
                      textColor:Color.fromARGB(196, 4, 85, 167),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 60,
                    child: ProjectElevButtons(
                      primary: Theme.of(context).colorScheme.primary,
                      text: "Detay Gör",
                      textColor: Colors.white,
                    )
                  ),
                  Positioned(
                    right: 0,
                    bottom: 6,
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: HomePageCircleAvatarWidget(
                        iconData: Icons.favorite_outline,
                        background: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  )
                ],
              )
            ),
            Expanded(
              flex: 4,
              child:Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: SizedBox(
                  height: 120,
                  child: Card(
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: items?.length,
                      itemBuilder: (context, index) {
                        var offerPrice;
                        final publish = items?[index].publish;
                        if(publish != null){
                          offerPrice = publish.offerPrice;
                        }else{
                          offerPrice = "";
                        }
                        String loadTime = items?[index].loadStartDate ?? "";
                        List<String> result = loadTime.split("T");
                        String loadEndTime = items?[index].loadEndDate ?? "";
                        List<String> resultEnd = loadEndTime.split("T");
                        return Column(
                          children: [
                            VehicleRoadInfoWidget(model: items?[index], offerPrice: offerPrice),
                            Row(
                              children: [
                                Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.secondary,),
                                Text(
                                  "Yükleme tarihi: ${result[0]} - ${resultEnd[0]}",
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.background,),
                                     Text("Araç Tipi : Tır 13.60 Açık",style: TextStyle(color: Theme.of(context).colorScheme.background ,fontSize:size.width*0.029,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_right,color: Theme.of(context).colorScheme.background,),
                                     Text("Kiralama Tipi : Komple",style: TextStyle(color: Theme.of(context).colorScheme.background,fontSize:size.width*0.029,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                            VehicleWeightInfoWidget(model: items?[index])
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class HomePageCircleAvatarWidget extends StatelessWidget {
   const HomePageCircleAvatarWidget({
    Key? key,
    required this.background,
    required this.iconData,
  }) : super(key: key);

  final Color background;
  final IconData iconData;

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: CircleAvatar(
        backgroundColor: background,
        child: Icon(
          iconData,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class ProjectElevButtons extends StatelessWidget {
  const ProjectElevButtons({
    Key? key,
    required this.primary,
    required this.text,
    required this.textColor,
  }) : super(key: key);
  final Color primary;
  final String text;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        onPressed: (){},
        child: Text(text,style: TextStyle(fontSize: 12,color: textColor),)
      ),
    );
  }
}

class DescribeRow extends StatelessWidget {
  const DescribeRow({
    Key? key,
    required this.vitrinText,
    
  }) : super(key: key);

  final String vitrinText;
  

  @override
  Widget build(BuildContext context) {
    const double vitrinTextSize = 17.0;
    const double textButtonsize = 12.0;
    const String textButton = "Tümünü Görüntüle";
      return SizedBox(
        height: 30,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
                   vitrinText,
                   style: const TextStyle(
            fontSize: vitrinTextSize,
            color: Colors.black,
            fontWeight: FontWeight.bold
            ),
                   ),
          TextButton(
           onPressed: (){},
           style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
           ),
           child:  const Text(
            textButton,
            style: TextStyle(
              fontSize: textButtonsize
            ) ,
            )
          )
        ],
    ),
      );
  }
}

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height*0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              
            child: Padding(
              padding: EdgeInsets.only(right:size.width*0.03,left:size.width*0.03),
              child: Icon(Icons.search,size:size.height*0.05,color: Theme.of(context).colorScheme.primary,),
            )),
          ),
           Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: size.width*0.03),
              child:const TextField(
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                  ),
                ),
            )
          )
        ],
      ),
    );
  }
}


class AppBarActionWidget extends StatelessWidget {
  
   AppBarActionWidget({
    Key? key,
    required this.icon,
    required this.press,
    required this.iconName,
    required this.iconColor,
  }) : super(key: key);
  final IconData icon;
  final String iconName;
  final Color iconColor;
  final VoidCallback press;
//Share.share('https://api.yukgetir.com');
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          constraints: BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: press,
          icon: Icon(icon,color: iconColor),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height*0.008 ),
          child: Text(iconName,style: ThemeData().textTheme.subtitle1?.copyWith(fontSize: 12, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.background)),
        )
      ],
    );
  }
}

