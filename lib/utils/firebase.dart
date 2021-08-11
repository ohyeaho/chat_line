import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  static Future<void> addUser() async {
    try {
      final userRef = await _firestoreInstance.collection('user').add({
        'name': '名無し',
        'image_path':
            'https://3.bp.blogspot.com/-vk0LMKh8FAE/WI1zWAowOQI/AAAAAAABBYE/Uc2w7rK1-dgHzghomKwHoXNVJ-evy67WgCLcB/s800/yokokara_shitsurei.png',
      });
      print('アカウント作成完了');
    } catch (e) {
      print('アカウント作成失敗 --- $e');
    }
  }

  static Future<void> getUser() async {
    try {
      final snapshot = await _firestoreInstance.collection('user').get();
      snapshot.docs.forEach((user) {
        print('ドキュメントID: ${user.id} --- 名前: ${user.data()['name']}');
      });
    } catch (e) {
      print('取得失敗 --- $e');
    }
  }
}
