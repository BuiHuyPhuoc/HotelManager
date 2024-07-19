// ignore_for_file: must_be_immutable

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  LanguageItem({super.key, required this.language, required this.countryFlag});
  String language;
  CountryFlag countryFlag;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countryFlag,
          SizedBox(width: 5,),
          Expanded(
            child: Text(language),
          )
        ],
      ),
    );
  }
}
