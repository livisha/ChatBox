import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/search.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'conversation_Screen.dart';
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream:chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData?ListView.builder(itemCount: snapshot.data.documents
            .length,itemBuilder:(context,index){
          return chatRoomsTile(
            snapshot.data.documents[index].data["chatroomId"]
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myName,""),
              snapshot.data.documents[index].data["chatroomId"]
          );
        }): Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo()async{
    Constants.myName=await HelperFunction.getuserNameSharedPreference();
      databaseMethods.getChatRooms(Constants.myName).then((value){
        setState(() {
          chatRoomStream=value;
        });
      });
      setState(() {
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor:Colors.blue.shade800,
          title: Text(
            'ChatBook',
          ),
         actions:[
           GestureDetector(
             onTap:(){
               authMethods.signOut();
               Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) => Authenticate()
               ));
             },

           child:Container(
             color: Colors.black26,
             padding:EdgeInsets.symmetric(horizontal: 16) ,
               child: Icon(Icons.exit_to_app))
           ),
         ],
        ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>SearchScreen(),
          ));
        },
      ),
    );
  }
}
// ignore: camel_case_types
class chatRoomsTile  extends StatelessWidget {
  final String userName;
  final String chatroomId;
  chatRoomsTile(this.userName,this.chatroomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=>ConversationScreen(chatroomId)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
            width: 40,
            alignment:Alignment.center,
            decoration:BoxDecoration(
              color:Colors.blue,
              borderRadius: BorderRadius.circular(40)
            ),
              child: Text("${userName.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(width: 8),
            Text(userName,style:mediumTextStyle() ,)
          ],
        ),
      ),
    );
  }
}
