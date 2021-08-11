import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:line_chat/model/message.dart';

class TalkRoom extends StatefulWidget {
  final String name;
  TalkRoom(this.name);

  @override
  _TalkRoomState createState() => _TalkRoomState();
}

class _TalkRoomState extends State<TalkRoom> {
  List<Message> messageList = [
    Message(
      message: 'あいうえお',
      isMe: true,
      sendTime: DateTime(2021, 1, 1, 10, 20),
    ),
    Message(
      message: 'かきくけこかきくけこかきくけこ',
      isMe: false,
      sendTime: DateTime(2021, 1, 1, 11, 15),
    ),
    Message(
      message: 'あいうえお',
      isMe: true,
      sendTime: DateTime(2021, 1, 1, 10, 20),
    ),
    Message(
      message: 'かきくけこかきくけこかきくけこ',
      isMe: false,
      sendTime: DateTime(2021, 1, 1, 11, 15),
    ),
    Message(
      message: 'あいうえお',
      isMe: true,
      sendTime: DateTime(2021, 1, 1, 10, 20),
    ),
    Message(
      message: 'かきくけこかきくけこかきくけこ',
      isMe: false,
      sendTime: DateTime(2021, 1, 1, 11, 15),
    ),
    Message(
      message:
          'あいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえお',
      isMe: true,
      sendTime: DateTime(2021, 1, 1, 10, 20),
    ),
    Message(
      message:
          'かきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこかきくけこ',
      isMe: false,
      sendTime: DateTime(2021, 1, 1, 11, 15),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: RangeMaintainingScrollPhysics(),
              itemCount: messageList.length,
              itemBuilder: (context, index) {
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
                      Text(
                        intl.DateFormat('HH:mm').format(messageList[index].sendTime!),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      print('送信');
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
