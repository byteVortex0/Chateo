import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:chateo/features/conversation/chats/ui/screens/chats.dart';
import 'package:chateo/features/conversation/more/ui/more_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../contacts/ui/contacts.dart';
import '../logic/nav_bar/nav_bar_cubit.dart';
import 'widgets/bottom_nav_bar_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> screens = [Contacts(), Chats(), MoreInfo()];

  static const List<String> titles = ['Contacts', 'Chats', 'More'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              titles[context.read<NavBarCubit>().index],
              style: StyleManager.black18SemiBold(context),
            ),
          ),
          body: screens[context.read<NavBarCubit>().index],
          bottomNavigationBar: BottomAppBar(
            color: context.color.thirdColor,
            elevation: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavBarItem(
                  title: 'Contacts',
                  currentIndex: 0,
                  icons: context.asset.contacts!,
                ),
                BottomNavBarItem(
                  title: 'Chats',
                  currentIndex: 1,
                  icons: context.asset.chats!,
                ),
                BottomNavBarItem(
                  title: 'More',
                  currentIndex: 2,
                  icons: context.asset.more!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
