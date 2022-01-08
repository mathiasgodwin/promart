import 'package:promart/src/features/promart/data/models/getall_category_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class GetAllCategoryUsecase {
  GetAllCategoryUsecase({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllCategoryModel?> call() async{
    return await _repository.getAllCategory();
  }
}
