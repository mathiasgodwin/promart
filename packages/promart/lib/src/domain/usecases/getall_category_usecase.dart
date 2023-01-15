import 'package:promart/promart.dart';

class GetAllCategoryUsecase {
  GetAllCategoryUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllCategoryModel?> call() async{
    return await _repository.getAllCategory();
  }
}
