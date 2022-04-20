import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:flutter/material.dart';

class ChiTietProvider extends InheritedWidget {
  final ChiTietLichLamViecCubit cubit;

  const ChiTietProvider({
    Key? key,
    required this.cubit,
    required Widget child,
  }) : super(key: key, child: child);

  static ChiTietProvider of(BuildContext context) {
    final ChiTietProvider? result =
        context.dependOnInheritedWidgetOfExactType<ChiTietProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
