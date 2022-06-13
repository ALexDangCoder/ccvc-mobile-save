import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';

class CongTacChuanBiWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const CongTacChuanBiWidgetTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _CongTacChuanBiWidgetTabletState createState() =>
      _CongTacChuanBiWidgetTabletState();
}

class _CongTacChuanBiWidgetTabletState
    extends State<CongTacChuanBiWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: body(),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleType(
            title: S.current.thong_tin_phong,
            child: StreamBuilder<ThongTinPhongHopModel?>(
              stream: widget.cubit.getThongTinPhongHop,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: NodataWidget(),
                  );
                }
                return ThongTinPhongWidget(
                  thongTinPhongHopModel: data,
                );
              },
            ),
          ),
          spaceH20,
          titleType(
            title: S.current.yeu_cau_de_chuan_bi_phong,
            child: StreamBuilder<List<ThietBiPhongHopModel>>(
              stream: widget.cubit.getListThietBi,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <ThietBiPhongHopModel>[];
                if (data.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: NodataWidget(),
                  );
                }
                return Column(
                  children: List.generate(
                    data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ThongTinYeuCauThietBiWidget(
                        model: data[index],
                        onChange: (bool) {},
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget titleType({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textNormalCustom(color: infoColor, fontSize: 14),
        ),
        spaceH16,
        child
      ],
    );
  }
}
