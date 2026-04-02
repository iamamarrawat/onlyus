import 'package:flutter/material.dart';
import 'package:only_us/models/message.dart';
import 'package:only_us/services/socket_services.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({super.key, required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SocketService socketService = SocketService();
  final TextEditingController controller = TextEditingController();

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    socketService.connect("ws://223.233.74.221:3000");

    socketService.onMessageReceived = (message) {
      setState(() {
        messages.add(message);
      });
    };
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    final message = Message(
      sender: widget.username,
      text: controller.text.trim(),
      timestamp: DateTime.now(),
    );

    socketService.sendMessage(message);

    setState(() {
      messages.add(message);
    });

    controller.clear();
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  Widget buildMessage(Message msg) {
    final isMe = msg.sender == widget.username;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          msg.text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat - ${widget.username}")),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: messages.map(buildMessage).toList()),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Enter message",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
            ],
          ),
        ],
      ),
    );
  }
}
