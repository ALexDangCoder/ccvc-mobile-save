enum TypeDocumentDetailRow { checkbox, text, fileActacks, status }

class DocumentDetailRow {
  String title = '';
  dynamic value;
  TypeDocumentDetailRow type = TypeDocumentDetailRow.text;

  DocumentDetailRow(this.title, this.value, this.type);

  DocumentDetailRow.DocumentDefault(
    this.title,
    this.value,
  );
}
