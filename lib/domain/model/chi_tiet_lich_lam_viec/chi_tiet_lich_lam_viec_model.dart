import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class ChiTietLichLamViecModel {
  String id = '';
  String time = '';
  String date = '';
  String loaiLich = '';

  ListPerSon listPerSon = ListPerSon.Empty();

  String nhacLai = '';

  String chuTri = '';
  String linhVuc = '';
  String diaDiem = '';
  String noiDung = '';

  ChiTietLichLamViecModel.Empty();

  ChiTietLichLamViecModel ({
    required this.id,
    required this.time,
    required this.date,
    required this.loaiLich,
    required this.listPerSon,
    required this.nhacLai,
    required this.chuTri,
    required this.linhVuc,
    required this.diaDiem,
    required this.noiDung,
  });
  
  List<TypeData> dataRow() {
    List<TypeData> list = [
      TypeData(icon: ImageAssets.icNhacLai, value: time, type: typeData.text),
      TypeData(icon: ImageAssets.icCalendarUnFocus, value: date, type: typeData.text),
      TypeData(icon: ImageAssets.icCalendarUnFocus, value: loaiLich, type: typeData.text),
      TypeData(icon: ImageAssets.icDoublePerson, value: listPerSon, type: typeData.listperson),
      TypeData(icon: ImageAssets.icNhacLai, value: nhacLai, type: typeData.text),
      TypeData(icon: ImageAssets.icPerson, value: chuTri, type: typeData.text),
      TypeData(icon: ImageAssets.icWork, value: linhVuc, type: typeData.text),
      TypeData(icon: ImageAssets.icViTri, value: diaDiem, type: typeData.text),
      TypeData(icon: ImageAssets.icDocument, value: noiDung, type: typeData.text),
    ];
    
    return list;
  }
}

class ListPerSon {
  int tongSoNguoi = 0;
  int soNguoiDongY = 0;
  int soNguoiChoXacNhan = 0;
  List<Person> listPerson = [];

  ListPerSon.Empty();

  ListPerSon({
    required this.tongSoNguoi,
    required this.soNguoiDongY,
    required this.soNguoiChoXacNhan,
    required this.listPerson,
  });
}

class Person {
  Color color = Colors.red;
  String name = '';
  bool isConnect = false;

  Person.Empty();

  Person({
    required this.color,
    required this.name,
    required this.isConnect,
  });
}

enum typeData {text, listperson}

class TypeData {
  String icon;
  dynamic value;
  typeData type;

  TypeData({required this.icon, required this.value, required this.type});
}
