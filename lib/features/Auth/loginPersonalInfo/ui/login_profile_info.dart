import 'dart:developer';

import 'package:chateo/core/common/widgets/custom_elevated_button.dart';
import 'package:chateo/core/common/widgets/custom_text_field.dart';
import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/service/shared_pref/shared_pref.dart';
import 'package:chateo/core/utils/fonts/style_manager.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/logic/add_personal_info/add_personal_info_cubit.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/ui/widgets/select_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/service/shared_pref/pref_key.dart';
import '../data/models/personal_info_model.dart';

class LoginProfileInfo extends StatefulWidget {
  const LoginProfileInfo({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<LoginProfileInfo> createState() => _LoginProfileInfoState();
}

class _LoginProfileInfoState extends State<LoginProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String? selectImage;

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
                          SelectImage(
                            onImageSelected: (imageUrl) {
                              setState(() {
                                selectImage = imageUrl;
                              });
                            },
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            hint: 'First Name',
                            controller: firstNameController,
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            hint: 'Last Name',
                            controller: lastNameController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<AddPersonalInfoCubit, AddPersonalInfoState>(
                    listener: (context, state) {
                      if (state is AddPersonalInfoSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        SharedPref.setValue(PrefKey.isLoggedIn, true);

                        context.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
                      } else if (state is AddPersonalInfoFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddPersonalInfoLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomElevatedButton(
                        title: 'Save',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select an image'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            log('Phone Number: ${widget.phoneNumber}');
                            context
                                .read<AddPersonalInfoCubit>()
                                .addPersonalInfo(
                                  personalInfoModel: PersonalInfoModel(
                                    phoneNumber: widget.phoneNumber,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    imageUrl: selectImage!,
                                  ),
                                );
                          }
                        },
                      );
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
