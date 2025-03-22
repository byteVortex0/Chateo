import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:chateo/features/conversation/chats/ui/widgets/chats.dart';
import 'package:chateo/features/conversation/more/ui/more_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../contacts/ui/contacts.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int index = 1;

  final List<Widget> screens = const [Contacts(), Chats(), MoreInfo()];

  final List<String> titles = ['Contacts', 'Chats', 'More'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[index],
          style: StyleManager.black18SemiBold(context),
        ),
      ),
      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        backgroundColor: context.color.thirdColor,
        selectedLabelStyle: StyleManager.black14SemiBold(context),
        selectedItemColor: context.color.secondaryColor,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: bulidBottomNavigationBar(
              title: 'Contacts',
              currentIndex: 0,
              context: context,
              icons: context.asset.contacts!,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: bulidBottomNavigationBar(
              title: 'Chats',
              currentIndex: 1,
              context: context,
              icons: context.asset.chats!,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: bulidBottomNavigationBar(
              title: 'More',
              currentIndex: 2,
              context: context,
              icons: context.asset.more!,
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget bulidBottomNavigationBar({
    required String title,
    required int currentIndex,
    required BuildContext context,
    required String icons,
  }) {
    return index == currentIndex
        ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: StyleManager.black14SemiBold(context)),
            SizedBox(height: 5.h),
            //TODO: Hard code
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.color.secondaryColor,
              ),
            ),
          ],
        )
        : SvgPicture.asset(icons);
  }
}
