import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/item_person_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowValueWidget extends StatefulWidget {
  final TypeData row;
  final bool isTablet;
  final bool isMarinLeft;

  const RowValueWidget({
    Key? key,
    required this.row,
    required this.isTablet,
    this.isMarinLeft = false,
  }) : super(key: key);

  @override
  State<RowValueWidget> createState() => _RowValueWidgetState();
}

class _RowValueWidgetState extends State<RowValueWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.row.type == typeData.text
          ? rowData(row: widget.row, isMarinleft: widget.isMarinLeft)
          : widget.isTablet
              ? ColumnDataTablet(
                  row: widget.row,
                )
              : ColumnData(row: widget.row),
    );
  }
}

Widget rowData({
  required TypeData row,
  bool isMarinleft = false,
}) {
  return Row(
    children: [
      SizedBox(
        height: 15.0.textScale(),
        width: 15.0.textScale(),
        child: SvgPicture.asset(row.icon),
      ),
      SizedBox(
        width: 16.0.textScale(),
      ),
      Text(
        row.value,
        style: textNormalCustom(
          color: textTitle,
          fontWeight: FontWeight.w400,
          fontSize: 16.0.textScale(),
        ),
      ),
      if (isMarinleft)
        const SizedBox(
          width: 37,
        )
      else
        Container(),
    ],
  );
}

class ColumnDataTablet extends StatefulWidget {
  final TypeData row;

  const ColumnDataTablet({Key? key, required this.row}) : super(key: key);

  @override
  _ColumnDataTabletState createState() => _ColumnDataTabletState();
}

class _ColumnDataTabletState extends State<ColumnDataTablet> {
  late ListPerSon data;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    data = widget.row.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 15.0.textScale(),
              width: 15.0.textScale(),
              child: SvgPicture.asset(widget.row.icon),
            ),
            SizedBox(
              width: 16.0.textScale(),
            ),
            Text(
              '${data.tongSoNguoi} người',
              style: textNormalCustom(
                color: textTitle,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        TitleRow(
          icon: ImageAssets.icTickCircle,
          number: 'Tham gia: ${data.soNguoiDongY}',
          listPerson: data.listPerson
              .where((element) => element.isConnect == true)
              .toList(),
        ),
        const SizedBox(
          height: 33.0,
        ),
        TitleRow(
          icon: ImageAssets.icQuestionCircle,
          number: 'Chờ duyệt: ${data.soNguoiChoXacNhan}',
          listPerson: data.listPerson
              .where((element) => element.isConnect == false)
              .toList(),
        )
      ],
    );
  }
}

class TitleRow extends StatefulWidget {
  final String icon;
  final String number;
  final List<Person> listPerson;

  const TitleRow({
    Key? key,
    required this.icon,
    required this.number,
    required this.listPerson,
  }) : super(key: key);

  @override
  _TitleRowState createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> {
  bool isExpand = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(widget.icon),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  widget.number,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                isExpand = !isExpand;
                setState(() {});
              },
              child: Icon(
                isExpand
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_outlined,
                color: AqiColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        ExpandedSection(
            expand: isExpand,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listPerson.length,
              itemBuilder: (context, index) => ItemPersonWidget(
                color: widget.listPerson[index].color,
                name: widget.listPerson[index].name,
                isConnect: widget.listPerson[index].isConnect,
              ),
            )),
      ],
    );
  }
}

class ColumnData extends StatefulWidget {
  final TypeData row;

  const ColumnData({Key? key, required this.row}) : super(key: key);

  @override
  _ColumnDataState createState() => _ColumnDataState();
}

class _ColumnDataState extends State<ColumnData> {
  late ListPerSon data;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    data = widget.row.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 15.0.textScale(),
              width: 15.0.textScale(),
              child: SvgPicture.asset(widget.row.icon),
            ),
            SizedBox(
              width: 16.0.textScale(),
            ),
            Text(
              '${data.tongSoNguoi} người',
              style: textNormalCustom(
                color: textTitle,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.5.textScale(),
        ),
        Container(
          margin: EdgeInsets.only(left: 31.0.textScale()),
          child: Text(
            '${data.soNguoiDongY} người đồng ý, ${data.soNguoiChoXacNhan} số người chờ xác nhận',
            style: textNormalCustom(
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w400,
              color: colorA2AEBD,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 31.0.textScale()),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isShow ? data.listPerson.length : 5,
                itemBuilder: (context, index) => Column(
                  children: [
                    ItemPersonWidget(
                      color: data.listPerson[index].color,
                      name: data.listPerson[index].name,
                      isConnect: data.listPerson[index].isConnect,
                    ),
                  ],
                ),
              ),
              if (!isShow)
                if (data.listPerson.length - 5 > 0)
                  GestureDetector(
                    onTap: () {
                      isShow = !isShow;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.0.textScale(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icTreePerson),
                            SizedBox(
                              width: 18.0.textScale(),
                            ),
                            Text(
                              'Khối chuyển đổi số (${data.listPerson.length - 5})',
                              style: textNormalCustom(
                                color: textTitle,
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 22.0.textScale(),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  Container()
              else
                Container(),
            ],
          ),
        )
      ],
    );
  }
}
