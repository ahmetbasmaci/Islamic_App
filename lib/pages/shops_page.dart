import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import '../constents/colors.dart';
import '../components/my_switch.dart';

class ShopProps {
  ShopProps({
    required this.shopName,
    required this.lat,
    required this.lng,
    required this.isActive,
    required this.isSelected,
  });
  Map<String, Object?> toMap() {
    return {
      'shopName': shopName,
      'lat': lat,
      'lng': lng,
      'isActive': isActive,
      'isSelected': isSelected,
    };
  }

  static ShopProps fromMap(Map map) {
    return ShopProps(
      shopName: map['shopName'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      isActive: map['isActive'] as bool,
      isSelected: map['isSelected'] as bool,
    );
  }

  String shopName;
  double lat;
  double lng;
  bool isActive;
  bool isSelected;
}

class ShopsPage extends StatefulWidget {
  const ShopsPage({Key? key}) : super(key: key);
  static const String id = 'SettingsPage';
  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  final TextEditingController _shopCtr = TextEditingController();
  List<ShopProps> shopsList = [];
  bool isloading = false;
  GetStorage getStorage = GetStorage();
  int selectedItems = 0;
  late Position pos;
  @override
  void initState() {
    super.initState();
    getShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'مواقع الاسواق المضافة',
        leading: Builder(builder: (context2) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context2).openDrawer();
            },
            icon: MyIcons.drawer,
          );
        }),
        actions: [
          selectedItems > 0
              ? IconButton(
                  onPressed: () {
                    selectedItems = 0;
                    for (var element in shopsList) {
                      element.isSelected = true;
                      selectedItems++;
                    }
                    setState(() {});
                  },
                  icon: MyIcons.selectAll,
                )
              : Container(),
        ],
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddShopDialog(),
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: <Widget>[
          // ZikrCard(
          //   zikrData: ZikrData(
          //     zikrType: ZikrType.hadith,
          //     title: 'عن عمر بن الخطاب ـ رضي الله عنه ـ أن رسول الله صلى الله عليه  وسلم قال',
          //     content:
          //         'من دخل السوق فقال لا إله إلا الله وحده لا شريك له له الملك وله الحمد يحيي ويميت وهو حي لا يموت بيده الخير وهو على كل شيء قدير كتب الله له ألف ألف حسنة ومحا عنه ألف ألف سيئة ورفع له ألف ألف درجة.',
          //   ),
          // ),
          Divider(),
          isloading
              ? MyCircularProgressIndecator()
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shopsList.length,
                  itemBuilder: ((context, index) => Container(
                        margin: index != shopsList.length - 1
                            ? EdgeInsets.only(bottom: MySiezes.betweanCardItems)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: shopsList[index].isSelected ? Color.fromARGB(70, 145, 145, 145) : null,
                          border: Border(
                              bottom: BorderSide(
                            color: shopsList[index].isSelected ? MyColors.primaryDark : Colors.grey,
                          )),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: MySiezes.cardPadding),
                        child: InkWell(
                          onLongPress: () {
                            shopsList[index].isSelected = true;
                            selectedItems++;
                            setState(() {});
                          },
                          onTap: () {
                            if (shopsList[index].isSelected) {
                              shopsList[index].isSelected = false;
                              selectedItems--;
                            } else {
                              if (selectedItems > 0) {
                                shopsList[index].isSelected = true;
                                selectedItems++;
                              }
                            }
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MyTexts.settingsTitle(title: shopsList[index].shopName),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyTexts.settingsContent(title: 'تفعيل الاشعار'),
                                  MySwitch(
                                    value: shopsList[index].isActive,
                                    onChanged: (newValue) {
                                      setState(() {
                                        shopsList[index].isActive = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    deleteShop(shopsList[index].shopName);
                                  },
                                  icon: MyIcons.delete),
                            ],
                          ),
                        ),
                      )),
                )
        ],
      ),
    );
  }

  void selectItems(String shopName) {
    bool founded = false;
    shopsList = getStorage.read('shops') ?? [];
    for (var i = 0; i < shopsList.length; i++) {
      if (shopsList[i].shopName == shopName) {
        founded = true;
        break;
      }
      if (founded)
        selectedItems++;
      else
        selectedItems--;
    }
  }

  void deleteShop(String shopName) async {
    Alert(
        context: context,
        type: AlertType.warning,
        title: 'تأكيد الحذف',
        desc: 'هل تريد حذف $shopName؟',
        buttons: [
          DialogButton(
            onPressed: () => Get.back(),
            color: Colors.transparent,
            child: Text("الغاء", style: TextStyle(color: Colors.red)),
          ),
          DialogButton(
            onPressed: () {
              shopsList.removeWhere((element) => element.shopName == shopName);
              updateDb(shopsList);
              Get.back();
              setState(() {});
            },
            color: MyColors.primary(),
            child: Text("تأكيد", style: TextStyle(color: Colors.white)),
          ),
        ],
        style: AlertStyle(
          alertAlignment: Alignment.center,
          alertElevation: 0,
          titleTextAlign: TextAlign.right,
          backgroundColor: MyColors.background(),
          titleStyle: Theme.of(context).textTheme.headline1!,
          descStyle: TextStyle(
            color: MyColors.whiteBlack(),
            fontSize: 14,
          ),
        )).show();
  }

  void getShops() {
    List<dynamic> mapList = getStorage.read('shops') ?? [];
    for (var element in mapList) shopsList.add(ShopProps.fromMap(element));
  }

  void _addLocation() async {
    Get.back();
    setState(() {
      isloading = true;
    });

    shopsList.add(ShopProps(
      shopName: _shopCtr.text,
      lat: pos.latitude,
      lng: pos.longitude,
      isActive: true,
      isSelected: false,
    ));
    updateDb(shopsList);
    setState(() {
      isloading = false;
    });
  }

  checkLocation() async {
    if (shopsList.isEmpty) return;
    Position currentPos = await _determinePosition();
    //to can use context
    if (!mounted) return;
    for (var element in shopsList) {
      if (currentPos.latitude == element.lat && currentPos.longitude == element.lng) if (true) {
        Alert(
            context: context,
            type: AlertType.success,
            title: 'انت الان داخل سوق  ......',
            content: MyTexts.content(
                title:
                    'من دخل السوق فقال لا إله إلا الله وحده لا شريك له له الملك وله الحمد يحيي ويميت وهو حي لا يموت بيده الخير وهو على كل شيء قدير كتب الله له ألف ألف حسنة ومحا عنه ألف ألف سيئة ورفع له ألف ألف درجة.'),
            buttons: [
              DialogButton(
                onPressed: () => Get.back(),
                color: MyColors.primary(),
                child: MyTexts.content(title: 'تم'),
              )
            ],
            style: AlertStyle(
              backgroundColor: MyColors.background(),
              titleStyle: Theme.of(context).textTheme.headline1!,
            )).show();
      }
    }
  }

  void updateDb(List<ShopProps> shopMapList) {
    List<Map> mapList = [];
    for (var element in shopMapList) mapList.add(element.toMap());
    getStorage.write('shops', mapList);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  showAddShopDialog() async {
    _shopCtr.clear();
    bool isLocationReady = false;
    bool isLoading = false;

    await Alert(
        context: context,
        type: AlertType.info,
        title: 'اضافة سوق جديد',
        content: StatefulBuilder(builder: (context, dialogSetState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTexts.content(title: 'ادخل اسم السوق'),
              SizedBox(height: 10),
              TextField(
                maxLength: 18,
                textAlign: TextAlign.right,
                controller: _shopCtr,
                style: TextStyle(color: MyColors.whiteBlack()),
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), hintText: 'اسم السوق : ', hintStyle: TextStyle(fontSize: 14)),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () async {
                      isLoading = true;
                      dialogSetState(() {});
                      pos = await _determinePosition();
                      isLocationReady = true;
                      isLoading = false;
                      dialogSetState(() {});
                    },
                    child: MyTexts.content(title: 'اجلب موقعك الحالي'),
                  ),
                  isLoading
                      ? MyCircularProgressIndecator()
                      : isLocationReady
                          ? MyIcons.done()
                          : MyIcons.error,
                ],
              )
            ],
          );
        }),
        buttons: [
          DialogButton(
            onPressed: () => Get.back(),
            color: Colors.transparent,
            child: Text("الغاء",
                style: TextStyle(
                  color: MyColors.primary(),
                )),
          ),
          DialogButton(
            onPressed: () {
              // check the shop name is not empty
              if (_shopCtr.text.isEmpty) {
                Get.snackbar('حدث خطأ اثناء جلب البيانات', 'تاكد من ادخال اسم السوق !!!',
                    backgroundColor: MyColors.background(),
                    colorText: MyColors.whiteBlack(),
                    icon: MyIcons.error,
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }
              //sheck if shop name math with other shops
              if (shopsList.any((element) => element.shopName == _shopCtr.text)) {
                Get.snackbar('حدث خطأ اثناء جلب البيانات', 'اسم السوق موجود بالفعل !!!',
                    backgroundColor: MyColors.background(),
                    colorText: MyColors.whiteBlack(),
                    icon: MyIcons.error,
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }
              //check if all required data is ready
              if (!isLocationReady) {
                Get.snackbar('حدث خطأ اثناء جلب البيانات', 'تاكد من جلب موقعك الحالي !!!',
                    backgroundColor: MyColors.background(),
                    colorText: MyColors.whiteBlack(),
                    icon: MyIcons.error,
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }

              _addLocation();
            },
            color: MyColors.primary(),
            child: Text("تأكيد", style: TextStyle(color: Colors.white)),
          ),
        ],
        style: AlertStyle(
          alertAlignment: Alignment.center,
          alertElevation: 0,
          titleTextAlign: TextAlign.right,
          backgroundColor: MyColors.background(),
          titleStyle: Theme.of(context).textTheme.headline1!,
          descStyle: TextStyle(
            color: MyColors.whiteBlack(),
            fontSize: 14,
          ),
        )).show();
  }
}
