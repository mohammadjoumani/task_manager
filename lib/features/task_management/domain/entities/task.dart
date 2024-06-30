class Task {
  int id;
  String todo;
  bool completed;
  int userId;
  bool isLoading = false;

  Task(
    this.id,
    this.todo,
    this.completed,
    this.userId,
  );
}
