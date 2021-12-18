import 'dart:convert';

import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/values/string.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/history_order_screen.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:logger/logger.dart';
import 'app_get_cart.dart';
import 'app_get_user.dart';
import 'helper/s_helpar.dart';

class ServerUser {
  ServerUser._();
  static ServerUser serverUser = ServerUser._();

  Dio dio;
  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  AppGetUser appGet = getx.Get.find();
  Logger logger = Logger();
  GetCart getCart = getx.Get.find();

  Future<String> getAppUser() async {
    String token = await SHelper.sHelper.getValue('access_token');
    appGet.setToken(token);
    return token;
  }

  getAllVaraibles() async {
    // Fcm.fcm.getUserToken();

    await getAppUser();
    if (getAppUser() != null) {
      getUser();

      getSliders();
      getMaxCenterRated();
      getProductCategories();
      getMyOrder();
      getMyBookings();
      getArchiveVisits();
      getMyNotification();
      getTopRated();
      getMyFavorites();
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getCities() async {
    try {
      await initApi();

      Response response = await dio.get(
        baseUrl + "user/getCities",
      );
      Map map = response.data;
      appGet.getCities(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getUser() async {
    try {
      await initApi();

      Response response = await dio.get(baseUrl + "user",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.getUser(map);
      logger.e(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getArchiveVisits() async {
    try {
      await initApi();

      Response response = await dio.get(baseUrl + "appointments/archive_visits",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.getArchiveVisits(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingDetails(int bookingId) async {
    try {
      await initApi();

      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(
          baseUrl + "appointments/booking_details",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.getBookingDetails(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingcCancel(int bookingId) async {
    try {
      await initApi();
      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(
          baseUrl + "appointments/booking_cancel",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      //  appGet.getBookingcCancel(map);
      print(map);

      getMyBookings();
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getMyBookings() async {
    try {
      await initApi();

      Response response = await dio.get(baseUrl + "appointments/my_bookings",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      print(map);

      appGet.getMyBookings(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getCategories() async {
    try {
      await initApi();

      Response response = await dio.get(
        baseUrl + "data/getCategories",
      );
      Map map = response.data;
      appGet.getCategories(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getSliders() async {
    try {
      await initApi();

      Response response = await dio.get(baseUrl + "data/getSliders",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.getSliders(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getMaxCenterRated() async {
    try {
      await initApi();

      Response response = await dio.get(baseUrl + "data/get_max_center_rated",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.setCenterFilter(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getMyNotification() async {
    try {
      await initApi();

      Response response = await dio.get(
          baseUrl + "notification/get_my_notification",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      if (await SHelper.sHelper.getCountNotification() == null) {
        await SHelper.sHelper.setCountNotification(0);
      }
      print(await SHelper.sHelper.getCountNotification());
      print(map['data'].length);
      int s = map['data'].length - await SHelper.sHelper.getCountNotification();
      appGet.setNotificationCounter(s);
      appGet.getMyNotification(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> setCenterFilter(int categoryId, int cityId) async {
    try {
      await initApi();
      FormData data = FormData.fromMap(
        {
          'category_id': categoryId,
          'city_id': cityId,
        },
      );
      Response response = await dio.post(baseUrl + "center/filter",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.setCenterFilter(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> setCenterById(int centerId) async {
    try {
      await initApi();
      FormData data = FormData.fromMap(
        {
          'center_id': centerId,
        },
      );
      Response response = await dio.post(baseUrl + "center/get_center_by_id",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.setCenterById(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> setHoursAvailableInDate(
      int centerId, String appointmentDate) async {
    try {
      await initApi();
      FormData data = FormData.fromMap(
        {
          'center_id': centerId,
          'appointment_date': appointmentDate,
        },
      );

      Response response = await dio.post(
          baseUrl + "center/hours_available_in_date",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      appGet.setHoursAvailableInDate(map);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> setContactUs(
      String name, String mobile, String title, String body) async {
    try {
      await initApi();
      FormData data = FormData.fromMap(
        {
          'name': name,
          'mobile': mobile,
          'title': title,
          'body': body,
        },
      );

      Response response = await dio.post(baseUrl + "contact_us/send_message",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map map = response.data;
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////
  Future getAddAppointment(
    int centerId,
    String date,
    String time,
    int paymentMethod,
    int type,
    List<int> serviceList,
  ) async {
    //appGet.pr.show();
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      FormData data = FormData.fromMap({
        'center_id': centerId,
        'date': date,
        'time': time,
        'service_list': "$serviceList",
        'type': type,
        'payment_method': paymentMethod,
      });

      Response response =
          await dio.post(baseUrl + "appointments/add_appointment", data: data);
      //appGet.pr.hide();
      // appGet.isLoading(false);
      print(response);

      getMyBookings();
      return response.data;
    } catch (e) {
      //appGet.pr.hide();
      // appGet.isLoading(false);

      return null;
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getTrader(String traderId) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(baseUrl + "traders/trader_by_id",
          data: {"trader_id": traderId});

      Map<String, dynamic> map = response.data;
      appGet.getTrader(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getTraderCategory(int traderId) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(
          baseUrl + "traders/trader_product_category",
          data: {"trader_id": traderId});

      Map<String, dynamic> map = response.data;
      appGet.getTraderCategory(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getShopMain(int categoryId) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(
          baseUrl + "shop/product_by_category_id",
          data: {'category_id': categoryId});

      Map<String, dynamic> map = response.data;
      appGet.getTopRated(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getProduct(int productId) async {
    dio = initApi();
    print(productId);
    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(baseUrl + "shop/product_by_id",
          data: {"product_id": productId});

      Map<String, dynamic> map = response.data;
      appGet.getProduct(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getTraderProductCategory(int traderId, int categoryId) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(
          baseUrl + "traders/trader_product_by_category_id",
          data: {"trader_id": traderId, "category_id": categoryId});

      Map<String, dynamic> map = response.data;
      appGet.getTraderProductCategory(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getTopRated() async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.get(baseUrl + "shop/get_top_rated");
      print(response.data);
      Map<String, dynamic> map = response.data;
      appGet.getTopRated(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getProductCategories() async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.get(baseUrl + "shop/product_categories");

      Map<String, dynamic> map = response.data;
      appGet.getProductCategories(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getMyOrder() async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.get(
        baseUrl + "orders/my_order",
      );

      Map<String, dynamic> map = response.data;
      appGet.getMyOrder(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getOrderId(String orderId) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.post(baseUrl + "orders/get_order_by_id",
          data: {"order_no": orderId});

      Map<String, dynamic> map = response.data;
      appGet.getOrderId(map);
      logger.e(map);
      //appGet.pr.hide();
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////
  Future<Map> getAddOrder({List products}) async {
    dio = initApi();
    FormData data = FormData.fromMap({"product_list": json.encode(products)});
    logger.e(products);

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";
      appGet.pr.show();

      Response response =
          await dio.post(baseUrl + "orders/add_order", data: data);
      appGet.pr.hide();

      Map<String, dynamic> map = response.data;
      getCart.deleteAllProduct();
      getMyOrder();
      setToast("Your request has been sent successfully".tr);

      getx.Get.off(HistoryScreen());
      logger.e(map);
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }
///////////////////////////////////////////////////////////////////

  Future getSearch(
    String search,
    String type,
    String sort,
  ) async {
    appGet.pr.show();

    try {
      print(sort);
      dio = initApi();
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";
      FormData data = FormData.fromMap({
        "keyword": search,
        "type": type,
        "sort": sort == "" ? '' : sort.toString().substring(11),
        //sort==""?'':sort.toString().substring(11),
      });

      Response response = await dio.post(baseUrl + 'user/search', data: data);

      Map<String, dynamic> map = response.data;
      print(map);
      appGet.getSearch(map);
      // logger.e(allDentalClinicsModel.toJson());
      appGet.pr.hide();

      return map;
    } catch (e) {
      appGet.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getMyFavorites() async {
    //appGet.pr.show();
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";

      Response response = await dio.get(baseUrl + "my_favorites");
      Map<String, dynamic> map = response.data;

      appGet.getMyFavorites(map);
      logger.e(map);

      return map;
    } catch (e) {
      //appGet.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getDeleteMyFavorites(int centerId) async {
    //appGet.pr.show();
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGet.token}";
      FormData data = FormData.fromMap(
        {
          'center_id': centerId,
        },
      );
      Response response = await dio
          .post(baseUrl + "my_favorites/delete_from_favorite", data: data);
      Map<String, dynamic> map = response.data;

      getMyFavorites();
      logger.e(map);
      //appGet.pr.hide();

      return map;
    } catch (e) {
      //appGet.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }
}
