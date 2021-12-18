
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/values/string.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:logger/logger.dart';
import 'app_get_salon.dart';

class ServerSalon {
  ServerSalon._();
  static ServerSalon serverSalon = ServerSalon._();
  Dio dio;
  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  AppGetSalon appGetSalon = getx.Get.find();
  Logger logger = Logger();

  Future<String> getAppUser() async {
    String token = await SHelper.sHelper.getValue('access_token');
    appGetSalon.setToken(token);
    return token;
  }

  getAllVaraibles() async {
    // Fcm.fcm.getUserToken();

    await getAppUser();
    if (getAppUser() != null) {
      getUserSalon();
      getSlidersSalon();
      getMyServices();
      getMyBookingsSalon();
      getArchiveVisitsSalon();
      getMyNotificationSalon();
      
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getUserSalon() async {
    dio = initApi();

    try {
      Response response = await dio.get(baseSalonUrl + "user",
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));

      appGetSalon.getSalon(response.data);
      print(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getArchiveVisitsSalon() async {
    dio = initApi();

    try {
      Response response = await dio.get(
          baseSalonUrl + "appointments/archive_visits",
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      appGetSalon.getArchiveVisits(response.data);
      print(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingAccept(int bookingId) async {
    dio = initApi();

    try {
      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(
          baseSalonUrl + "appointments/booking_accept",
          data: data,
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      // appGetSalon.getBookingDetails(response.data);
      print(response.data);
       await getArchiveVisitsSalon();
      appGetSalon.pr.hide();
      setToast(response.data['message_ar']);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingDetailsSalon(int bookingId) async {
    dio = initApi();

    try {
      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(
          baseSalonUrl + "appointments/booking_details",
          data: data,
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      appGetSalon.getBookingDetails(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingcCancelSalon(int bookingId) async {
    dio = initApi();
    appGetSalon.pr.show();

    try {
      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(
          baseSalonUrl + "appointments/booking_cancel",
          data: data,
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      await getMyBookingsSalon();
      appGetSalon.pr.hide();
      setToast(response.data['message_ar']);
      return response.data;
    } catch (e) {
      appGetSalon.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getMyBookingsSalon() async {
    dio = initApi();

    try {
      Response response = await dio.get(
          baseSalonUrl + "appointments/my_bookings",
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      appGetSalon.getMyBookings(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getSlidersSalon() async {
    dio = initApi();

    try {
      Response response = await dio.get(baseSalonUrl + "data/getSliders",
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      Map map = response.data;
      appGetSalon.getSliders(map);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getMyNotificationSalon() async {
    dio = initApi();
print("Authorization");
    try {
      Response response = await dio.get(
          baseSalonUrl + "notification/get_my_notification",
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      Map map = response.data;
      print(map);
      
      if(await SHelper.sHelper.getCountNotification()==null){
        await SHelper.sHelper.setCountNotification(0);
      }
      print(await SHelper.sHelper.getCountNotification());
// print(map['data'].length);
        int s = map['data'].length - await SHelper.sHelper.getCountNotification();
    appGetSalon.setNotificationCounter(s);
      appGetSalon.getMyNotification(map);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

////////////////////////////////////////////////////////////////////////////
  Future getAddAppointmentSalon(
    int centerId,
    String date,
    String time,
    int paymentMethod,
    int type,
    List<int> serviceList,
  ) async {
    dio = initApi();

    try {
      dio.options.headers["authorization"] = "Bearer ${appGetSalon.token}";

      FormData data = FormData.fromMap({
        'center_id': centerId,
        'date': date,
        'time': time,
        'service_list': serviceList.toString(),
        'type': type,
        'payment_method': paymentMethod,
      });

      Response response = await dio
          .post(baseSalonUrl + "appointments/add_appointment", data: data);

      print(response);
      getMyBookingsSalon();
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////////////////

  Future getSearchSalon(String search, String type) async {
    dio = initApi();

    try {
      dio = initApi();
      dio.options.headers["authorization"] = "Bearer ${appGetSalon.token}";
      FormData data = FormData.fromMap({
        "keyword": search,
        "type": type,
      });

      Response response =
          await dio.post(baseSalonUrl + 'user/search', data: data);

      Map<String, dynamic> map = response.data;

      appGetSalon.getSearch(map);

      return map;
    } catch (e) {
      appGetSalon.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getMyServices() async {
    dio = initApi();
    try {
      dio.options.headers["authorization"] = "Bearer ${appGetSalon.token}";
      Response response = await dio.get(
        baseSalonUrl + "my_services",
      );
      Map<String, dynamic> map = response.data;
      appGetSalon.setMyServices(map);
      logger.e(map);
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////
  Future<Map> setAddService(String title, String price,) async {
    dio = initApi();
print(title);
print(price);
    try {
      dio.options.headers["authorization"] = "Bearer ${appGetSalon.token}";
      FormData data = FormData.fromMap(
        {
          'title': title,
          'price': price,
          // 'photo': await MultipartFile.fromFile(photo,
          //     filename: photo.substring(photo.lastIndexOf('/') + 1)),
        },
      );
          appGetSalon.pr.show();

      Response response =
          await dio.post(baseSalonUrl + "my_services/add_service", data: data);
      appGetSalon.imageFile = null;
      await getMyServices();
      appGetSalon.pr.hide();
      return response.data;
    } catch (e) {
      appGetSalon.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

///////////////////////////////////////////////////////
  Future<Map> setEditService(String title, String price, int serviceId,
     ) async {
    dio = initApi();
    appGetSalon.pr.show();


    try {
      dio.options.headers["authorization"] = "Bearer ${appGetSalon.token}";
      FormData data = FormData.fromMap(
        {
          'title': title,
          'price': price,
          "service_id": serviceId,
          // 'photo': photo == null
          //     ? image
          //     : await MultipartFile.fromFile(photo.path,
          //         filename:
          //             photo.path.substring(photo.path.lastIndexOf('/') + 1)),
        },
      );
      Response response =
          await dio.post(baseSalonUrl + "my_services/edit_service", data: data);
      print(response.data);
      appGetSalon.imageFile = null;
      await getMyServices();
      appGetSalon.pr.hide();
      return response.data;
    } catch (e) {
      appGetSalon.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setDeleteService(int serviceId) async {
    dio = initApi();
    appGetSalon.pr.show();

    try {
      FormData data = FormData.fromMap({"service_id": serviceId});
      Response response = await dio.post(
          baseSalonUrl + "my_services/delete_service",
          data: data,
          options: Options(
              headers: {'Authorization': 'Bearer ${appGetSalon.token}'}));
      await getMyServices();

      appGetSalon.pr.hide();

      return response.data;
    } catch (e) {
      appGetSalon.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['problemInternet'.tr] ?? 'network_error'.tr, titleKey: 'network_error'.tr);
    }
  }

     ///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> setContactUs(
      String name, String mobile, String title, String body) async {

        print(name);
        print(mobile);
        print(title);
        print(body);
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

      Response response = await dio.post(baseSalonUrl + "contact_us/send_message",
          data: data,
          options: Options(headers: {
            'Authorization':
                'Bearer ${appGetSalon.token}'
          }));
      Map map = response.data;
      setToast(map['message_ar']);
      print(map);
      return response.data;
    } catch (e) {
      return null;
    }
  }

}
