import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:line_chat/model/message.dart';
import 'package:line_chat/model/talk_room.dart';
import 'package:line_chat/utils/firebase.dart';

class TalkRoomPage extends StatefulWidget {
  final TalkRoom room;
  TalkRoomPage(this.room);

  @override
  _TalkRoomPageState createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [];
  TextEditingController controller = TextEditingController();

  Future<void> getMessages() async {
    messageList = await Firestore.getMessages(widget.room.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(widget.room.talkUser!.name),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.messageSnapshot(widget.room.roomId),
                builder: (context, snapshot) {
                  return FutureBuilder(
                    future: getMessages(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: RangeMaintainingScrollPhysics(),
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          DateTime sendTime = messageList[index].sendTime!.toDate();
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: index == 0 ? 10 : 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textDirection: messageList[index].isMe! ? TextDirection.rtl : TextDirection.ltr,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: messageList[index].isMe! ? Colors.green : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(messageList[index].message!),
                                ),
                                Text(intl.DateFormat('HH:mm').format(sendTime), style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        await Firestore.sendMessage(widget.room.roomId, controller.text);
                        controller.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
