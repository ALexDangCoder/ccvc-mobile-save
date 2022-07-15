import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class IssueDropDown extends StatelessWidget {
  final HoTroKyThuatCubit cubit;

  const IssueDropDown({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: S.current.loai_su_co,
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: color3D5586,
                ),
              ),
              TextSpan(
                text: ' *',
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
        spaceH8,
        StreamBuilder<List<String>>(
          stream: cubit.issueListStream,
          builder: (context, snapshot) {
            final _issueList = snapshot.data ?? [];
            return DropdownSearch<String>.multiSelection(
              dropdownSearchBaseStyle: textNormalCustom(
                color: color3D5586,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              showSelectedItems: true,

              emptyBuilder: (context, value)=>Container(),
              items: _issueList,
              mode: Mode.MENU,
              dropdownBuilder: (context, value) {
                Widget item(String i) => Text(
                      '$i,',
                      style: textNormalCustom(
                        color: color3D5586,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                return (value.isEmpty)
                    ? Text(
                        S.current.chon,
                        style: textNormalCustom(
                          color: color3D5586,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Wrap(
                        children: value.map((e) => item(e)).toList(),
                      );
              },
              popupSelectionWidget: (cnt, String item, bool isSelected) {
                return isSelected
                    ? const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: borderColor,
                        ),
                      )
                    : Container();
              },
              onChanged: (value) {
                cubit.loaiSuCoValue = value;
                cubit.addTaskHTKTRequest.danhSachSuCo =
                    cubit.getIdListLoaiSuCo(value);
                cubit.checkShowHintDropDown(value);
              },
              dropdownSearchDecoration: InputDecoration(
                hintText: S.current.chon,
                hintStyle: textNormalCustom(
                  color: titleItemEdit.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: borderColor.withOpacity(0.3),
                filled: false,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: cubit.showErrorLoaiSuCo.stream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      S.current.khong_duoc_de_trong,
                      style: textNormalCustom(
                        color: redChart,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
