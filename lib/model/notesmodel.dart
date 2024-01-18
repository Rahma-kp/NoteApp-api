class NotesModel {
  String? id;
  String? title;
  String? notes;

  NotesModel({this.id, required this.title, required this.notes});
  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
        id: json['id'], title: json['title'], notes: json['notes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notes'] = this.notes;
    return data;
  }
}
