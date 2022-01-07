import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'item_tin_radio.dart';
import 'item_tin_trong_nuoc.dart';

class TinTucThoiSuScreen extends StatefulWidget {
  TinTucThoiSuBloc tinTucThoiSuBloc;

  TinTucThoiSuScreen({Key? key, required this.tinTucThoiSuBloc})
      : super(key: key);

  @override
  State<TinTucThoiSuScreen> createState() => _TinTucThoiSuScreenState();
}

class _TinTucThoiSuScreenState extends State<TinTucThoiSuScreen> {
  String? valueChoose = 'Tin radio';


  @override
  void initState() {
    widget.tinTucThoiSuBloc.changeItem('Tin radio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
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
                                  valueChoose = value as String?;
                                  widget.tinTucThoiSuBloc
                                      .changeItem(valueChoose);
                                });
                              },
                              items: <String>['Tin radio', 'Tin trong nước']
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value,
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: indicatorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icPlay),
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
                  ],
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                                  'ascascafgasdf',
                                  'asdasdasdaseaw');

                            case 2:
                              return ItemTinTrongNuoc(
                                title: 'asdfascmnoasfcasfsad',
                                content: 'asdadadfasvcasvafsadasd',
                                date: 'sacfagvasdfasfdad',
                                imgContent:
                                    'https://baoquocte.vn/stores/news_dataimages/dieulinh/012020/29/15/nhung-buc-anh-dep-tuyet-voi-ve-tinh-ban.jpg',
                                imgTitle:
                                    'https://www.elleman.vn/wp-content/uploads/2019/05/20/4-buc-anh-dep-hinh-gau-truc.jpg',
                              );

                            default:
                              return ItemTinRadio(
                                  'https://www.elleman.vn/wp-content/uploads/2019/05/20/4-buc-anh-dep-hinh-gau-truc.jpg',
                                  'ascascafgasdf',
                                  'asdasdasdaseaw');
                          }
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
