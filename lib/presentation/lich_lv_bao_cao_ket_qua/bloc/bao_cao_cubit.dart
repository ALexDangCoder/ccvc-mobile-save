import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/presentation/lich_lv_bao_cao_ket_qua/bloc/bao_cao_state.dart';
import 'package:rxdart/rxdart.dart';

class BaoCaoCubit extends BaseCubit<BaoCaoState> {
  BaoCaoCubit() : super(BaoCaoStateIntial());

  final BehaviorSubject<List<BaoCaoModel>> _listBaoCao =
      BehaviorSubject<List<BaoCaoModel>>();

  Stream<List<BaoCaoModel>> get listBaoCao => _listBaoCao.stream;

  void initData() {
    _listBaoCao.sink.add(listDataFake);
  }
  void getData(List<BaoCaoModel>listBaoCao) {
    _listBaoCao.sink.add(listBaoCao);
  }

  List<BaoCaoModel> listDataFake = [
    BaoCaoModel(
      status: BaoCaoStatus.TRUNG_BINH,
      content: 'ke hoach nam 2022',
      fileName: ['ke hoach nam 2022','file2'],),
    BaoCaoModel(
      status: BaoCaoStatus.DAT,
      content: 'ke hoach nam 2022',
      fileName: ['file1','file2'],),
    BaoCaoModel(
      status: BaoCaoStatus.DAT,
      content: 'ke hoach nam 2022',
      fileName: ['file1','file2'],),
    BaoCaoModel(
      status: BaoCaoStatus.KHONG_DAT,
      content: 'ke hoach nam 2022',
      fileName: ['file1','file2'],),
    BaoCaoModel(
      status: BaoCaoStatus.KHONG_DAT,
      content: 'ke hoach nam 2022',
      fileName: ['file1','file2'],),
    BaoCaoModel(
      status: BaoCaoStatus.KHONG_DAT,
      content: 'ke hoach nam 2022',
      fileName: ['file1','file2'],),

  ];
}
