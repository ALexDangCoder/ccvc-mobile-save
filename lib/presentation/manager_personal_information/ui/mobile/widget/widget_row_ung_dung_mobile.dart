import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_row.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetRowUngDungMobile extends StatefulWidget {
  final ManagerPersonalInformationRow row;

  const WidgetRowUngDungMobile({Key? key, required this.row}) : super(key: key);

  @override
  State<WidgetRowUngDungMobile> createState() => _WidgetRowUngDungMobileState();
}

class _WidgetRowUngDungMobileState extends State<WidgetRowUngDungMobile> {
  @override
  Widget build(BuildContext context) {
    final bool isContainer = widget.row.type == TypeRow.status;
    return Column(
      children: [
        spaceH10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                widget.row.title,
                style: textDetailHDSD(
                  fontSize: 12.0.textScale(),
                  color: color586B8B,
                  textHeight: 1.7,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: widget.row.type == TypeRow.text
                  ? Text(
                      '${widget.row.value}',
                      style: textDetailHDSD(
                        fontSize: 12.0.textScale(),
                        color: color3D5586,
                        textHeight: 1.7,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isContainer)
                          Container(
                            decoration: const BoxDecoration(
                              color: color28C76F,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 4,
                                bottom: 4,
                              ),
                              child: Text(
                                widget.row.value,
                                style: tokenDetailAmount(
                                  fontSize: 10.0.textScale(),
                                ),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 18),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, snap) {
                                  return Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      widget.row.value,
                                      style: tokenDetailAmount(
                                        fontSize: 12.0.textScale(),
                                        color: color3D5586,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                      ],
                    ),
            )
          ],
        )
      ],
    );
  }
}
