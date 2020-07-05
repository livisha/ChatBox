import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ConversationScreen extends StatefulWidget {
  final String chatRoomID;
  ConversationScreen(this.chatRoomID);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;

  // ignore: non_constant_identifier_names, missing_return
  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData?ListView.builder(itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return MessageTile(snapshot.data.documents[index]
                    .data["message"],
                    snapshot.data.documents[index]
                        .data["sendBy"]==Constants.myName,
                );
              }):Container();
        }
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time":DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessage(widget.chatRoomID, messageMap);
    messageController.text="";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessage(widget.chatRoomID)
        .then((value) {
setState(() {
  chatMessageStream=value;
});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: messageController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Message..",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/send.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile  extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right :isSendByMe?24:0,left:isSendByMe? 0:24),
      alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ]
                :
                [
                  const Color(0x1AFFFFFF),
                  const Color(0x1AFFFFFF)
                ],
          ),
          borderRadius: isSendByMe?
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23),
              ):
    BorderRadius.only(
    topLeft: Radius.circular(23),
    topRight: Radius.circular(23),
    bottomRight: Radius.circular(23),
        ),
        ),
        child: Text(message,style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),),
      ),
    );
  }
}
