import 'dart:io';

import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/phien_dich_tu_dong/ui/widget/language_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PhienDichTuDongCubit {

  /// source language
  BehaviorSubject<LANGUAGE> languageSubject =
      BehaviorSubject.seeded(LANGUAGE.vn);

  Stream<LANGUAGE> get languageStream => languageSubject.stream;

  /// length of text by user input
  BehaviorSubject<int> lengthTextSubject = BehaviorSubject.seeded(0);

  Stream<int> get lengthTextStream => lengthTextSubject.stream;

  /// text translated
  BehaviorSubject<String> textTranslateSubject = BehaviorSubject();

  Stream<String> get textTranslateStream => textTranslateSubject.stream;

 /// LANGUAGE VOICE
  String voiceType = VI_VN_VOICE;



  void swapLanguage() {
    if (languageSubject.value == LANGUAGE.vn) {
      languageSubject.add(LANGUAGE.en);
      voiceType = EN_US_VOICE;
    } else {
      languageSubject.add(LANGUAGE.vn);
      voiceType = VI_VN_VOICE;
    }
  }

  String languageEnumToString({bool toSource = true}) {
    /// toSource == true ->  Get source
    ///          == false -> Get target
    if (languageSubject.value == LANGUAGE.vn) {
      return toSource ? 'vi' : 'en';
    } else {
      return toSource ? 'en' : 'vi';
    }
  }

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
      textTranslateSubject.add(file.readAsStringSync());
      await translateDocument(document: file.readAsStringSync());
    }
  }

  TienIchRepository get repo => Get.find();

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> translateDocument({required String document}) async {
    if(document.isEmpty){
      return;
    }
    final rs = await repo.translateDocument(
      document,
      languageEnumToString(toSource: false),
      languageEnumToString(),
    );
    rs.when(
      success: (res) {
        textTranslateSubject.add(res);
      },
      error: (error) {},
    );
  }
}
