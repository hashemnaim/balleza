import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'notification_handler.dart';


class FireBaseMassege extends StatefulWidget {
  @override
  _FireBaseMassegeState createState() => _FireBaseMassegeState();
}

class _FireBaseMassegeState extends State<FireBaseMassege> {
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    configureCallBake();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        
        
      ),
    );
  }

  void configureCallBake(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
          // ServerSalon.serverSalon. getMyNotificationSalon();

        NotificationHandler().showNotification(message['notification']['title'], message['notification']['body']);
        // print("onMessage: $message");
                
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        
                // NotificationHandler().showNotification(message['title'], message['body']);

      //  _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
     //   _navigateToItemDetail(message);
      },
    );
  }
}