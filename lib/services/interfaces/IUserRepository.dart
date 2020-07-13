import '../../models/entities/user.dart';
import '../../models/entities/rank.dart';
import '../../models/entities/user.dart';

abstract class IUserRepository {
  Future<User> loadUserData();
  // Future<List<Passport>> loadUserData();


}
