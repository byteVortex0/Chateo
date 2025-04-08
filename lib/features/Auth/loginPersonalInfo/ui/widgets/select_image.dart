import 'package:chateo/features/Auth/loginPersonalInfo/logic/upload_images/upload_images_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key, required this.onImageSelected});

  final Function(String imageUrl) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadImagesCubit, UploadImagesState>(
      listener: (context, state) {
        if (state is UploadImagesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          onImageSelected(state.image);
        } else if (state is UploadImagesFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        } else if (state is UploadImagesLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Uploading image...'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UploadImagesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return state is UploadImagesSuccess
            ? CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(state.image),
              onBackgroundImageError:
                  (_, __) => Icon(Icons.error, size: 40.w, color: Colors.red),
            )
            : Container(
              height: 80.h,
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: IconButton(
                onPressed: () async {
                  await context.read<UploadImagesCubit>().uploadImages();
                },
                icon: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
              ),
            );
      },
    );
  }
}
