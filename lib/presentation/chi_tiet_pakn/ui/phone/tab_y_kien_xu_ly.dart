import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/pick_file.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabYKienXuLy extends StatefulWidget {
  const TabYKienXuLy({Key? key}) : super(key: key);

  @override
  State<TabYKienXuLy> createState() => _TabYKienXuLyState();
}

class _TabYKienXuLyState extends State<TabYKienXuLy> {
  late TextEditingController _nhapYkienController;
  late TextEditingController _nhapYMainController;
  int byteToMb = 1048576;
  final Set<PickImageFileModel> _listMain = {};
  final Set<PickImageFileModel> _listYkien = {};
  int size = 0;
  bool isInput = false;

  @override
  void initState() {
    super.initState();
    _nhapYkienController = TextEditingController();
    _nhapYMainController = TextEditingController();
  }

  void addDataListPick(Map<String, dynamic> mediaMap) {
    if (mediaMap.getStringValue(NAME_OF_FILE).isNotEmpty) {
      final _path = mediaMap.getStringValue(PATH_OF_FILE);
      final _name = mediaMap.getStringValue(NAME_OF_FILE);
      final _size = mediaMap.intValue(SIZE_OF_FILE);
      final _extensionName = mediaMap.getStringValue(EXTENSION_OF_FILE);
      _listMain.add(
        PickImageFileModel(
          path: _path,
          name: _name,
          extension: _extensionName,
          size: _size,
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _itemSend(true),
            spaceH16,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _itemViewDetail(
                  sizeImage: 32,
                  list: ['2134', '1234123'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemViewDetail({
    required double sizeImage,
    List<String>? list,
    bool isBorder = true,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: isBorder ? 16 : 0,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorNumberCellQLVB,
        border: Border.all(
          color: isBorder ? borderColor : colorNumberCellQLVB,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://img-cdn.2game.vn/pictures/2game/2019/10/26/2game-Naruto-Slugfest-logo-1.png',
                      width: sizeImage,
                      height: sizeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  spaceW13,
                  Text(
                    'Nguyễn Như Sơn',
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppTheme.getInstance().titleColor(),
                    ), //infoColor
                  ),
                ],
              ),
              Text(
                '05/18/2021 00:00',
                style: textNormalCustom(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: infoColor,
                ),
              ),
            ],
          ),
          spaceH12,
          Text(
            S.current.thong_tin_bo_sung,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceH10,
          Text(
            S.current.van_ban_dinh_kem,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceH6,
          Row(
            children: [
              Text(
                'data',
                style: textNormalCustom(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: textColorMangXaHoi,
                ), //infoColor
              ),
              spaceW16,
              GestureDetector(
                onTap: () {
                  isInput = true;
                  _nhapYMainController.text = '';
                  _listMain.clear();
                  setState(() {});
                },
                child: Text(
                  S.current.phan_hoi,
                  style: textNormalCustom(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: textColorMangXaHoi,
                  ), //infoColor
                ),
              ),
            ],
          ),
          if (list?.isNotEmpty ?? false)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _itemViewDetail(
                  sizeImage: 28,
                  isBorder: false,
                );
              },
            ),
          if (isBorder)
            if (isInput) _itemSend(false),
        ],
      ),
    );
  }

  Widget _itemSend(bool isMain) {
    final Set<PickImageFileModel> list = {};
    if (isMain) {
      list.addAll(_listMain);
    } else {
      list.addAll(_listYkien);
    }
    return Padding(
      padding: EdgeInsets.all(isMain ? 16.0 : 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 303,
            child: Container(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: TextFormField(
                      controller:
                          isMain ? _nhapYMainController : _nhapYkienController,
                      maxLines: 999,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      onTap: () {
                        if (isMain) {
                          isInput = false;
                          _nhapYkienController.text = '';
                          _listYkien.clear();
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final Map<String, dynamic> mediaMap =
                                    await pickImage(fromCamera: true);
                                addDataListPick(mediaMap);
                              },
                              child: SvgPicture.asset(
                                ImageAssets.ic_cam,
                                width: 20,
                                height: 20,
                                color: iconColorDown,
                              ),
                            ),
                            spaceW4,
                            GestureDetector(
                              onTap: () async {
                                final Map<String, dynamic> mediaMap =
                                    await pickFile();
                                addDataListPick(mediaMap);
                              },
                              child: SvgPicture.asset(
                                ImageAssets.ic_file,
                                width: 20,
                                height: 20,
                                color: iconColorDown,
                              ),
                            ),
                          ],
                        ),
                        hintText: S.current.nhap_y_kien_cua_ban,
                        hintStyle: textNormalCustom(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (list.isNotEmpty)
                    Wrap(
                      children: list
                          .map(
                            (i) => _itemPick(
                              i,
                              list,
                            ),
                          )
                          .toList(),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          spaceW16,
          GestureDetector(
            onTap: () {
              for (final PickImageFileModel value in _listMain) {
                size += value.size ?? 0;
              }
              if (size / byteToMb > 30) {
                print('fuck data');
              } else {
                //todo send
              }
            },
            child: SvgPicture.asset(
              ImageAssets.ic_send,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemPick(
    PickImageFileModel objPick,
    Set<PickImageFileModel> list,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        left: 8,
        bottom: 6,
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: grayChart,
        border: Border.all(
          color: blueberryColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 9,
            child: Text(
              objPick.name.toString(),
              style: textNormalCustom(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          spaceW4,
          Expanded(
            child: GestureDetector(
              onTap: () {
                list.remove(objPick);
                setState(() {});
              },
              child: SvgPicture.asset(
                ImageAssets.icClose,
                width: 12,
                height: 12,
                color: fontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
