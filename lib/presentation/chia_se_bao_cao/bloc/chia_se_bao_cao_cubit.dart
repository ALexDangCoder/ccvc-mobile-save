import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:meta/meta.dart';

part 'chia_se_bao_cao_state.dart';

class ChiaSeBaoCaoCubit extends BaseCubit<ChiaSeBaoCaoState> {
  ChiaSeBaoCaoCubit() : super(ChiaSeBaoCaoInitial());



  Future<void> getGroup() async {}
  Future<void> getDonVi() async {}
  Future<void> getDoiTuongTruyCap() async {}
  Future<void> themMoiDoiTuong() async {}
  Future<void> chiaSeBaoCao() async {}



  List<NhomCungHeThong> listResponse = [];
  List<String> listDropDown = ['Nhóm A','Nhóm B','Nhóm C','Nhóm D',];
  List<NhomCungHeThong> listCheck = [];


}
