import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:intl/intl.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  LichHopCubit() : super(LichHopStateIntial());

  dynamic currentTime = DateFormat.yMMMEd().format(DateTime.now());
}
