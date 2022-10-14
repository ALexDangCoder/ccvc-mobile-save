class CheckIdCardModel {
  final String? requestId;
  final FrontContent? frontContent;
  final BackContent? backContent;

  CheckIdCardModel({
    required this.requestId,
    required this.frontContent,
    required this.backContent,
  });
}

class FrontContent {
  final String? statusCode;
  final FContent? content;

  FrontContent({
    required this.statusCode,
    required this.content,
  });
}

class FContent {
  final String? name;
  final String? gender;
  final String? id;
  final String? doe;
  final String? dob;
  final String? hometown;
  final String? residence;
  final String? nationality;
  final String? ethnicity;

  FContent({
    required this.name,
    required this.gender,
    required this.id,
    required this.doe,
    required this.dob,
    required this.hometown,
    required this.residence,
    required this.nationality,
    required this.ethnicity,
  });
}

class BackContent {
  final String? statusCode;
  final BContent? content;

  BackContent({
    required this.statusCode,
    required this.content,
  });
}

class BContent {
  final String? ethnicity;
  final String? doi;
  final String? poi;

  BContent({
    required this.ethnicity,
    required this.doi,
    required this.poi,
  });
}
