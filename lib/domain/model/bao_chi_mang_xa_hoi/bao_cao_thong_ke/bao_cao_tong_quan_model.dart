class BaoCaoTongQuanModel {
  int? tongTin = 0;
  int? tichCuc = 0;
  int? tieuCuc = 0;
  int? trungLap = 0;
  int? baoChi = 0;
  int? mangXaHoi = 0;
  int? blog = 0;
  int? forum = 0;
  int? nguonKhac = 0;
  int? like = 0;
  int? share = 0;
  int? comment = 0;

  BaoCaoTongQuanModel({
    this.tongTin,
    this.tichCuc,
    this.tieuCuc,
    this.trungLap,
    this.baoChi,
    this.mangXaHoi,
    this.blog,
    this.forum,
    this.nguonKhac,
    this.like,
    this.share,
    this.comment,
  });
}

class TinTongHopModel {
  double reach;
  double like;
  double share;
  double comment;

  TinTongHopModel({required this.reach, required this.like, required this.share, required this.comment});
}
