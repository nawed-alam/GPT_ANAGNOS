import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_anagnos/providers/chat_provider.dart';
import 'package:gpt_anagnos/widgets/chart_item.dart';
import 'package:gpt_anagnos/widgets/text_and_voice_field.dart';

import '../widgets/my_app_bar.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child:Consumer(
              builder: (context,ref,child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder:(context,index)=>  ChartItem(
                    text:chats[index].message, 
                    isMe: chats[index].isMe),
                  );
              }
            )
            ),
          const Padding(
             padding:  EdgeInsets.all(12.0),
             child: const TextAndVoiceField(),
           ),
           const SizedBox(height: 10,),
        ],
      ),
    );
  }
}