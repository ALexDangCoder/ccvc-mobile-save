import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TepDinhKemMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String idDocument;

  const TepDinhKemMobile({
    Key? key,
    required this.cubit,
    required this.idDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        cubit.getChiTietVanBanDi(idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await cubit.getChiTietVanBanDi(idDocument);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  S.current.phieu_trinh,
                  style: titleText(
                    color: color7966FF,
                    fontSize: 14.0.textScale(),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                stream: cubit.listPhieuTrinh.stream,
                builder: (context, snapshot) {
                  final _list = snapshot.data ?? [];
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return CellTepDinhKem(
                          obj: _list[index],
                          index: 0,
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: 50,
                      child: Text(
                        S.current.khong_co_tep_nao,
                        style: textNormal(
                          colorA2AEBD,
                          14.0.textScale(),
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  S.current.du_thao,
                  style: titleText(
                    color: color7966FF,
                    fontSize: 14.0.textScale(),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                stream: cubit.listDuThao.stream,
                builder: (context, snapshot) {
                  final _list = snapshot.data ?? [];
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return CellTepDinhKem(
                          obj: _list[index],
                          index: 0,
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: 50,
                      child: Text(
                        S.current.khong_co_tep_nao,
                        style: textNormal(
                          colorA2AEBD,
                          14.0.textScale(),
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  S.current.van_ban_ban_hanh_kem_theo_du_an,
                  style: titleText(
                    color: color7966FF,
                    fontSize: 14.0.textScale(),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                stream: cubit.listVBBHKemDuTHao.stream,
                builder: (context, snapshot) {
                  final _list = snapshot.data ?? [];
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return CellTepDinhKem(
                          obj: _list[index],
                          index: 0,
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: 50,
                      child: Text(
                        S.current.khong_co_tep_nao,
                        style: textNormal(
                          colorA2AEBD,
                          14.0.textScale(),
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  S.current.van_ban_lien_thong_khong_ban_hanh_cung,
                  style: titleText(
                    color: color7966FF,
                    fontSize: 14.0.textScale(),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                stream: cubit.listVBLienThong.stream,
                builder: (context, snapshot) {
                  final _list = snapshot.data ?? [];
                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return CellTepDinhKem(
                          obj: _list[index],
                          index: 0,
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: 50,
                      child: Text(
                        S.current.khong_co_tep_nao,
                        style: textNormal(
                          colorA2AEBD,
                          14.0.textScale(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CellTepDinhKem extends StatelessWidget {
  final FileDinhKemVanBanDiModel obj;
  final int index;

  const CellTepDinhKem({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: colorE2E8F0),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                S.current.tep_dinh_kem,
                style: textNormal(
                  color3D5586,
                  14.0.textScale(),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 7,
              child: GestureDetector(
                onTap: () async {
                  final status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                    await Permission.manageExternalStorage.request();
                  }
                  await saveFile(
                    obj.ten ?? '',
                    '$DO_MAIN_DOWLOAD_FILE${obj.duongDan}',
                  )
                      .then(
                        (value) =>
                        MessageConfig.show(
                            title: S.current.tai_file_thanh_cong),
                  )
                      .onError(
                        (error, stackTrace) =>
                        MessageConfig.show(
                          title: S.current.tai_file_that_bai,
                          messState: MessState.error,
                        ),
                  );
                },
                child: Text(
                  obj.ten ?? '',
                  style: textNormal(
                    color5A8DEE,
                    14.0.textScale(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
