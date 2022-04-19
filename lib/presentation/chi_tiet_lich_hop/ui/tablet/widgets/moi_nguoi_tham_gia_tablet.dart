import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'cell_thanh_phan_tham_gia_widget.dart';

class MoiNguoiThamGiaWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const MoiNguoiThamGiaWidgetTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _MoiNguoiThamGiaWidgetTabletState createState() =>
      _MoiNguoiThamGiaWidgetTabletState();
}

class _MoiNguoiThamGiaWidgetTabletState
    extends State<MoiNguoiThamGiaWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.ic_addUser,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showDiaLogTablet(
                context,
                title: S.current.them_thanh_phan_tham_gia,
                child: ThemThanhPhanThamGiaWidget(
                  cubit: widget.cubit,
                ),
                isBottomShow: false,
                funcBtnOk: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                child: IconWithTiltleWidget(
                  icon: ImageAssets.ic_diemDanh,
                  title: S.current.diem_danh,
                  onPress: () {
                    showDiaLog(
                      context,
                      title: S.current.diem_danh,
                      icon: SvgPicture.asset(ImageAssets.icDiemDanh),
                      btnLeftTxt: S.current.khong,
                      btnRightTxt: S.current.dong_y,
                      funcBtnRight: () {},
                      showTablet: true,
                      textContent: S.current.conten_diem_danh,
                    );
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                child: IconWithTiltleWidget(
                  type2: true,
                  icon: ImageAssets.ic_huyDiemDanh,
                  title: S.current.huy_diem_danh,
                  onPress: () {
                    showDiaLog(
                      context,
                      title: S.current.huy_diem_danh,
                      icon: SvgPicture.asset(ImageAssets.icHuyDiemDanh),
                      btnLeftTxt: S.current.khong,
                      btnRightTxt: S.current.dong_y,
                      funcBtnRight: () {},
                      showTablet: true,
                      textContent: S.current.conten_huy_diem_danh,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          BaseSearchBar(
            hintText: S.current.tim_kiem_can_bo,
            onChange: (value) {
              widget.cubit.search(value);
            },
          ),
          StreamBuilder<List<CanBoModel>>(
            stream: widget.cubit.streamthanhPhanThamGia,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 13.5, top: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<bool>(
                        stream: widget.cubit.checkBoxCheckBool,
                        builder: (context, snapshot) {
                          return CustomCheckBox(
                            title: '',
                            isCheck: snapshot.data ?? false,
                            onChange: (value) {
                              widget.cubit.check = !widget.cubit.check;
                              widget.cubit.checkAll();
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      AutoSizeText(
                        S.current.chon_tat_ca,
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          spaceH16,
          StreamBuilder<List<CanBoModel>>(
            stream: widget.cubit.streamthanhPhanThamGia,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return CellThanhPhanThamGia(
                      cubit: widget.cubit,
                      infoModel: _list[index],
                    );
                  },
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: NodataWidget(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
