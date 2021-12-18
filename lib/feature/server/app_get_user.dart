import 'dart:io';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/view/widgets/ProgressDialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'helper/s_helpar.dart';

class AppGetUser extends GetxController {
  var language = "en".obs;

  var acceptTerms = false.obs;

  // GlobalKey<ConvexAppBarState> convexKey = GlobalKey();

  int indexNav = 0;
  var totalPrice = 0.obs;
  String token;
  var data = "0".obs;
  String fcmToken = '';
  String mobileNumber;
  String email;
  String googleAuth;
  String name;
  String photoSocial;
  int code;
  int type;
  bool isFromDynamic = false;
  int notificationCounter = 0;

  var pr = ProgressDialogUtils.createProgressDialog(Get.context);

  var allCategories = [];
  List<int> allIdCategories = [];
  var categories = {}.obs;
  var productCategories = {}.obs;
  var myBookings = {}.obs;
  var archiveVisits = {}.obs;
  var nearOsra = {}.obs;
  var subcategories = {}.obs;
  var slider = {}.obs;
  var trader = {}.obs;
  var traderCategory = {}.obs;
  var traderProductCategory = {}.obs;
  var favoriteModel = {}.obs;
  var maxCenterRated = {}.obs;
  var bookingCancel = {}.obs;
  var bookingDetails = {}.obs;
  var centerFilter = {}.obs;
  var centerById = {}.obs;
  var hoursAvailableInDate = {}.obs;
  var product = {}.obs;
  var userProfil = {}.obs;
  var topRated = {}.obs;
  var search = {}.obs;
  var myOrder = {}.obs;
  var orderId = {}.obs;
  var productIsLoading = false.obs;
  var totalQuantity = 0.obs;
  var totalNotification = 0.obs;
  var totalCartPrice = 0.obs;
  var isLoading = false.obs;
  var order = {}.obs;
  var cities = {}.obs;
  var cart = {}.obs;
  var fav = {}.obs;
  var resellers = {}.obs;
  var identificationImages = <File>[].obs;
  var regiserImages = <File>[].obs;
  var allOrders = {}.obs;
  var favouriteListResults = [].obs;
  var notifiaction = {}.obs;
  var marktCategories = {}.obs;
  File imageFile;

  getCities(Map map) {
    this.cities.value = map;
  }

  getUser(Map map) {
    this.userProfil.value = map;
  }
 getLangCurrant() async {
    String lang = await SHelper.sHelper.getValue("Lang");
    if (lang == null) {
      this.language.value = "en";
    } else {
      this.language.value = lang;
    }
  }
  setNotificationCounter(int i) {
    this.notificationCounter = i;
  }

  changeAcceptTerms(bool value) {
    this.acceptTerms.value = value;
  }

  getMyOrder(Map map) {
    this.myOrder.value = map;
  }

  getOrderId(Map map) {
    this.orderId.value = map;
  }

  getMyNotification(Map map) {
    this.notifiaction.value = map;
  }

  setFavSearchResult(List list) {
    this.favouriteListResults.value = list;
  }

  setOrders(Map map) {
    this.allOrders.value = map;
  }

  getBookingcCancel(Map map) {
    this.bookingCancel.value = map;
  }

  getBookingDetails(Map map) {
    this.bookingDetails.value = map;
  }

  setResellers(Map map) {
    this.resellers.value = map;
  }

  setCart(Map map) {
    this.cart.value = map;
  }

  setindexNav(indexNav) {
    this.indexNav = indexNav;
    update();
  }

  setAllCategories(int index, int id) {
    if (allIdCategories.contains(id)) {
    } else {
      // this.allCategories.add(index);
      this.allIdCategories.add(id);
      update();
    }
  }

  getTrader(Map map) {
    this.trader.value = map;
  }

  getTraderCategory(Map map) {
    this.traderCategory.value = map;
  }

  getTraderProductCategory(Map map) {
    this.traderProductCategory.value = map;
  }

  removeAllCategories(int index, int id) {
    print(id);
    // int indexnew = this.allCategories.indexOf(index);
    int idCategories = this.allIdCategories.indexOf(id);
    // this.allCategories.removeAt(indexnew);
    // print(idCategories);
    // if (idCategories == 0) {
    //   this.allIdCategories.clear();
    // } else {
    this.allIdCategories.removeAt(idCategories);
    // }
    update();
  }

  setOrder(Map map) {
    this.order = map;
  }

  toggleFav() {
    product['data']['favorit_status'] = !product['data']['favorit_status'];
    update(['fav']);
  }

  setCenterFilter(Map map) {
    this.centerFilter.value = map;
  }

  getProductCategories(Map map) {
    this.productCategories.value = map;
  }

  setCenterById(Map map) {
    this.centerById.value = map;
  }
setTotalePrice(int price){
 this.totalPrice.value=this.totalPrice.value+price;

}
  setHoursAvailableInDate(Map map) {
    this.hoursAvailableInDate.value = map;
  }

  getMaxCenterRated(Map map) {
    this.maxCenterRated.value = map;
    print(map);
  }

  getCategories(Map map) {
    this.categories.value = map;
  }

  getMyBookings(Map map) {
    this.myBookings.value = map;
  }

  getSearch(Map map) {
    this.search.value = map;
  }

  getArchiveVisits(Map map) {
    this.archiveVisits.value = map;
  }

  getMyFavorites(Map map) async {
    this.favoriteModel.value = map;
  }

  getSliders(Map map) {
    this.slider.value = map;
  }

  setToken(String token) {
    this.token = token;
  }

  setData(String data) {
    this.data.value = data;
  }

  setCode(int code) {
    this.code = code;
  }

  getShopMain(Map map) {
    this.marktCategories.value = map;
  }

  getProduct(Map map) {
    this.product.value = map;
  }

  getTopRated(Map map) {
    this.topRated.value = map;
  }

   Future getImage(ImageSource source) async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: source, imageQuality: 20);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      ServerAuth.serverAuth.editPhotoProfileSalon(userProfil['data']['name'],imageFile.path);
      update();
    } else {
      imageFile = null;
    }
  }
}
