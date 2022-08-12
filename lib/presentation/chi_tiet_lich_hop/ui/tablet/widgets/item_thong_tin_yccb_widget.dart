import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cap_nhat_trang_thai_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemThongTinYCCB extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ItemThongTinYCCB({Key? key, required this.cubit}) : super(key: key);

  @override
  State<ItemThongTinYCCB> createState() => _ItemThongTinYCCBState();
}

class _ItemThongTinYCCBState extends State<ItemThongTinYCCB> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: containerColorTab.withOpacity(0.1),
        border: Border.all(
          color: containerColorTab,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.noi_dung_yeu_cau,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW10,
              Expanded(
                flex: 8,
                child: Text(
                  ' ${widget.cubit.thongTinPhongHopModel.noiDungYeuCau ?? ''}',
                  style: textNormalCustom(
                    fontSize: 14,
                    color: titleCalenderWork,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.cubit.isButtonYeuCauChuanBiPhong())
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDiaLogTablet(
                        context,
                        title: S.current.cap_nhat_trang_thai,
                        child: CapNhapTrangThaiWidget(
                          cubit: widget.cubit,
                          model: widget.cubit.thongTinPhongHopModel,
                        ),
                        isBottomShow: false,
                        funcBtnOk: () {},
                      );
                    },
                    child: SvgPicture.asset(ImageAssets.ic_edit),
                  ),
                ),
            ],
          ),
          spaceH10,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.trang_thai,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW10,
              Expanded(
                flex: 8,
                child: Text(
                  ' ${widget.cubit.thongTinPhongHopModel.trangThaiChuanBi ?? ''}',
                  style: textNormalCustom(
                    fontSize: 14,
                    color: widget.cubit.thongTinPhongHopModel.getColor(
                        widget.cubit.thongTinPhongHopModel.trangThaiChuanBi ??
                            ''),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          spaceH10,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.ghi_chu,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW10,
              Expanded(
                flex: 8,
                child: Text(
                  ' ${widget.cubit.thongTinPhongHopModel.ghiChu ?? ''}',
                  style: textNormalCustom(
                    fontSize: 14,
                    color: titleCalenderWork,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
