import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:flutter/material.dart';

class TaoLichLamViecProvider extends InheritedWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;

  const TaoLichLamViecProvider({
    Key? key,
    required this.taoLichLamViecCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static TaoLichLamViecProvider of(BuildContext context) {
    final TaoLichLamViecProvider? result =
        context.dependOnInheritedWidgetOfExactType<TaoLichLamViecProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
