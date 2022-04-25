import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/tong_so_luong_khach_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_phoi_hop_khac/them_don_vi_phoi_hop_khac_widget.dart';
import 'package:ccvc_mobile/widgets/thong_tin_khach_moi_widget/them_thong_tin_khach_moi_widget.dart';
import 'package:flutter/cupertino.dart';

class ThemThanhPhanThamGiaWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ThemThanhPhanThamGiaWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThemThanhPhanThamGiaWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<ThemThanhPhanThamGiaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.0.textScale(space: 10),
                ),
                ThanhPhanThamGiaWidget(
                  isPhuongThucNhan: true,
                  onChange: (value) {
                    for (final a in value) {
                      if (a.userId.isNotEmpty) {
                        widget.cubit.moiHopRequest.add(
                          MoiHopRequest(
                            VaiTroThamGia: a.vaiTroThamGia,
                            tenDonVi: a.tenDonVi,
                            hoTen: a.name,
                            status: a.status,
                            type: a.type,
                            userId: a.userId,
                            CanBoId: a.canBoId,
                            donViId: a.donViId,
                            DonViId: a.donViId,
                            chucVu: a.chucVu,
                          ),
                        );
                      } else {
                        widget.cubit.moiHopRequest.add(
                          MoiHopRequest(
                            VaiTroThamGia: a.vaiTroThamGia,
                            tenDonVi: a.tenDonVi,
                            status: a.status,
                            type: a.type,
                            donViId: a.donViId,
                            DonViId: a.donViId,
                          ),
                        );
                      }
                    }
                  },
                  phuongThucNhan: (value) {
                    widget.cubit.phuongThucNhan = value;
                  },
                ),
                spaceH16,
                TitleChildWidget(
                  title: S.current.don_vi_phoi_hop_khac,
                  sizeTitle: 14,
                  child: ThemDonViPhoiHopKhacWidget(
                    onChange: (List<DonViModel> value) {
                      for (final a in value) {
                        widget.cubit.moiHopRequest.add(
                          MoiHopRequest(
                            DauMoiLienHe: a.dauMoiLienHe,
                            Email: a.email,
                            GhiChu: a.noidung,
                            SoDienThoai: a.sdt,
                            TenCoQuan: a.tenCoQuan,
                            VaiTroThamGia: a.vaiTroThamGia,
                            dauMoi: a.dauMoiLienHe,
                            email: a.email,
                            noiDungLamViec: a.noidung,
                            soDienThoai: a.sdt,
                            tenCanBo: '',
                            tenDonVi: a.tenDonVi,
                          ),
                        );
                      }
                    },
                  ),
                ),
                spaceH24,
                TitleChildWidget(
                  title: S.current.khach_moi,
                  sizeTitle: 14,
                  child: ThemThongTinKhachMoiWidget(
                    onChange: (List<DonViModel> value) {
                      for (final a in value) {
                        widget.cubit.moiHopRequest.add(
                          MoiHopRequest(
                            DauMoiLienHe: a.dauMoiLienHe,
                            Email: a.email,
                            GhiChu: a.noidung,
                            SoDienThoai: a.sdt,
                            id: null,
                            TenCoQuan: a.tenCoQuan,
                            VaiTroThamGia: a.vaiTroThamGia,
                            dauMoi: a.dauMoiLienHe,
                            email: a.email,
                            noiDungLamViec: a.noidung,
                            soDienThoai: a.sdt,
                            tenCanBo: a.tenCanBo,
                            tenDonVi: a.tenDonVi,
                          ),
                        );
                      }
                    },
                  ),
                ),
                spaceH20,
                const TongSoLuongKhachWidget()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.luu,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                widget.cubit.phuongThucNhan = false;
                widget.cubit.themThanhPhanThamGia();
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
