

// import 'package:belleza/feature/server/model/message_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FireBaseHelper {
//   FireBaseHelper._();

//   static FireBaseHelper fireBaseHelper = FireBaseHelper._();
//   // FirebaseFirestore firestore = FirebaseFirestore.instance;

//   newMessage({MessageModel message, String senderId, String reciverId}) async {
//     firestore.collection('Chats').doc('${reciverId + senderId}').set({
//       "users": [senderId, reciverId],
//     });
//     firestore
//         .collection('Chats')
//         .doc('${reciverId + senderId}')
//         .collection('Messages')
//         .add(message.toJson());
//   }

//   Future<List<Map<String, dynamic>>> getAllMyChats({String myId}) async {
//     QuerySnapshot querySnapshot = await firestore
//         .collection('Chats')
//         .where('users', arrayContains: myId)
//         .get();

//     List<Map<String, dynamic>> mapUsers = [];
//     for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
//       Map<String, dynamic> data = queryDocumentSnapshot.data();
//       Map<String, dynamic> dataUser = {};

//       List users = data['users'];
//       String otherId = users.where((element) => element != myId).toList().first;
//       print(otherId);
//       Map map = await getUserInformation(otherId);
//       dataUser['mobile'] = otherId;
//       dataUser['usersInfo'] = map;
//       mapUsers.add(dataUser);
//     }
//     print(mapUsers);
//     return mapUsers;
//   }

//   // Future<List<Map<String, dynamic>>> getAllMyChatsProduct(
//   //     {String myId}) async {}

//   Future<Map> getUserInformation(String id) async {
//     DocumentSnapshot documentSnapshot =
//         await firestore.collection('Users').doc(id).get();
//     return documentSnapshot.data();
//   }

//   Stream<QuerySnapshot> getAllChatMessages(String reciverId, String senderId) {
//     Stream<QuerySnapshot> stream = FirebaseFirestore.instance
//         .collection('Chats')
//         .doc('${reciverId + senderId}')
//         .collection('Messages')
//         .orderBy('timeStamp')
//         .snapshots();

//     print(stream);
//     return stream;
//   }

  
// }
