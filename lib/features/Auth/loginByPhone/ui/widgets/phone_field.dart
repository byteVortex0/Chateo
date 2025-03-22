import 'dart:developer';

import 'package:chateo/core/extensions/context_extension.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/fonts/style_manager.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.color.bgTextFieldColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: CountryCodePicker(
            initialSelection: 'EG',
            showFlag: true,
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            onChanged: (country) {
              log('كود الدولة المختار: ${country.dialCode}');
            },
          ),
        ),

        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              fillColor: context.color.bgTextFieldColor,
              filled: true,
              hintText: 'Phone Number',
              hintStyle: StyleManager.offWhite14SemiBold(context),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            keyboardType: TextInputType.phone,
            onChanged: (text) {
              log('رقم الهاتف المدخل: $text');
            },
          ),
        ),
      ],
    );
  }
}
