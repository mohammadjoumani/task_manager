class TaskResponseDto {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TaskResponseDto({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  TaskResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  static List<TaskResponseDto> fromJsonList(dynamic jsonList) {
    return (jsonList as List<dynamic>).map((item) => TaskResponseDto.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['todo'] = todo;
    data['completed'] = completed;
    data['userId'] = userId;
    return data;
  }
}
