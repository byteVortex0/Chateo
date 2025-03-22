import 'package:chateo/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class AssetThemeExtension extends ThemeExtension<AssetThemeExtension> {
  final String? profile;
  final String? profileImage;
  final String? onBoarding;
  final String? chats;
  final String? contacts;
  final String? more;

  const AssetThemeExtension({
    required this.profile,
    required this.profileImage,
    required this.onBoarding,
    required this.chats,
    required this.contacts,
    required this.more,
  });

  @override
  ThemeExtension<AssetThemeExtension> copyWith({
    String? profile,
    String? profileImage,
    String? onBoarding,
    String? chats,
    String? contacts,
    String? more,
  }) {
    return AssetThemeExtension(
      profile: profile ?? this.profile,
      profileImage: profileImage ?? this.profileImage,
      onBoarding: onBoarding ?? this.onBoarding,
      chats: chats ?? this.chats,
      contacts: contacts ?? this.contacts,
      more: more ?? this.more,
    );
  }

  @override
  ThemeExtension<AssetThemeExtension> lerp(
    covariant ThemeExtension<AssetThemeExtension>? other,
    double t,
  ) {
    if (other is! AssetThemeExtension) {
      return this;
    }
    return AssetThemeExtension(
      profile: other.profile,
      profileImage: other.profileImage,
      onBoarding: other.onBoarding,
      chats: other.chats,
      contacts: other.contacts,
      more: other.more,
    );
  }

  static const AssetThemeExtension light = AssetThemeExtension(
    profile: AppImages.profileLight,
    profileImage: AppImages.profileImageLight,
    onBoarding: AppImages.onBoardingLight,
    chats: AppImages.chatsLight,
    contacts: AppImages.contactsLight,
    more: AppImages.moreLight,
  );
  static const AssetThemeExtension dark = AssetThemeExtension(
    profile: AppImages.profileDark,
    profileImage: AppImages.profileImageDark,
    onBoarding: AppImages.onBoardingDark,
    chats: AppImages.chatsDark,
    contacts: AppImages.contactsDark,
    more: AppImages.moreDark,
  );
}
