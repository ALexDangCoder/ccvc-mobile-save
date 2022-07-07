import 'package:ccvc_mobile/config/base/base_cubit.dart';

import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/bloc/detail_row_state.dart';

class DetailRowCubit extends BaseCubit<DetailRowState> {
  DetailRowCubit() : super(DetailRowInitial());

  bool isCheckLine = true;
}
