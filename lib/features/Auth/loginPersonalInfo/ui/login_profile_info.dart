import 'package:chateo/core/common/widgets/custom_elevated_button.dart';
import 'package:chateo/core/common/widgets/custom_text_field.dart';
import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/app_routes.dart';

class LoginProfileInfo extends StatefulWidget {
  const LoginProfileInfo({super.key});

  @override
  State<LoginProfileInfo> createState() => _LoginProfileInfoState();
}

class _LoginProfileInfoState extends State<LoginProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: StyleManager.black18SemiBold(context),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(context.asset.profile!),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            hint: 'First Name (Required)',
                            controller: firstNameController,
                          ),
                          SizedBox(height: 10.h),
                          CustomTextField(
                            hint: 'Last Name (Optional)',
                            controller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    title: 'Save',
                    onTap: () {
                      context.pushNamedAndRemoveUntil(AppRoutes.chatsScreen);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
