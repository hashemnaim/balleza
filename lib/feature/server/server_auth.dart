import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/values/string.dart';
import 'package:belleza/feature/view/Screen_Salon/main_salon_screen.dart';
import 'package:belleza/feature/view/Screen_User/main_user_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:logger/logger.dart';
import 'server_user.dart';
import 'app_get_user.dart';
import 'helper/s_helpar.dart';

class ServerAuth {
  ServerAuth._();
  static ServerAuth serverAuth = ServerAuth._();
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

/////////////////////////////////////////////////////////////////////////////////////

  Future<Map> registerUser(String name, String mobile, String password,
      String fcmToken, String address, int city, String email) async {
    await initApi();
    print(fcmToken);
    print(address);
    print(city);
    print(email);
    print(mobile);
    print(password);

    String mobileNumber;
    if (mobile[0] == '0') {
      mobileNumber = mobile.substring(1);
      print(mobileNumber);
    } else {
      mobileNumber = mobile;
      print(mobileNumber);
    }
    // try {
    FormData data = FormData.fromMap(
      {
        'name': name,
        'mobile': '971' + mobileNumber,
        'password': password,
        'fcm_token': fcmToken,
        'address': address,
        'city': city,
        'email': email,
      },
    );
    appGet.pr.show();
    Response response = await dio.post(
      baseUrl + "user/register",
      data: data,
    );
    print(response.data);

    Map map = response.data;
    if (map['code'] == 422) {
      appGet.pr.hide();

      getx.Get.snackbar(map['errors']['mobile'][0], "");
    } else {
      await SHelper.sHelper
          .addNew("access_token", response.data['accessToken']['access_token']);
      appGet.pr.hide();
      getx.Get.snackbar("Registered successfully".tr, "");

      ServerUser.serverUser.getAllVaraibles();
      getx.Get.offAll(() => MainUserScreen());
    }
    return response.data;
    // } catch (e) {
    //   appGet.pr.hide();

    //   return null;
    // }
  }

/////////////////////////////////////////////////////////////////////////////////////

  Future<Map> registerSalon(
      String name,
      String mobile,
      String password,
      String fcmToken,
      String address,
      int city,
      String email,
      String openTime,
      String closeTime) async {
    await initApi();

    try {
      FormData data = FormData.fromMap(
        {
          'name': name,
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
          'address': address,
          'city': city,
          'email': email,
          'open_time': openTime,
          'close_time': closeTime,
        },
      );
      appGet.pr.show();
      Response response = await dio.post(
        baseSalonUrl + "user/register",
        data: data,
      );

      Map map = response.data;
      print(map);
      if (map['code'] == 422) {
        appGet.pr.hide();

        getx.Get.snackbar(map['errors']['mobile'][0], "");
      } else {
        await SHelper.sHelper
            .addNew("access_token", map['accessToken']['access_token']);
        appGet.pr.hide();
        getx.Get.snackbar("Registered successfully".tr, "");

        ServerSalon.serverSalon.getAllVaraibles();
        getx.Get.offAll(() => MainSalonScreen());
      }
      return response.data;
    } catch (e) {
      appGet.pr.hide();

      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////

  Future<Map> loginUser(String mobile, String password, String fcmToken) async {
    await initApi();
    print(mobile);
    print(password);
    print(fcmToken);
    try {
      FormData data = FormData.fromMap(
        {
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
        },
      );
      appGet.pr.show();
      Response response = await dio.post(
        baseUrl + "user/login",
        data: data,
      );
      Map map = response.data;
      if (map['code'] == 422) {
        appGet.pr.hide();

        getx.Get.snackbar(map['errors']['mobile'][0], "");
      } else {
        await SHelper.sHelper
            .addNew("access_token", map['accessToken']['access_token']);
        appGet.pr.hide();
        ServerUser.serverUser.getAllVaraibles();
        getx.Get.offAll(() => MainUserScreen());
      }
      return response.data;
    } catch (e) {
      appGet.pr.hide();

      return null;
    }
  }
/////////////////////////////////////////////////////////////////////////////////////

  Future<Map> loginSalon(
      String mobile, String password, String fcmToken) async {
    await initApi();

    try {
      FormData data = FormData.fromMap(
        {
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
        },
      );
      appGet.pr.show();
      Response response = await dio.post(
        baseSalonUrl + "user/login",
        data: data,
      );
      Map map = response.data;
      if (map['code'] == 422) {
        appGet.pr.hide();

        getx.Get.snackbar(map['errors']['mobile'][0], "");
      } else {
        await SHelper.sHelper
            .addNew("access_token", map['accessToken']['access_token']);
        appGet.pr.hide();
        ServerSalon.serverSalon.getAllVaraibles();

        getx.Get.offAll(() => MainSalonScreen());
      }
      return response.data;
    } catch (e) {
      appGet.pr.hide();

      return null;
    }
  }

// //////////////////////////////////////////////////////////////////////////////////
  Future<Map> resetPassword(String oldNo, String newNo) async {
    await initApi();
    FormData data = FormData.fromMap({
      'old_no': oldNo,
      'new_no': newNo,
    });
    Response response =
        await dio.post(baseUrl + "user/edit_mobile_no", data: data);
    return response.data;
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<Map> editProfile(
      String name, String mobile, String address, String email) async {
    await initApi();
    String token = await SHelper.sHelper.getValue('access_token');
    // try {
    FormData data = FormData.fromMap({
      'name': name,
      'mobile': mobile,
      'address': address,
      'email': email,
    });
    Response response = await dio.post(baseUrl + "user/update_profile",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    print(response.data);
    return response.data;
    // } catch (e) {
    //   appGet.pr.hide();

    //   return null;
    // }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> editProfileSalon(
      String name, String mobile, String address, String email) async {
    await initApi();
    String token = await SHelper.sHelper.getValue('access_token');
    // try {
    print(name);
    print(mobile);
    print(address);
    print(email);
    FormData data = FormData.fromMap({
      'name': name,
      'mobile': mobile,
      'address': address,
      'email': email,
    });
    Response response = await dio.post(baseSalonUrl + "user/update_profile",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    ServerSalon.serverSalon.getUserSalon();

    print(response.data);
    return response.data;
    // } catch (e) {
    //   appGet.pr.hide();

    //   return null;
    // }
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<Map> editPhotoProfile(String name, String photo) async {
    await initApi();
    String token = await SHelper.sHelper.getValue('access_token');

    try {
      FormData data = FormData.fromMap({
        'name': appGet,
        'logo': await MultipartFile.fromFile(photo,
            filename: photo.substring(photo.lastIndexOf('/') + 1)),
      });
      Response response = await dio.post(baseUrl + "user/update_profile",
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response.data);
      return response.data;
    } catch (e) {
      appGet.pr.hide();

      return null;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  Future<Map> editPhotoProfileSalon(String name, String photo) async {
    await initApi();
    String token = await SHelper.sHelper.getValue('access_token');
    // try {
    FormData data = FormData.fromMap({
      'name': appGet,
      'logo': await MultipartFile.fromFile(photo,
          filename: photo.substring(photo.lastIndexOf('/') + 1)),
    });
    Response response = await dio.post(baseSalonUrl + "user/update_profile",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    ServerSalon.serverSalon.getUserSalon();
    print(response.data);
    return response.data;
    // } catch (e) {
    //   appGet.pr.hide();

    //   return null;
    // }
  }

////////////////////////////////////////////////////////////
  Future<Map> editAddress(address, lat, long) async {
    try {
      await initApi();

      FormData data = FormData.fromMap({
        'address': address,
        'lat': lat,
        'long': long,
      });
      Response response =
          await dio.post(baseUrl + "user/edit_address", data: data);
      Logger().d(response.data);
      return response.data;
    } catch (e) {
      appGet.pr.hide();

      return null;
    }
  }

////////////////////////////////////////////
  Future<Map> verifyForgetPassword(String mobile) async {
    await initApi();
    FormData data = FormData.fromMap({
      "mobile": mobile,
    });

    Response response = await dio.post(
      baseUrl + "users/send_password",
      data: data,
    );
    print(response.data);
    return response.data;
  }

///////////////////////////////////////////////////////

// Future<Map> verification(String id, String verificationCode) async {
//   await initApi();
//   FormData data = FormData.fromMap({
//     "user_id": id,
//     "verification_code": verificationCode,
//   });

//   Response response = await dio.post(
//     baseUrl + verify_registration,
//     data: data,
//   );
//   print(response.data);
//   return response.data;
// }

//   ///////////////////////////////////////////////////////////////////////////////////////

//   Future<Map> socialMediaLogin(String socialId, String displayName,
//       String mobileNumber, String email, String type) async {
//     await initApi();
//     FormData data = FormData.fromMap({
//       "id": socialId,
//       "userName": 'hussein',
//       "displayName": displayName,
//       "mobileNumber": mobileNumber,
//       "email": email,
//       "type": type
//     });
//     Logger().d({
//       "id": socialId,
//       "userName": socialId,
//       "displayName": displayName,
//       "mobileNumber": mobileNumber,
//       "email": email,
//       "type": type
//     });
//     Response response = await dio.post(
//       baseUrl + register_by_social_media,
//       data: data,
//     );

//     Logger().d(response.data);
//     return response.data;
//   }
}
