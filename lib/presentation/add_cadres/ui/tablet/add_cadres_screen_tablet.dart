import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/add_cadres/ui/tablet/widgets/item_cadres_tablet.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_textfield.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddCadresTablet extends StatefulWidget {
  const AddCadresTablet({Key? key}) : super(key: key);



  @override
  _AddCadresTabletState createState() => _AddCadresTabletState();
}

class _AddCadresTabletState extends State<AddCadresTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.them_can_bo,
                    style: textNormalCustom(fontSize: 20, color: textTitle),
                  ),
                  SvgPicture.asset(ImageAssets.icClose),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(S.current.donvi_phongban, style: textNormal(infoColor, 16)),
              const SizedBox(
                height: 10,
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
                        style: textNormal(textTitle, 16),
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
                height: 24,
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
                height: 16,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ItemCadresTablet(ten: '1', chucVu: '2');
                  },
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 124,
                    child: ButtonCustomBottom(
                      isColorBlue: false,
                      title: S.current.dong,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 124,
                    child: ButtonCustomBottom(
                      isColorBlue: true,
                      title: S.current.them,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
