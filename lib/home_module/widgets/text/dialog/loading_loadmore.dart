import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';

class LoadingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: colorPrimary,
      ),
    );
  }
}
