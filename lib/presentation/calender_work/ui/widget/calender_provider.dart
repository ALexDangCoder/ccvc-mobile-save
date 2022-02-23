import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:flutter/material.dart';

class CalenderProvider extends InheritedWidget {
  final CalenderCubit cubit;

  const CalenderProvider({
    Key? key,
    required this.cubit,
    required Widget child,
  }) : super(key: key, child: child);

  static CalenderProvider of(BuildContext context) {
    final CalenderProvider? result =
        context.dependOnInheritedWidgetOfExactType<CalenderProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
