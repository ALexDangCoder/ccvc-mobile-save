import 'dart:io';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/nhan_dien_khuon_mat_ui_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/select_image.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemImageWidget extends StatefulWidget {
  final NhanDienKhuonMatUIModel dataUI;
  final DiemDanhCubit cubit;
  final String? initImage;
  String? id;
  final ImagePermission imagePermission;

  ItemImageWidget({
    Key? key,
    required this.dataUI,
    required this.cubit,
    this.initImage,
    required this.id,
    required this.imagePermission,
  }) : super(key: key);

  @override
  State<ItemImageWidget> createState() => _ItemImageWidgetState();
}

class _ItemImageWidgetState extends State<ItemImageWidget> {
  File? imageRepo;
  String idImage = '';
  String id ='';

  @override
  void initState() {
    super.initState();
    imageRepo = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.goc_anh,
            style: textNormalCustom(
              fontSize: 16.0.textScale(),
              fontWeight: FontWeight.w500,
              color: color3D5586,
            ),
          ),
          spaceH14,
          Text(
            widget.dataUI.title,
            style: textNormalCustom(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: color667793,
            ),
          ),
          spaceH16,
          SizedBox(
            height: 164.0.textScale(space: 56.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Container(
                          height: 164.0.textScale(space: 56.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorE2E8F0),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(widget.dataUI.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: color3D5586.withOpacity(0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2,
                            ),
                            child: Text(
                              S.current.anh_mau,
                              style: textNormalCustom(color: colorFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spaceW16,
                Expanded(
                  child: StreamBuilder<int>(
                    stream: widget.cubit.codeCheckAi.stream,
                    builder: (context, snapshot) {
                      final codeCheckAi = snapshot.data ?? 0;
                      if(codeCheckAi==400){
                        imageRepo=null;
                      }
                      return SelectImageWidget(
                        imagePermission: widget.imagePermission,
                        image: imageRepo == null
                            ? widget.initImage
                            : widget.cubit.getUrlImage(
                                fileTypeUpload: widget.dataUI.fileTypeUpload,
                                entityName: widget.dataUI.entityName,
                                id: idImage,
                              ),
                        imageLocal: imageRepo,
                        removeImage: () {
                          widget.cubit.deleteImageCallApi(widget.id ?? id );
                          widget.cubit.xoaAnhAI(widget.id ?? id );
                          idImage = '';
                        },
                        onTapImage: (image) async {
                          imageRepo = image;
                          if (image != null) {
                            idImage = await widget.cubit.postImage(
                              image,
                            );
                            id = await widget.cubit.createImage(
                              fileId: idImage,
                              loaiGocAnh: widget.dataUI.fileTypeUpload,
                              loaiAnh: widget.dataUI.entityName,
                            );
                            setState(() {
                            });
                          }
                        },
                        loaiGocAnh: widget.dataUI.title,
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
