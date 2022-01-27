import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PeopleThamGiaWidget extends StatelessWidget {
  final DonViModel donVi;
  final ThanhPhanThamGiaCubit cubit;
  const PeopleThamGiaWidget({
    Key? key,
    required this.donVi,
    required this.cubit,
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
              rowInfo(value: donVi.name, key: S.current.dv_phoi_hop),
              spaceH10,
              rowInfo(value: donVi.tenCanBo, key: S.current.nguoi_pho_hop),
              spaceH10,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      S.current.noi_dung,
                      style: textNormal(infoColor, 14),
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
          flex: 2,
          child: Text(
            key,
            style: textNormal(infoColor, 14),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: textNormal(titleColor, 14),
          ),
        )
      ],
    );
  }

  Widget textField({required Function(String) onChange}) {
    return TextField(
      style: textNormal(titleColor, 14),
      onChanged: (value) {
        onChange(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        isDense: true,
        hintText: S.current.nhap_noi_dung_cong_viec,
        hintStyle: textNormal(textBodyTime, 14),
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
