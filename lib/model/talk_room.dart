import 'package:line_chat/model/user.dart';

class TalkRoom {
  String roomId;
  User? talkUser;
  String lastMessage;
  // Timestamp? roomTime;

  TalkRoom({
    this.roomId = '',
    this.talkUser,
    this.lastMessage = '',
    // this.roomTime,
  });
}
