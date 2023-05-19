import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_anagnos/model/chat_model.dart';
import 'package:gpt_anagnos/providers/chat_provider.dart';
import 'package:gpt_anagnos/services/ai_handler.dart';
import 'package:gpt_anagnos/widgets/toggle_button.dart';

enum InputMode{
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  var _isReplying= false;
  AIHandler _openAI = AIHandler();

@override
  void dispose() {
    _messageController.dispose();
    super.dispose();
     _openAI.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value){
              value.isNotEmpty ? setInputMode(InputMode.text):
              setInputMode(InputMode.voice);
            },
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                  color:Theme.of(context).colorScheme.onPrimary,
                   ),
                   borderRadius: BorderRadius.circular(12,),
                   ), 
              ),
          ),
          ),
          const SizedBox(
            width: 06,
          ),
          ToggleButton(inputMode: _inputMode,
          isReplying: _isReplying,
          sendTextMessage:(){
            final message=_messageController.text;
            _messageController.clear();
            sendTextMessage(message);

          } ,
          sendVoiceMessage: () {
            sendVoiceMessage(_messageController.text);
          },
          )

      ],
    );
  }
  void setInputMode(InputMode inputMode){
setState(() {
  _inputMode=inputMode;
});
}
void sendVoiceMessage(String message){}
void sendTextMessage(String message)async{
  setState(() {
    _isReplying=true;
  });
addToChatList(message, true, DateTime.now().toString());
addToChatList('Typing...', false,'typing');
setInputMode(InputMode.voice);
  final aiResponse = await _openAI.getResponse(message);
  removeTyping();
  addToChatList(aiResponse, false, DateTime.now().toString());
  setState(() {
    _isReplying=false;
  });
}
void removeTyping(){
  final chats= ref.read(chatsProvider.notifier);
  chats.removeTyping();
}
void addToChatList(String message,bool isMe,String id){
final chats= ref.read(chatsProvider.notifier);
chats.add(ChatModel(
  id: id, 
  message: message,
   isMe: isMe,
   ));
}
}
