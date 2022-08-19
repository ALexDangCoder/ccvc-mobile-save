import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PeopleThamGiaWidget extends StatelessWidget {
  final DonViModel donVi;
  final ThanhPhanThamGiaCubit cubit;
  final Function(DonViModel donViModel) onDelete;

  const PeopleThamGiaWidget({
    Key? key,
    required this.donVi,
    required this.cubit,
    required this.onDelete,
  }) : super(key: key);

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
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: rowInfo(
                  value: donVi.name,
                  key: S.current.don_vi_phoi_hop,
                ),
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: rowInfo(
                    value: donVi.tenCanBo, key: S.current.nguoi_phoi_hop),
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              Row(
                crossAxisAlignment: isMobile()
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3.0.textScale().toInt(),
                    child: Text(
                      S.current.noi_dung,
                      style: textNormal(infoColor, 14.0.textScale()),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: textField(
                      onChange: (value) {
                        cubit.nhapNoiDungDonVi(value, donVi);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                onDelete(donVi);
                cubit.deletePeopleThamGia(donVi);
              },
              child: SvgPicture.asset(ImageAssets.icDeleteRed),
            ),
          )
        ],
      ),
    );
  }

  Widget rowInfo({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 3.0.textScale().toInt(),
          child: Text(
            key,
            style: textNormal(infoColor, 14.0.textScale()),
          ),
        ),
        spaceW10,
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: textNormal(color3D5586, 14.0.textScale()),
          ),
        )
      ],
    );
  }

  Widget textField({required Function(String) onChange}) {
    return TextFormField(
      style: textNormal(color3D5586, 14.0.textScale()),
      initialValue: donVi.noidung,
      onChanged: (value) {
        onChange(value);
      },
      keyboardType: TextInputType.multiline,
      maxLines: 3.0.textScale(space: 3).toInt(),
      minLines: 1.0.textScale(space: 3).toInt(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        isDense: true,
        hintText: S.current.nhap_noi_dung_cong_viec,
        hintStyle: textNormal(textBodyTime, 14.0.textScale()),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderButtomColor),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
    );
  }
}
