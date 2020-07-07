import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/consts.dart';
import 'package:whatsapp_clone/providers/message.dart';
import 'package:whatsapp_clone/providers/person.dart';
import 'package:whatsapp_clone/screens/chat_item_screen.dart';

class ChatItem extends StatelessWidget {
  final InitChatData initChatData;

  ChatItem(this.initChatData);

  String getDate() {
    DateTime date = DateTime.now();
    return DateFormat.yMd(date).toString();
  }

  Route _buildRoute() {
    return MaterialPageRoute(
      builder: (context) => ChatItemScreen(initChatData),
    );
  }

  String getTime(Message message) {
    int hour = message.timeStamp.hour;
    int min = message.timeStamp.minute;
    String hRes = hour <= 9 ? '0$hour' : hour.toString();
    String mRes = min <= 9 ? '0$min' : min.toString();
    return '$hRes:$mRes';
  }

  @override
  Widget build(BuildContext context) {
    final person = initChatData.person;
    final messages = initChatData.messages;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.black.withOpacity(0.2),
      onTap: () {
        Navigator.of(context).push(_buildRoute());
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.9),
          radius: 27,
          backgroundImage: CachedNetworkImageProvider(person.imageUrl),
        ),
        title: Text(person.name, style: kChatItemTitleStyle),
        subtitle: Row(
          children: [
            Text(messages[0].content,
                style: kChatItemSubtitleStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            if (messages[0].fromId != person.uid)
            ...[SizedBox(width: 5),
              Icon(
                Icons.done_all,
                size: 19,
                color: Hexcolor('#34B7F1'),
              ),]
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                getTime(messages[0]),
                style: kChatItemSubtitleStyle),
            SizedBox(height: 5),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Hexcolor('#25D366'),
              ),
              child: Center(
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
