import 'package:ccvc_mobile/presentation/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';

class LoginProvider extends InheritedWidget {
  final LoginCubit loginCubit;

  const LoginProvider({
    Key? key,
    required this.loginCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static LoginProvider of(BuildContext context) {
    final LoginProvider? result =
        context.dependOnInheritedWidgetOfExactType<LoginProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
