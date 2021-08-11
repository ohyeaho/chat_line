import 'package:flutter/material.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  _SettingsProfileState createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 100, child: Text('名前')),
                Expanded(child: TextField()),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 100, child: Text('サムネイル')),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('画像を選択'),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
