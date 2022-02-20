import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:flutter/material.dart';

class ManagerProvider extends InheritedWidget {
  final ManagerPersonalInformationCubit managerCubit;

  const ManagerProvider({
    Key? key,
    required this.managerCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static ManagerProvider of(BuildContext context) {
    final ManagerProvider? result =
        context.dependOnInheritedWidgetOfExactType<ManagerProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
