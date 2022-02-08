import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChiTietLichLamViecCubit {
  BehaviorSubject<ChiTietLichLamViecModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  Stream<ChiTietLichLamViecModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;

  void initData() {
    ChiTietLichLamViecModel fakeData = ChiTietLichLamViecModel(
        id: '123',
        time: '11:30 AM - 12:00 AM',
        date: '8 tháng 12,2021',
        loaiLich: 'Lịch công tác trong nước',
        listPerSon: fakeDataListPerson(),
        nhacLai: '10 phút sau',
        chuTri: 'Lê Sĩ Lâm - Văn thư',
        linhVuc: 'Xúc tiến thương mại',
        diaDiem: 'UBND huyện',
        noiDung: 'Kế hoạch năm 2022 phát triển công ty');

    chiTietLichLamViecSubject.add(fakeData);
  }

  ListPerSon fakeDataListPerson() {
    ListPerSon fakeDataListPersona = ListPerSon(
        tongSoNguoi: 8,
        soNguoiDongY: 3,
        soNguoiChoXacNhan: 5,
        listPerson: listFake);
    return fakeDataListPersona;
  }

  List<Person> listFake = [
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
  ];
}
