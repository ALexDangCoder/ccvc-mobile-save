import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/drop_down_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ban_tin_btn_sheet.dart';
import 'item_tin_radio.dart';
import 'item_tin_trong_nuoc.dart';

enum dropDown { tinRadio, tinTrongNuoc }

class TinTucThoiSuScreen extends StatefulWidget {
  TinTucThoiSuBloc tinTucThoiSuBloc;
  BuildContext pContext;

  TinTucThoiSuScreen(
      {Key? key, required this.tinTucThoiSuBloc, required this.pContext})
      : super(key: key);

  @override
  State<TinTucThoiSuScreen> createState() => _TinTucThoiSuScreenState();
}

class _TinTucThoiSuScreenState extends State<TinTucThoiSuScreen> {
  dropDown? valueChoose = dropDown.tinRadio;

  @override
  void initState() {
    widget.tinTucThoiSuBloc.changeItem(dropDown.tinRadio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: const Color(0xFFDBDFEF))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          elevation: 0,
                          value: valueChoose,
                          onChanged: (value) {
                            setState(() {
                              valueChoose = value as dropDown?;
                              widget.tinTucThoiSuBloc
                                  .changeItem(valueChoose);
                            });
                          },
                          items: <dropDown>[
                            dropDown.tinRadio,
                            dropDown.tinTrongNuoc
                          ]
                              .map<DropdownMenuItem<dropDown>>(
                                  (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value.getString(),
                                          style: textNormalCustom(
                                              color: titleColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ))
                              .toList()),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheet(
                          context: widget.pContext,

                          builder: (context) {
                            return const BanTinBtnSheet();
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      decoration: BoxDecoration(
                        color: indicatorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.icPlay),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            S.current.nghe_doc_tin,
                            style: textNormalCustom(
                                color: indicatorColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return StreamBuilder(
                        stream: widget.tinTucThoiSuBloc.dropDownStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }

                          switch (snapshot.data) {
                            case 1:
                              return ItemTinRadio(
                                  'https://www.elleman.vn/wp-content/uploads/2019/05/20/4-buc-anh-dep-hinh-gau-truc.jpg',
                                  'Bản tin trưa ngày 29 tháng 1 năm 2021',
                                  '5/11/2021  9:10:03 PM');

                            case 2:
                              return ItemTinTrongNuoc(
                                title: 'tienphong.vn ',
                                content:
                                    'Bắc Ninh áp dụng đồng loạt các phương án ngăn ngừa biến chủng Omicron',
                                date: '5/11/2021 9:10:03 PM',
                                imgContent:
                                    'https://baoquocte.vn/stores/news_dataimages/dieulinh/012020/29/15/nhung-buc-anh-dep-tuyet-voi-ve-tinh-ban.jpg',
                                imgTitle:
                                    'https://www.elleman.vn/wp-content/uploads/2019/05/20/4-buc-anh-dep-hinh-gau-truc.jpg',
                              );

                            default:
                              return ItemTinRadio(
                                  'https://www.elleman.vn/wp-content/uploads/2019/05/20/4-buc-anh-dep-hinh-gau-truc.jpg',
                                  'Bản tin trưa ngày 29 tháng 1 năm 2021',
                                  '5/11/2021  9:10:03 PM');
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
