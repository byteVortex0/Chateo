import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/core/routes/app_routes.dart';
import 'package:chateo/core/utils/color_manager.dart';
import 'package:chateo/features/conversation/contacts/logic/get_all_contacts/get_all_contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/common/widgets/custom_list_item.dart';
import '../../../../core/common/widgets/loading_shimmer.dart';
import '../../../../core/utils/fonts/style_manager.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await context.read<GetAllContactsCubit>().getAllContacts();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(
              hint: 'Search',
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.search,
                color: LightColorManager.hintTextField,
              ),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.zero,
              onChanged: (value) {
                if (value != null && value.isNotEmpty) {
                  context.read<GetAllContactsCubit>().searchContacts(
                    value.toLowerCase(),
                  );
                } else {
                  context.read<GetAllContactsCubit>().getAllContacts();
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<GetAllContactsCubit, GetAllContactsState>(
                builder: (context, state) {
                  if (state is GetAllContactsLoading) {
                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 30.h),
                      itemCount: 10,
                      itemBuilder: (context, index) => const LoadingShimmer(),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10.w),
                    );
                  }
                  if (state is GetAllContactsError) {
                    return Center(
                      child: Text(
                        'Failed to load contacts, please try again',
                        style: StyleManager.neutral10Regular(
                          context,
                        ).copyWith(fontSize: 18.sp),
                      ),
                    );
                  }
                  if (state is GetAllContactsSuccess) {
                    final contacts = state.contacts;
                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 30.h),
                      itemCount: contacts.length,
                      itemBuilder:
                          (context, index) => CustomListItem(
                            name:
                                '${contacts[index].firstName} ${contacts[index].lastName}',
                            imageUrl: contacts[index].imageUrl,
                            phoneNumber: contacts[index].phoneNumber,
                            massage: '',
                            onPressed: () {
                              context.pushNamed(
                                AppRoutes.personalChat,
                                arguments: {'user': contacts[index]},
                              );
                            },
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10.w),
                    );
                  }
                  if (state is GetAllContactsEmpty) {
                    return Center(
                      child: Text(
                        'No contacts found',
                        style: StyleManager.neutral10Regular(
                          context,
                        ).copyWith(fontSize: 18.sp),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
