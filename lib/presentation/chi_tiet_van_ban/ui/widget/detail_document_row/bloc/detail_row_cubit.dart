import 'package:ccvc_mobile/config/base/base_cubit.dart';

import 'detail_row_state.dart';

class DetailRowCubit extends BaseCubit<DetailRowState> {
  DetailRowCubit() : super(DetailRowInitial());

  bool isCheckLine = true;
}
