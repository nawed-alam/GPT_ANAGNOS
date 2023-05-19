import 'package:flutter/material.dart';
import 'package:gpt_anagnos/providers/active_theme_provider.dart';
import 'package:gpt_anagnos/screens/chat_screen.dart';
import 'package:gpt_anagnos/constants/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp( const ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme:darkTheme,
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home:ChatScreen(),
    );
  }
} 