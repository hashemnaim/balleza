import 'dart:io';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/view/widgets/ProgressDialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppGetSalon extends GetxController {
  int indexNav = 0;
  String token;
  String fcmToken = '';
  String mobileNumber;
  String name;
  int code;
  int type;
    int cityId = 0;
    int notifiactionConter = 0;
  var nearOsra = {}.obs;

  var pr = ProgressDialogUtils.createProgressDialog(Get.context);
  var acceptTerms = false.obs;
  var services = {}.obs;
  var myBookings = {}.obs;
  var archiveVisits = {}.obs;
  var slider = {}.obs;
  var bookingDetails = {}.obs;
  var salonProfil = {}.obs;
  var search = {}.obs;
  var cities = {}.obs;
  var fav = {}.obs;
  var regiserImages = <File>[].obs;
  var notifiaction = {}.obs;
  File imageFile;

  getSalon(Map map) {
    this.salonProfil.value = map;
  }
 setNotificationCounter(int i) {
    this.notifiactionConter= i;
  }

  changeAcceptTerms(bool value) {
    this.acceptTerms.value = value;
  }

  setindexNav(indexNav) {
    this.indexNav = indexNav;
    update();
  }

  getMyNotification(Map map) {
    this.notifiaction.value = map;
  }

  getBookingDetails(Map map) {
    this.bookingDetails.value = map;
  }

  setMyServices(Map map) {
    this.services.value = map;
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

  getSliders(Map map) {
    this.slider.value = map;
  }

  setToken(String token) {
    this.token = token;
  } 
  setCityId(int cityId) {
    this.cityId = cityId;
    update();
  }

  Future getImage(ImageSource source) async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: source, imageQuality: 20);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      ServerAuth.serverAuth.editPhotoProfileSalon(salonProfil['data']['name'],imageFile.path);
      update();
    } else {
      imageFile = null;
    }
  }
}
