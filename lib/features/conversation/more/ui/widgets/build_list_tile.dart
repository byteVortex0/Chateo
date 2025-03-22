import 'package:chateo/core/app/theme_cubit/theme_cubit.dart';
import 'package:chateo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/fonts/style_manager.dart';

class BuildListTile extends StatelessWidget {
  const BuildListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(
          title: 'Account',
          icon: Icons.person_2_outlined,
          context: context,
        ),
        buildListTile(
          title: 'Chats',
          icon: Icons.chat_bubble_outline,
          context: context,
        ),

        SizedBox(height: 10.h),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return buildListTile(
              title: 'Appereance',
              icon: Icons.brightness_5_outlined,
              context: context,
              trailing: Switch(
                activeColor: Colors.white,
                value: context.read<ThemeCubit>().isDark,
                onChanged: (value) {
                  context.read<ThemeCubit>().changeThemeMode(sharedMode: value);
                },
              ),
            );
          },
        ),
        buildListTile(
          title: 'Notification',
          icon: Icons.notifications,
          context: context,
        ),
        buildListTile(
          title: 'Privacy',
          icon: Icons.privacy_tip_outlined,
          context: context,
        ),
        buildListTile(
          title: 'Data Usage',
          icon: Icons.storage_outlined,
          context: context,
        ),

        Divider(),
        buildListTile(
          title: 'Help',
          icon: Icons.help_center_outlined,
          context: context,
        ),
        buildListTile(
          title: 'Invite Your Friends',
          icon: Icons.mail_outline,
          context: context,
        ),
      ],
    );
  }

  Widget buildListTile({
    required String title,
    required IconData icon,
    required BuildContext context,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: context.color.secondaryColor),
      title: Text(title, style: StyleManager.secondary14SemiBold(context)),
      trailing: trailing,
    );
  }
}
