import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:promart/src/core/utils/exceptions/dio_exceptions.dart';
import 'package:promart/src/core/utils/exceptions/get_remote_exceptions.dart';
import 'package:promart/src/core/utils/exceptions/google_auth_exceptions.dart';
import 'package:promart/src/core/utils/exceptions/post_remote_exceptions.dart';
import 'package:promart/src/features/promart/data/data.dart';
import 'package:logger/logger.dart';

import 'dart:convert';

abstract class IRemoteDataSource {
  /// Firebase Authentication
  Future<void> signOut();

  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
  });
  //Sends SMS code to the backend for verification, emit error messages, if any.
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  });

  Future<bool> isSignedIn();

  Stream<User?> onAuthChange();

  Future<String?> googleSignIn();

  Future<String?> emailSignIn({String? email, String? password});

  Future<String?> emailSignUp({String? email, String? password});

  Future<String?> passwordRecovery({String? email});

  Future<String?> confirmPasswordRecovery({String? code, String? newPassword});

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

class RemoteDataSource implements IRemoteDataSource {
  final _client = Dio();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  /// Firebase Authentication

  //Sends phone number to the backend, emit error messages, if any.
  @override
  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
  }) async* {
    final StreamController<String> streamController =
        StreamController<String>();
    await _firebaseAuth.verifyPhoneNumber(
        timeout: timeout,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential.
          // The feature is currently disabled for the sake of simplicity of the tutorial.
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          streamController.add(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          throw const PhoneAuthSmsTimeoutError();
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.e(e.stackTrace);
          throw PhoneAuthError.fromCode(e.code);
        });
    yield* streamController.stream;
  }

  //Sends SMS code to the backend for verification, emit error messages, if any.
  @override
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  }) async {
    try {
      final PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
              smsCode: smsCode, verificationId: verificationId);

      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw PhoneAuthError.fromCode(e.code);
    } catch (e) {
      throw const PhoneAuthError();
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Stream<User?> onAuthChange() {
    return _firebaseAuth.authStateChanges();
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
      User user = _firebaseAuth.currentUser!;
      return user.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.stackTrace);
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<String?> emailSignIn({String? email, String? password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      // return userCredential;
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.stackTrace);
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<String?> emailSignUp({String? email, String? password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.stackTrace);
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
      logger.e(e.stackTrace);
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
      logger.e(e.stackTrace);
      throw ConfirmPasswordRecoveryFailure.fromCode(e.code);
    } catch (e) {
      throw const ConfirmPasswordRecoveryFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    return user;
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
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AddCartModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw DioException();
      } else {
        throw const PostRemoteException('Add to cart Error');
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const PostRemoteException('Delete Cart Error');
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const PostRemoteException('Delete user error');
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException('Get All carts error');
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
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        String encodedResponse =
            json.encode({'data': json.decode(response.data)});
        return AllCategoryModel.fromJson(encodedResponse);
      } else {}
    } catch (e) {
      logger.e(e);
      if (e is DioError) {
        throw DioException();
      } else {
        throw const GetRemoteException('Get all category error');
      }
    }
  }

  @override
  Future<AllProductModel?> getAllProducts(
      {String sort = 'dsc', String? limit}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: limit == null
              ? 'https://fakestoreapi.com/products?sort=$sort'
              : 'https://fakestoreapi.com/products?sort=$sort&limit=$limit',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
      }
    }
  }

  @override
  Future<AllProductModel?> getCategoryProduct(
      {required String category, String? limit, String sort = 'dsc'}) async {
    try {
      final response = await _client.fetch(
        RequestOptions(
          path: limit == null
              ? 'https://fakestoreapi.com/products/category/$category?sort=$sort'
              : 'https://fakestoreapi.com/products/category/$category??sort=$sort&limit=$limit',
          method: 'GET',
          sendTimeout: 30000,
          receiveTimeout: 30000,
          receiveDataWhenStatusError: true,
          validateStatus: (status) {
            return status! < 500;
          },
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
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
          responseType: ResponseType.json,
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
        throw DioException();
      } else {
        throw const GetRemoteException();
      }
    }
  }
}
