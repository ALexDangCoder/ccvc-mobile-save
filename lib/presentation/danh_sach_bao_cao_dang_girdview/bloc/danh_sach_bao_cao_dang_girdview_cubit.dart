import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_state.dart';

class DanhSachBaoCaoCubit extends BaseCubit<DanhSachBaoCaoState> {
  DanhSachBaoCaoCubit() : super(DanhSachBaoCaoInitial());
  bool isCheckList = true;
}
