import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_state.dart';
import 'package:rxdart/rxdart.dart';

class DanhSachBaoCaoCubit extends BaseCubit<DanhSachBaoCaoState> {
  DanhSachBaoCaoCubit() : super(DanhSachBaoCaoInitial());
  BehaviorSubject<String> textFilter = BehaviorSubject.seeded(S.current.tu_a_z);
  BehaviorSubject<bool> isCheckList = BehaviorSubject.seeded(true);
}
