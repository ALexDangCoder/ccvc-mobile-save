import 'package:flutter/cupertino.dart';

enum TypeRow { checkbox, text, status, list, file }

class ManagerPersonalInformationRow {
  String title = '';
  dynamic value;
  TypeRow type = TypeRow.text;

  ManagerPersonalInformationRow(this.title, this.value, this.type);

  ManagerPersonalInformationRow.managerDefault(
    this.title,
    this.value,
  );
}
