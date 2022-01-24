import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/Cadres/CadresModel.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/add_cadres/bloc/add_cadres__state.dart';
import 'package:ccvc_mobile/presentation/add_cadres/bloc/add_cadres_cubit.dart';
import 'package:ccvc_mobile/presentation/add_cadres/ui/tablet/widgets/item_cadres_tablet.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCadres extends StatefulWidget {
  const AddCadres({Key? key}) : super(key: key);

  @override
  _AddCadresState createState() => _AddCadresState();
}

class _AddCadresState extends State<AddCadres> {
  AddCadresCubit cubit=AddCadresCubit(MainStateInitial());
  @override
  void initState() {
    super.initState();
    cubit.callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ButtonCustomBottom(
                isColorBlue: false,
                title: S.current.dong,
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ButtonCustomBottom(
                isColorBlue: true,
                title: S.current.them,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(12),
        //   border: Border.all(),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset(ImageAssets.icLineBox)),
            const SizedBox(
              height: 22,
            ),
            Text(S.current.chon_thanh_phan_tham_gia, style: titleAppbar()),
            const SizedBox(
              height: 20,
            ),
            Text(
              S.current.donvi_phongban,
              style: textNormal(titleItemEdit, 14),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UBND DONG NAI',
                      style: textNormal(textTitle, 14),
                    ),
                    SvgPicture.asset(
                      ImageAssets.icEditInfor,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              S.current.danh_sach_don_vi_tham_gia,
              style: textNormal(textTitle, 16),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              isPass: false,
              textHint: S.current.nhap_donvi_phongban,
              prefixIcon: SvgPicture.asset(ImageAssets.ic_KinhRong),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: StreamBuilder<List<CadresModel>>(
                    stream: cubit.getListCadres,
                    builder: (context,snapshot){
                      final List<CadresModel>listData=snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount:listData.length,
                        itemBuilder: (context,index){
                          return ItemCadresTablet(ten: listData[index].ten,
                              chucVu:listData[index].chuVu,);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
