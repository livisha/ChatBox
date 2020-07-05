
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUserName(String username) async {
return await Firestore.instance.collection("users")
    .where("name",isEqualTo: username).getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection("users")
        .where("email",isEqualTo: userEmail).getDocuments();
  }


  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }
  
  createChatRoom(String chatRoomID, chatRoomMap){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomID).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
addConversationMessage(String chatRoomID,messageMap){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomID).collection("chats").add(messageMap)
        .catchError((e){print(e.toString());});
}

  getConversationMessage(String chatRoomID)async{
    return await Firestore.instance.collection("chatRoom")
        .document(chatRoomID).collection("chats")
    .orderBy("time",descending:false )
        .snapshots();}

        getChatRooms(String userName)async{
    return await Firestore.instance.collection("chatRoom")
        .where("users",arrayContains:userName)
       .snapshots();
        }

  }


