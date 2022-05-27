import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/bloc_tree/danh_ba_state.dart';

class DanhBaCubit extends BaseCubit<DanhBaState> {
  DanhBaCubit() : super(MainStateInitial());
  Timer? _debounce;

  void dispose() {}
}
