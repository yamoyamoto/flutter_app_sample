import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ChatMessageModel extends StatelessWidget {
  final String avatarUrl; //ユーザのアイコンURL
  final String name; //名前
  final String datetime; //メッセージの日時
  final String message; //メッセージ本文

  ChatMessageModel(this.name, this.datetime, this.message, this.avatarUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(message),
        subtitle: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 10.0,
            ),
            Text(
              datetime,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMessageArea extends StatelessWidget {
  BottomMessageArea({
    super.key,
    required this.onPressed,
  });

  final Function(ChatMessageModel) onPressed;
  final valueController = TextEditingController();

  void sendMessage() {
    final messageWid = ChatMessageModel(
        "yamoyamoto",
        "now",
        valueController.text,
        "https://user-images.githubusercontent.com/68677002/177938648-6afb1c7d-a473-42f3-a6a0-b54dd0da7bee.png");
    onPressed(messageWid);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: valueController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            decoration: const InputDecoration(
              hintText: 'メッセージを入力してください!',
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send),
            ))
      ],
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<ChatMessageModel> messages = [];

  void _add(ChatMessageModel message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<ChatMessageModel> messageData = [
    ChatMessageModel("yamoto", "2022-01-01 00:00:00", "Hello!",
        "https://user-images.githubusercontent.com/68677002/177938648-6afb1c7d-a473-42f3-a6a0-b54dd0da7bee.png"),
    ChatMessageModel("yamoto", "2022-01-01 10:00:00", "Hoge!",
        "https://user-images.githubusercontent.com/68677002/177938648-6afb1c7d-a473-42f3-a6a0-b54dd0da7bee.png"),
  ];

  void _addMessage(ChatMessageModel message) {
    setState(() {
      messageData.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ListView(children: messageData),
            BottomMessageArea(
              onPressed: _addMessage,
            ),
          ],
        ),
      ),
    );
  }
}
