import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
class AIHandler{
  final _openAI = OpenAI.instance.build(token: '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',
  baseOption: HttpSetup(receiveTimeout:  const Duration(seconds: 20),
  connectTimeout: const Duration(seconds: 20),) ,
  );
Future<String> getResponse(String message) async{
  try{
  final request = ChatCompleteText(messages: [
    Map.of({"role": "user", "content": message})
  ], maxToken: 200, model: kChatGptTurbo0301Model);

  final response = await _openAI.onChatCompletion(request: request);
   if(response != null){
        return response.choices[0].message.content.trim();
      }
      return 'Something went wrong';
  }catch(e){
return 'Bad response';
  }
}
  void dispose() {
    _openAI.close();
  }
}