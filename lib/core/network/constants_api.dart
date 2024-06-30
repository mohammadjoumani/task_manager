class ConstantsApi {
  static String baseUrl = 'https://dummyjson.com/';

  //Api Auth
  static String loginUrl = '${baseUrl}auth/login';
  static String refreshTokenUrl = '${baseUrl}auth/refresh';

  //Add
  //'POST'
  //'https://dummyjson.com/todos/add'

  // Api Todos
  static String todosUrl = '${baseUrl}todos';
  static String addTodoUrl = '${baseUrl}todos/add';
  static String updateTodoUrl = '${baseUrl}todos';

  static String getAllUsersUrl = '${baseUrl}users';
}
