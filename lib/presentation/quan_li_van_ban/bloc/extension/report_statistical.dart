import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';

extension ReportStatistical on QLVBCCubit {
  void generateListTime() {
    yearsList =
        List.generate(20, (index) => (2010 + index).toString()).toList();
    monthsList = [
      S.current.january,
      S.current.february,
      S.current.march,
      S.current.april,
      S.current.may,
      S.current.june,
      S.current.july,
      S.current.august,
      S.current.september,
      S.current.october,
      S.current.november,
      S.current.december,
    ];
  }
}
