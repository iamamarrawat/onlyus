import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_us/components/gradient_button.dart';
import 'package:only_us/components/gradient_container.dart';
import 'package:only_us/components/gradient_icon_button.dart';
import 'package:only_us/models/message.dart';
import 'package:only_us/services/socket_services.dart';
import 'package:only_us/utils/timer_formatter.dart';

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
    connectSocket();
    super.initState();
  }

  void connectSocket() async {
    await socketService.connect("wss://onlyus-server.onrender.com");

    socketService.messages.listen((message) {
      setState(() {
        messages.add(message);
      });
    });
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
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
        decoration: BoxDecoration(
          color: isMe
              ? const Color.fromARGB(255, 32, 86, 34).withOpacity(0.8)
              : const Color.fromARGB(255, 48, 60, 49),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              formatSmartTimestamp(msg.timestamp),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTimeBasedGreeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good morning, $name ☀️";
    if (hour < 17) return "Good afternoon, $name 🌤️";
    return "Good evening, $name 🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.username == "user2"
                      ? getTimeBasedGreeting("Sadhana")
                      : getTimeBasedGreeting("Amar"),
                  style: GoogleFonts.dancingScript(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - 1 - index];
                    return buildMessage(msg);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: TextField(
                          cursorColor: Colors.white,
                          autofocus: false,
                          controller: controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter message",
                            filled: true,
                            fillColor: const Color.fromARGB(255, 64, 81, 65),

                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    GradientIconButton(icon: Icons.send, onTap: sendMessage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
