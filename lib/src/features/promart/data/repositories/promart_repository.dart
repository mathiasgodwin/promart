import 'package:errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:promart/src/features/promart/domain/domain.dart';

class PromartRepository implements IPromartRepository {
  PromartRepository({required IRemoteDataSource dataSource})
      : _dataSource = dataSource;

  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  final IRemoteDataSource _dataSource;

  /// Firebase Authentication
  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } catch (e) {
      throw ServerFailure();
    }
  }

  

  @override
  Future<String?> confirmPasswordRecovery(
      {String? code, String? newPassword}) async {
    try {
      final response = await _dataSource.confirmPasswordRecovery(
          code: code, newPassword: newPassword);
      return response;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<String?> emailSignIn({String? email, String? password}) async {
    try {
      final response =
          await _dataSource.emailSignIn(email: email, password: password);
      return response;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<String?> emailSignUp({String? email, String? password}) async {
    try {
      final response =
          await _dataSource.emailSignUp(email: email, password: password);
      return response;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<String?> googleSignIn() async {
    try {
      await _dataSource.googleSignIn();
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<bool?> isSignedIn() async {
    try {
      final response = await _dataSource.isSignedIn();
      return response;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Stream<User?> onAuthChange() {
    try {
      final response = _dataSource.onAuthChange();
      return response;
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }

  @override
  Future<String?> passwordRecovery({String? email}) async {
    try {
      final response = await _dataSource.passwordRecovery(email: email);
      return response;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return user;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  /// Fakestore API
  @override
  Future<AddCartModel?> addCart({required AddCartModel carts}) async {
    try {
      final response = await _dataSource.addCart(carts: carts);
      return response;
    } catch (e) {
      throw Exception('AddCart Exception:');
    }
  }

  @override
  Future<DeleteCartModel?> deleteCart({required String cartId}) async {
    try {
      final response = await _dataSource.deleteCart(cartId: cartId);
      return response;
    } catch (e) {
      throw Exception('DeleteCart Exception:');
    }
  }

  @override
  Future<SingleUserModel?> deleteUser({required String userId}) async {
    try {
      final response = await _dataSource.deleteUser(userId: userId);
      return response;
    } catch (e) {
      throw Exception('DeleteUser Exception:');
    }
  }

  @override
  Future<AllCartModel?> getAllCarts(
      {String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _dataSource.getAllCarts(limit: limit, sort: sort);
      return response;
    } catch (e) {
      throw Exception('GetAllCarts Exception:');
    }
  }

  @override
  Future<AllCategoryModel?> getAllCategory() async {
    try {
      final response = await _dataSource.getAllCategory();
      return response;
    } catch (e) {
      throw Exception('GetAllCategory Exception:');
    }
  }

  @override
  Future<AllProductModel?> getAllProducts(
      {String sort = 'dsc', String? limit}) async {
    try {
      final response =
          await _dataSource.getAllProducts(sort: sort, limit: limit);
      return response;
    } catch (e) {
      throw Exception('GetAllProducts Exception:');
    }
  }

  @override
  Future<AllUserModel?> getAllUsers() async {
    try {
      final response = await _dataSource.getAllUsers();
      return response;
    } catch (e) {
      throw Exception('GetAllUsers Exception:');
    }
  }

  @override
  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _dataSource.getCategoryProduct(
          category: category, limit: limit, sort: sort);
      return response;
    } catch (e) {
      throw Exception('GetCategory Exception:');
    }
  }

  @override
  Future<SingleCartModel?> getSingleCart({required String cartId}) async {
    try {
      final response = await _dataSource.getSingleCart(cartId: cartId);
      return response;
    } catch (e) {
      throw Exception('GetSingleCart Exception:');
    }
  }

  @override
  Future<SingleProductModel?> getSingleProduct(
      {required String productId}) async {
    try {
      final response = await _dataSource.getSingleProduct(productId: productId);
      return response;
    } catch (e) {
      throw Exception('GetSingleProduct Exception:');
    }
  }

  @override
  Future<SingleUserModel?> getSingleUser({required String userId}) async {
    try {
      final response = await _dataSource.getSingleUser(userId: userId);
      return response;
    } catch (e) {
      throw Exception('GetSingleUser Exception:');
    }
  }

  @override
  Future<AllCartModel?> getUserCart({required String userId}) async {
    try {
      final response = await _dataSource.getUserCart(userId: userId);
      return response;
    } catch (e) {
      throw Exception('GetUserCart Exception:');
    }
  }

  @override
  Future<LoginTokenModel?> loginUser(
      {required String password, required String username}) async {
    try {
      final response =
          await _dataSource.loginUser(password: password, username: username);
      return response;
    } catch (e) {
      throw Exception('LoginUser Exception:');
    }
  }

  @override
  Future<SingleUserModel?> registerUser({required SingleUserModel user}) async {
    try {
      final response = await _dataSource.registerUser(user: user);
      return response;
    } catch (e) {
      throw Exception('RegisterUser Exception:');
    }
  }

  @override
  Future<SingleUserModel?> updateUser({required SingleUserModel user}) async {
    try {
      final response = await _dataSource.updateUser(user: user);
      return response;
    } catch (e) {
      throw Exception('UpdateUser Exception:');
    }
  }
}
