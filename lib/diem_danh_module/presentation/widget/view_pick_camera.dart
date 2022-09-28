import 'dart:io';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/onButtonCustom.dart';
import 'package:flutter/material.dart';

class ViewPickCamera extends StatelessWidget {
  final File? imagePath;
  final String title;

  const ViewPickCamera({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(title),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(imagePath!),
              fit: BoxFit.cover,
            ),
          ),
        ) ,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonBottomCustom(
          text: S.current.xong,
          onPressed: () {
            Navigator.pop(context, imagePath);
          },
        ),
      ),
    );
  }
}
