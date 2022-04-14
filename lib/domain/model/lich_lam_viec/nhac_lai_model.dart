class NhacLaiModel {
  String? title;
  int? value;

  NhacLaiModel({
    required this.title,
    required this.value,
  });

  NhacLaiModel.seeded({
    this.title = 'Không bao giờ',
    this.value = 1,
  });
}

List<NhacLaiModel> listNhacLai = [
  NhacLaiModel(title: 'Không bao giờ', value: 1),
  NhacLaiModel(title: 'Sau khi tạo lịch', value: 0),
  NhacLaiModel(title: 'Trước 5 phút', value: 5),
  NhacLaiModel(title: 'Trước 10 phút', value: 10),
  NhacLaiModel(title: 'Trước 15 phút', value: 15),
  NhacLaiModel(title: 'Trước 30 phút', value: 30),
  NhacLaiModel(title: 'Trước 1 giờ', value: 60),
  NhacLaiModel(title: 'Trước 2 giờ', value: 120),
  NhacLaiModel(title: 'Trước 12 giờ', value: 720),
  NhacLaiModel(title: 'Trước 1 ngày', value: 1140),
  NhacLaiModel(title: 'Trước 1 tuần', value: 10080),
];
