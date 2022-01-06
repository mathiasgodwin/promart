import 'package:promart/src/features/promart/data/models/add_cart_model.dart';
import 'package:promart/src/features/promart/data/models/all_products_model.dart';
import 'package:promart/src/features/promart/data/models/delete_cart.dart';
import 'package:promart/src/features/promart/data/models/getall_cart_model.dart';
import 'package:promart/src/features/promart/data/models/getall_category_model.dart';
import 'package:promart/src/features/promart/data/models/getall_users_model.dart';
import 'package:promart/src/features/promart/data/models/loging_token_model.dart';
import 'package:promart/src/features/promart/data/models/single_cart_model.dart';
import 'package:promart/src/features/promart/data/models/single_product_model.dart';
import 'package:promart/src/features/promart/data/models/single_user_model.dart';

abstract class IRemoteDataSource {
  Future<AllProductModel> getAllProducts({String sort = 'dsc', String? limit});
  Future<AllProductModel> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'});
  Future<AllCartModel> getAllCarts({String? limit, String sort = 'dsc'});
  Future<AllCartModel> getUserCart({required String userId});
  Future<AllCategoryModel> getAllCategory();
  Future<AllUserModel> getAllUsers();
  Future<SingleProductModel> getSingleProduct({required String productId});
  Future<SingleCartModel> getSingleCart({required String cartId});
  Future<SingleUserModel> getSingleUser({required String userId});
  Future<DeleteCartModel> deleteCart({required String cartId});
  Future<LoginTokenModel> loginUser(
      {required String password, required String username});
  Future<AddCartModel> addCart(
      {required String userId, String? date, List<Map<String, int>> products});

  //
  Future<SingleUserModel> registerUser(
      {String email,
      String username,
      String password,
      String firstname,
      String lastname,
      String city,
      String street,
      String number,
      String lat,
      String long,
      String phone});
  Future<SingleUserModel> updateUser(
      {String? email,
      String? username,
      String? password,
      String? firstname,
      String? lastname,
      String? city,
      String? street,
      String? number,
      String? lat,
      String? long,
      String? phone});
  Future<SingleUserModel> deleteUser({required String userId});
}

