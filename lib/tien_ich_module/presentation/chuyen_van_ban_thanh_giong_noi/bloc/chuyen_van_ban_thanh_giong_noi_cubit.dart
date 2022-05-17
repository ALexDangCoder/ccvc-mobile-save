import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ChuyenVanBanThanhGiongNoiCubit {
  TienIchRepository get tienIchRepTree => Get.find();
  String text = '';
  String voidTone = '';
  String url = '';

  List<VoidTone> dataDrop = [
    VoidTone(text: S.current.nu_mien_bac, code: north_female_lien),
    VoidTone(text: S.current.nam_mien_bac, code: north_male_hieu),
    VoidTone(text: S.current.nu_mien_bac, code: north_female_hongha),
    VoidTone(text: S.current.nu_mien_nam, code: south_female_aihoa),
    VoidTone(text: S.current.nu_mien_nam_nguyet, code: south_female_minhnguyet),
  ];

  Future<void> chuyenVBSangGiongNoi() async {
    final result = await tienIchRepTree.chuyenVBSangGiongNoi(text, voidTone);
    result.when(
      success: (res) {
        playMusic(res.audio_url ?? '');
      },
      error: (error) {},
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

  playMusic(String url) async {
    final int result = await audioPlayer.play(url);
    if (result == 1) print('suc xet');
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }
}

class VoidTone {
  String? text;
  String? code;

  VoidTone({this.text, this.code});
}
