import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ThongTinLienHeWidget extends StatelessWidget {
  final String thongTinTxt;
  final String sdtTxt;
  final List<DsDiemCau> dsDiemCau;
  final List<FilesChiTietHop> thuMoiFiles;

  const ThongTinLienHeWidget({
    Key? key,
    this.thongTinTxt = '',
    this.sdtTxt = '',
    required this.dsDiemCau,
    required this.thuMoiFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.thong_tin_lien_he,
          style: textNormalCustom(color: infoColor, fontSize: 16),
        ),
        SizedBox(height: 16.0.textScale(space: 8)),

        /// tên người
        RowDataWidget(
          text: thongTinTxt,
          urlIcon: ImageAssets.icPeople,
        ),
        SizedBox(height: 16.0.textScale(space: 8)),

        /// số điện thoại
        RowDataWidget(
          urlIcon: ImageAssets.icCalling,
          text: sdtTxt,
        ),
        SizedBox(
          height: 16.0.textScale(space: 8),
        ),

        /// xem điểm cầu
        if (dsDiemCau.isNotEmpty) ...[
          GestureDetector(
            onTap: () {
              showBottomSheetCustom(
                context,
                title: S.current.danh_sach_diem_cau,
                child: _xemDiemCau(
                  listData: dsDiemCau,
                  context: context,
                ),
              );
            },
            child: RowDataWidget(
              urlIcon: ImageAssets.icDiemCau,
              text: S.current.xem_diem_cau,
              styleText: textNormalCustom(
                fontSize: 16,
                color: AppTheme.getInstance().colorField(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 16.0.textScale(space: 8),
          ),
        ],

        /// thư mời
        if (thuMoiFiles.isNotEmpty) ...[
          RowDataWidget(
            urlIcon: ImageAssets.icThuMoiHop,
            onTab: () {
              saveFile(
                fileName: thuMoiFiles.first.name ?? '',
                url: thuMoiFiles.first.path ?? '',
              );
            },
            text: thuMoiFiles.first.name ?? '',
            styleText: textNormalCustom(
              fontSize: 16,
              color: blueNhatChart,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 16.0.textScale(space: 8),
          ),
        ]
      ],
    );
  }

  Widget _xemDiemCau({
    required List<DsDiemCau> listData,
    required BuildContext context,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: listData.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: NodataWidget(),
                    )
                  : Column(
                      children: listData
                          .map((e) => _itemDiemCau(listData: e.rowData))
                          .toList(),
                    ),
            ),
          ),
          spaceH20,
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: color7966FF.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  S.current.dong,
                  style: textNormalCustom(
                    color: color7966FF,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0.textScale(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemDiemCau({
    required List<ModelDataDiemCau> listData,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0.textScale()),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorE2E8F0.withOpacity(0.1),
        border: Border.all(color: colorE2E8F0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: listData
            .map(
              (e) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        e.key,
                        style: textNormalCustom(
                          color: color_667793,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.textScale(),
                        ),
                      ),
                    ),
                    spaceW15,
                    Expanded(
                      flex: 6,
                      child: Text(
                        e.value,
                        style: textNormalCustom(
                          color: color3D5586,
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
