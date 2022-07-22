import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:meta/meta.dart';

part 'bao_cao_thong_ke_state.dart';

class BaoCaoThongKeCubit extends BaseCubit<BaoCaoThongKeState> {
  BaoCaoThongKeCubit() : super(BaoCaoThongKeInitial());
}
