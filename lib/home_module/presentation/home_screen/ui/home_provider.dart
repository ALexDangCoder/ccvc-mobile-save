import 'package:flutter/material.dart';

import '/home_module/presentation/home_screen/bloc/home_cubit.dart';

class HomeProvider extends InheritedWidget {
  final HomeCubit homeCubit;
  final ScrollController controller;

  const HomeProvider({
    Key? key,
    required this.homeCubit,
    required Widget child,
    required this.controller,
  }) : super(key: key, child: child);

  static HomeProvider of(BuildContext context) {
    final HomeProvider? result =
        context.dependOnInheritedWidgetOfExactType<HomeProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
