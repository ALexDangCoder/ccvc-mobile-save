import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';

import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/moi_nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailMeetCalenderScreen extends StatefulWidget {
  final String id;

  const DetailMeetCalenderScreen({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderScreen> createState() =>
      _DetailMeetCalenderScreenState();
}

class _DetailMeetCalenderScreenState extends State<DetailMeetCalenderScreen> {
  late DetailMeetCalenderCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = DetailMeetCalenderCubit();
    cubit.initData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: BaseAppBar(
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icBack),
        ),
        title: S.current.chi_tiet_lich_hop,
        actions: [
          MenuSelectWidget(
            listSelect: [
              QData(
                urlImage: ImageAssets.icHuy,
                text: S.current.huy_lich_hop,
                onTap: () {},
              ),
              QData(
                urlImage: ImageAssets.ic_delete_do,
                text: S.current.xoa_lich,
                onTap: () {},
              ),
              QData(
                urlImage: ImageAssets.icEditBlue,
                text: S.current.sua_lich,
                onTap: () {},
              ),
              QData(
                urlImage: ImageAssets.icThuHoi,
                text: S.current.xoa_lich,
                onTap: () {},
              ),
              QData(
                urlImage: ImageAssets.icPhanCongThuKy,
                text: S.current.phan_cong_thu_ky,
                onTap: () {},
              ),
              QData(
                urlImage: ImageAssets.icTaoBocBang,
                text: S.current.tao_boc_bang_cuoc_hop,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: DetailMeetCalendarInherited(
        cubit: cubit,
        child: ExpandGroup(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                StreamBuilder<ChiTietLichHopModel>(
                  stream: cubit.chiTietLichLamViecStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    final data = snapshot.data ?? ChiTietLichHopModel();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 12,
                              color: statusCalenderRed,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              data.title,
                              style: textNormalCustom(
                                color: titleCalenderWork,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: data
                              .valueData()
                              .map(
                                (e) => Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: RowDataWidget(
                                    urlIcon: e.urlIcon,
                                    text: e.text,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        spaceH16,
                        ThongTinLienHeWidget(
                          thongTinTxt: data.chuTriModel.dauMoiLienHe,
                          sdtTxt: data.chuTriModel.soDienThoai,
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CongTacChuanBiWidget(
                  cubit: cubit,
                ),
                const ChuongTrinhHopWidget(),
                const MoiNguoiThamGiaWidget(),
                const TaiLieuWidget(),
                // PhatBieuWidget(),
                // BieuQuyetWidget(),
                // KetLuanHopWidget(),
                // YKienCuocHopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListKetThuc({
    required String icon,
    required String name,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColorApp,
        width: 170,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: SvgPicture.asset(icon)),
            SizedBox(
              width: 10.0.textScale(),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0.textScale(),
                    ),
                  ),
                  SizedBox(
                    height: 14.0.textScale(),
                  ),
                  Container(
                    height: 1,
                    color: borderColor.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 14.0.textScale(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailMeetCalendarInherited extends InheritedWidget {
  DetailMeetCalenderCubit cubit;

  DetailMeetCalendarInherited(
      {Key? key, required this.cubit, required Widget child})
      : super(key: key, child: child);

  static DetailMeetCalendarInherited of(BuildContext context) {
    final DetailMeetCalendarInherited? result = context
        .dependOnInheritedWidgetOfExactType<DetailMeetCalendarInherited>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
