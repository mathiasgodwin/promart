import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:promart/promart.dart';

import 'package:logger/logger.dart';

import 'dart:convert';

abstract class IRemoteDataSource {
  Future<bool> isSignedIn();

  Future<String?> googleSignIn();

  Future<String?> emailSignIn({String? email, String? password});

  Future<String?> emailSignUp({String? email, String? password});

  Future<String?> passwordRecovery({String? email});

  Future<String?> confirmPasswordRecovery({String? code, String? newPassword});
  Stream<User> get user;
  User get currentUser;

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

class RemoteDataSource implements IRemoteDataSource {
  final CacheClient _cache = CacheClient();

  final _client = Dio();
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  /// User cache key.
  /// Should only be used for testing purposes.
  static const userCacheKey = '__user_cache_key__';

  /// Firebase Authentication

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  @override
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<String?> googleSignIn() async {
    await _googleSignIn.signOut();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<String?> emailSignIn({String? email, String? password}) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      // return userCredential;
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<String?> emailSignUp({String? email, String? password}) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<String?> passwordRecovery({String? email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw PasswordRecoveryFailure.fromCode(e.code);
    } catch (e) {
      throw const PasswordRecoveryFailure();
    }
  }

  @override
  Future<String?> confirmPasswordRecovery(
      {String? code, String? newPassword}) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
          code: code!, newPassword: newPassword!);
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw ConfirmPasswordRecoveryFailure.fromCode(e.code);
    } catch (e) {
      throw const ConfirmPasswordRecoveryFailure();
    }
  }

  /// Fakestore API
  @override
  Future<AddCartModel?> addCart({required AddCartModel carts}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts',
          method: 'POST',
          data: carts.toMap(),
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        return AddCartModel.fromJson(response.data);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Add to cart Error');
      }
    }
  }

  @override
  Future<DeleteCartModel?> deleteCart({required String cartId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/$cartId',
          method: 'DELETE',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return DeleteCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Delete Cart Error');
      }
    }
  }

  @override
  Future<SingleUserModel?> deleteUser({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users/$userId',
          method: 'DELETE',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Delete user error');
      }
    }
  }

  @override
  Future<AllCartModel?> getAllCarts(
      {String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Get All carts error');
      }
    }
  }

  @override
  Future<AllCategoryModel?> getAllCategory() async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/products/categories',
          method: 'GET',
          sendTimeout: 10000 ~/ 2,
          receiveTimeout: 10000 ~/ 2,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        return AllCategoryModel.fromJson(response.data);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Get all category error');
      }
    }
  }

  @override
  Future<AllProductModel?> getAllProducts(
      {String sort = 'dsc', String? limit}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path:
              'https://fakestoreapi.com/products?sort=$sort&limit=${limit ?? 20}',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllProductModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not load available products');
      }
    }
  }

  @override
  Future<AllUserModel?> getAllUsers() async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Error getting users');
      }
    }
  }

  @override
  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path:
              'https://fakestoreapi.com/products/category/$category?sort=$sort ${limit == null ? '' : '&limit=' + limit}',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllProductModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request');
      }
    }
  }

  @override
  Future<SingleCartModel?> getSingleCart({required String cartId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/$cartId',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request, check connection');
      }
    }
  }

  @override
  Future<SingleProductModel?> getSingleProduct(
      {required String productId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/products/$productId',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleProductModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request');
      }
    }
  }

  @override
  Future<SingleUserModel?> getSingleUser({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users/$userId',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Unable to send request');
      }
    }
  }

  @override
  Future<AllCartModel?> getUserCart({required String userId}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/carts/user/$userId',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('The request was unsuccessful, try again!');
      }
    }
  }

  @override
  Future<LoginTokenModel?> loginUser(
      {required String password, required String username}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/auth/login',
          data: json.encode({'username': username, 'password': password}),
          method: 'POST',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return LoginTokenModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Login error');
      }
    }
  }

  @override
  Future<SingleUserModel?> registerUser({required SingleUserModel user}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
          method: 'POST',
          data: user.toMap(),
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not make request');
      }
    }
  }

  @override
  Future<SingleUserModel?> updateUser({required SingleUserModel user}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: 'https://fakestoreapi.com/users',
          method: 'PUT',
          data: user.toMap(),
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return SingleUserModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw NetworkException.fromError(e);
      } else {
        throw Exception('Could not send request');
      }
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
