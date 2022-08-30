import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/checkbox/checkbox.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemPeopleThamGia extends StatefulWidget {
  final DonViModel donVi;
  final ThanhPhanThamGiaCubit cubit;
  final String noiDungCV;
  final bool isChuTri;
  final bool isSendEmail;
  final bool isKhachMoi;
  final Function()? onDelete;
  final bool isHindCheckBox;

  const ItemPeopleThamGia({
    Key? key,
    required this.donVi,
    required this.cubit,
    this.noiDungCV = '',
    this.isChuTri = false,
    this.isSendEmail = false,
    this.isKhachMoi = false,
    this.onDelete,
    this.isHindCheckBox = false,
  }) : super(key: key);

  @override
  State<ItemPeopleThamGia> createState() => _ItemPeopleThamGiaState();
}

class _ItemPeopleThamGiaState extends State<ItemPeopleThamGia> {
  bool isSendEmail = false;

  @override
  void initState() {
    super.initState();
    isSendEmail = widget.isSendEmail;
  }

  @override
  void didUpdateWidget(covariant ItemPeopleThamGia oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSendEmail = widget.isSendEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              rowInfo(
                value: widget.isKhachMoi
                    ? widget.donVi.tenDonVi.trim()
                    : widget.donVi.name.trim(),
                key: S.current.ten_don_vi,
                needShowPadding: true,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: widget.donVi.tenCanBo.trim(),
                key: S.current.ten_can_bo,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              if (!widget.isKhachMoi) ...[
                rowInfo(
                  value: widget.isChuTri
                      ? S.current.can_bo_chu_tri
                      : S.current.can_bo_phoi_hop,
                  key: S.current.vai_tro,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
              ],
              if (widget.isKhachMoi) ...[
                rowInfo(
                  value: widget.donVi.soLuong.toString().trim(),
                  key: S.current.so_luong,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
              ],
              rowInfo(
                value: widget.isKhachMoi
                    ? widget.donVi.noidung.trim()
                    : widget.noiDungCV.trim(),
                key: S.current.nd_cong_viec,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onDelete?.call();
                    widget.cubit.deletePeopleThamGia(widget.donVi);
                  },
                  child: SvgPicture.asset(ImageAssets.icDeleteRed),
                ),
                spaceW12,
                if (widget.isHindCheckBox)
                  Container()
                else
                  CusCheckBox(
                    isChecked: isSendEmail,
                    onChange: (value) {},
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
