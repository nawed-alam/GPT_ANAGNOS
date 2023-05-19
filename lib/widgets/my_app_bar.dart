import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_anagnos/widgets/theme_switch.dart';

import '../providers/active_theme_provider.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('Anagnos GPT',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        ),
        actions: [
          Row(
            children: [
              Consumer(
                builder: (context,ref,child) =>Icon(
                  ref.watch(activeThemeProvider)== Themes.dark
                   ? Icons.dark_mode : 
                   Icons.light_mode),
              ),
              SizedBox(width: 8,),
              ThemeSwitch()
            ],
          )
        ],
      );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(60);
} 