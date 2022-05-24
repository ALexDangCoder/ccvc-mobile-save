import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'chuyen_vb_thanh_giong_noi_state.dart';

class ChuyenVanBanThanhGiongNoiCubit
    extends BaseCubit<ChuyenVBThanhGiongNoiState> {
  ChuyenVanBanThanhGiongNoiCubit() : super(ChuyenVBThanhGiongNoiInitial()) {
    showContent();
  }

  TienIchRepository get tienIchRepTree => Get.find();
  String text = '';
  String? voidTone;
  String url = '';
  bool check = false;
  List<VoidTone> dataDrop = [
    VoidTone(text: S.current.nu_mien_bac, code: north_female_lien),
    VoidTone(text: S.current.nam_mien_bac, code: north_male_hieu),
    VoidTone(text: S.current.nu_mien_bac_ha, code: north_female_hongha),
    VoidTone(text: S.current.nu_mien_nam, code: south_female_aihoa),
    VoidTone(text: S.current.nu_mien_nam_nguyet, code: south_female_minhnguyet),
  ];

  Future<void> chuyenVBSangGiongNoi() async {
    showLoading();
    final result = await tienIchRepTree.chuyenVBSangGiongNoi(
      text,
      voidTone ?? north_female_lien,
    );
    result.when(
      success: (res) {
        showContent();
        check = false;
        playMusic(res.audio_url ?? '').whenComplete(() => check = true);
      },
      error: (error) {
        showError();
      },
    );
  }

  BehaviorSubject<String> textEditingSubject = BehaviorSubject();
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> readFile(
    TextEditingController textEditingController,
  ) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      final File file = File(result.files.single.path ?? '');

      textEditingController.text = file.readAsStringSync();
      textEditingSubject.add(file.readAsStringSync());
    }
  }

  Future<void> playMusic(String url) async {
    final int result = await audioPlayer.play(url);
    if (result == 1) {
    } else {
      await pauseMusic();
    }
  }

  Future<void> pauseMusic() async {
    await audioPlayer.pause();
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
  }
}

class VoidTone {
  String? text;
  String? code;

  VoidTone({this.text, this.code});
}
