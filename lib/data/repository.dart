import 'models/user_model.dart';
import 'network_service.dart';

class Repository {
  final NetworkService networkService;
  Repository({required this.networkService});

  Future<List<User>> getAllUser() async {
    final userList = await networkService.getAllUser();
    return userList.map((e) => User.fromJson(e)).toList();
  }
}
