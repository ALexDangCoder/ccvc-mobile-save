import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/moi_nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
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
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();

  @override
  void initState() {
    super.initState();
    cubit = DetailMeetCalenderCubit();
    cubit.idCuocHop = widget.id;
    cubit.initData(boolGetChiTietLichHop: true);
    cubit.initDataButton();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      stream: cubit.stateStream,
      child: Scaffold(
        appBar: BaseAppBar(
          leadingIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(ImageAssets.icBack),
          ),
          title: S.current.chi_tiet_lich_hop,
          actions: [
            StreamBuilder<List<PERMISSION_DETAIL>>(
                stream: cubit.listButtonSubject.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return MenuSelectWidget(
                    listSelect: data
                        .map(
                          (e) => e.getMenuLichHop(
                            context,
                            cubit,
                            widget.id,
                          ),
                        )
                        .toList(),
                  );
                }),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: ProviderWidget<DetailMeetCalenderCubit>(
          cubit: cubit,
          child: ExpandGroup(
            child: RefreshIndicator(
              onRefresh: () async {
                await cubit.initData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    StreamBuilder<ChiTietLichHopModel>(
                      stream: cubit.chiTietLichLamViecSubject.stream,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: CongTacChuanBiWidget(
                        cubit: cubit,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ChuongTrinhHopWidget(
                        id: widget.id,
                        cubit: cubit,
                      ),
                    ),
                    ThanhPhanThamGiaWidget(
                      cubit: cubit,
                    ),
                    TaiLieuWidget(
                      cubit: cubit,
                    ),
                    PhatBieuWidget(
                      cubit: cubit,
                      id: widget.id,
                    ),
                    BieuQuyetWidget(
                      id: widget.id,
                      cubit: cubit,
                    ),
                    KetLuanHopWidget(
                      cubit: cubit,
                      id: widget.id,
                    ),
                    YKienCuocHopWidget(
                      id: widget.id,
                      cubit: cubit,
                    ),
                    BocBangWidget(
                      cubit: cubit,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DoubleButtonBottom(
                        title1: S.current.tham_du,
                        title2: S.current.tu_choi,
                        onPressed1: () {},
                        onPressed2: () {},
                      ),
                    )
                  ],
                ),
              ),
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
