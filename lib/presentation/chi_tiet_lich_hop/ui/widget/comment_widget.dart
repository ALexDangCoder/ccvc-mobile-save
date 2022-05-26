import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/send_comment_widget_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;
  final YkienCuocHopModel object;

  const CommentWidget(
      {Key? key, required this.object, required this.cubit, required this.id})
      : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late bool showRecoment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showRecoment = true;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.object.traLoiYKien ?? [];
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: toDayColor.withOpacity(0.1),
          border: Border.all(
            color: toDayColor.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(8.0.textScale(space: 4.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.textScale(space: 4.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              YkienWidget(
                nguoiTao: widget.object.nguoiTao ?? '',
                ngayTao: widget.object.ngayTao ?? '',
                content: widget.object.content ?? '',
              ),
              SizedBox(
                height: 16.0.textScale(space: 4.0),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    showRecoment = !showRecoment;
                    setState(() {});
                  },
                  child: Text(
                    showRecoment ? 'Ẩn' : 'Hiện',
                    style: textNormalCustom(
                      color: color3D5586,
                      fontSize: 14.0.textScale(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (showRecoment)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 48, bottom: 16),
                      child: YkienWidget(
                        nguoiTao: data[index].nguoiTao ?? '',
                        ngayTao: data[index].ngayTao ?? '',
                        content: data[index].content ?? '',
                      ),
                    );
                  },
                ),
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: SendCommentWidgetLichHop(
                  isReComment: true,
                  onSendComment: (vl) {
                    widget.cubit.themYKien(
                      idLichHop: widget.id,
                      yKien: vl,
                      scheduleOpinionId: widget.object.id ?? '',
                      phienHopId: '',
                    );
                    widget.cubit.getDanhSachYKien(
                      widget.id,
                      widget.cubit.getPhienHopId,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget YkienWidget({
    required String nguoiTao,
    required String ngayTao,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                nguoiTao,
                style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // const Spacer(),
            const SizedBox(
              width: 6,
            ),
            Text(
              ngayTao,
              style: textNormalCustom(
                color: infoColor,
                fontSize: 12.0.textScale(space: 4.0),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          content,
          style: textNormalCustom(
            color: color3D5586,
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
