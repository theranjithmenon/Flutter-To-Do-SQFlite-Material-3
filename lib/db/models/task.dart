class TaskModel {
  int? id;
  String? title;
  bool? isDone;

  TaskModel({this.id, this.title, this.isDone});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isDone'] = isDone;
    return data;
  }
}