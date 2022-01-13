import 'package:firebase_auth/firebase_auth.dart';
import 'package:promart/src/features/promart/data/data.dart';

abstract class IPromartRepository {
  /// Firebase Authentication
  Future<void> signOut();
  Future<bool?> isSignedIn();
  Stream<User?> onAuthChange();
  Future<String?> googleSignIn();
  Future<String?> emailSignIn({String? email, String? password});
  Future<String?> emailSignUp({String? email, String? password});
  Future<String?> passwordRecovery({String? email});
  Future<String?> confirmPasswordRecovery({String? code, String? newPassword});
  Future<String?> anonymousSignIn();
  Future<User?> getCurrentUser();

  /// Fakestore API
  Future<AllProductModel?> getAllProducts({String sort = 'dsc', String? limit});

  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'});

  Future<AllCartModel?> getAllCarts({String? limit, String sort = 'dsc'});

  Future<AllCartModel?> getUserCart({required String userId});

  Future<AllCategoryModel?> getAllCategory();

  Future<AllUserModel?> getAllUsers();

  Future<SingleProductModel?> getSingleProduct({required String productId});

  Future<SingleCartModel?> getSingleCart({required String cartId});

  Future<SingleUserModel?> getSingleUser({required String userId});

  Future<DeleteCartModel?> deleteCart({required String cartId});

  Future<LoginTokenModel?> loginUser(
      {required String password, required String username});

  Future<AddCartModel?> addCart({required AddCartModel carts});

  //
  Future<SingleUserModel?> registerUser({required SingleUserModel user});

  Future<SingleUserModel?> updateUser({required SingleUserModel user});

  Future<SingleUserModel?> deleteUser({required String userId});
}
