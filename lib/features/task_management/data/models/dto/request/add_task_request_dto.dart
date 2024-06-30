class AddTaskRequestDto {
  String todo;
  bool isCompleted;
  int userId;

  AddTaskRequestDto({
    required this.todo,
    required this.isCompleted,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'todo': todo,
        'completed': isCompleted,
        'userId': userId,
      };
}
