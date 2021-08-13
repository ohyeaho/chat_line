import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_chat/model/message.dart';
import 'package:line_chat/model/talk_room.dart';
import 'package:line_chat/pages/settings_profile.dart';
import 'package:line_chat/pages/talk_room.dart';
import 'package:line_chat/utils/firebase.dart';
import 'package:line_chat/utils/shared_prefs.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<TalkRoom> talkUserList = [];

  Future<void> createRooms() async {
    String? myUid = SharedPrefs.getUid();
    talkUserList = await Firestore.getRooms(myUid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャットアプリ'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsProfile()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.roomSnapshot,
          builder: (context, snapshot) {
            return FutureBuilder(
              future: createRooms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: talkUserList.length,
                    itemBuilder: (context, index) {
                      // DateTime roomTime = Message().sendTime!.toDate();
                      return InkWell(
                        onTap: () {
                          print(talkUserList[index].roomId);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoomPage(talkUserList[index])));
                        },
                        child: SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(talkUserList[index].talkUser!.imagePath),
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(talkUserList[index].talkUser!.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text(talkUserList[index].lastMessage, style: const TextStyle(color: Colors.grey)),
                                    ],
                                  )
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8.0),
                              //   child: (TalkRoom().lastMessage != null)
                              //       ? Text(DateFormat('HH:mm').format(Message().sendTime!.toDate()), style: const TextStyle(color: Colors.grey))
                              //       : Container(),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
    );
  }
}
