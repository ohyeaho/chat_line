import 'package:flutter/material.dart';
import 'package:line_chat/model/user.dart';
import 'package:line_chat/pages/settings_profile.dart';
import 'package:line_chat/pages/talk_room.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: '田中',
      uid: 'abc',
      imagePath: 'https://3.bp.blogspot.com/-vk0LMKh8FAE/WI1zWAowOQI/AAAAAAABBYE/Uc2w7rK1-dgHzghomKwHoXNVJ-evy67WgCLcB/s800/yokokara_shitsurei.png',
      lastMessage: 'こんにちは',
    ),
    User(
      name: '小林',
      uid: 'def',
      imagePath:
          'https://4.bp.blogspot.com/-xN3OofpDu2A/XAnvN3Vpj-I/AAAAAAABQmA/guSSixGZ6cYFey2lgEUnc5q3mEUj6quOACLcBGAs/s800/business_man1_1_smile.png',
      lastMessage: 'ありがとう',
    ),
  ];

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
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoom(userList[index].name)));
            },
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userList[index].imagePath),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userList[index].name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(userList[index].lastMessage, style: const TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
