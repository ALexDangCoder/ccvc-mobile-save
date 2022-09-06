import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: colorPrimary,
      ),
    );
  }
}
