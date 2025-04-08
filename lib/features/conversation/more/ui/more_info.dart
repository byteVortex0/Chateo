import 'package:chateo/core/extensions/context_extension.dart';
import 'package:chateo/features/conversation/more/logic/get_personal_data/get_personal_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/fonts/style_manager.dart';
import 'widgets/build_list_tile.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetPersonalDataCubit, GetPersonalDataState>(
              builder: (context, state) {
                if (state is GetPersonalDataLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetPersonalDataFailure) {
                  return Text('Error', style: StyleManager.offWhite12Regular);
                }
                if (state is GetPersonalDataSuccess) {
                  return Row(
                    children: [
                      state.personalInfoModel.imageUrl.isNotEmpty
                          ? CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(
                              state.personalInfoModel.imageUrl,
                            ),
                            onBackgroundImageError:
                                (_, __) => Icon(
                                  Icons.error,
                                  size: 40.w,
                                  color: Colors.red,
                                ),
                          )
                          : SvgPicture.asset(context.asset.profileImage!),

                      SizedBox(width: 10.w),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.personalInfoModel.firstName} ${state.personalInfoModel.lastName}',
                            style: StyleManager.secondary14SemiBold(context),
                          ),
                          Text(
                            state.personalInfoModel.phoneNumber,
                            style: StyleManager.offWhite12Regular,
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            SizedBox(height: 20.h),
            BuildListTile(),
          ],
        ),
      ),
    );
  }
}
