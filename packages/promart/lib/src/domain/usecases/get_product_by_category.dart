import 'package:promart/src/features/promart/data/models/all_products_model.dart';
import 'package:promart/src/features/promart/domain/repositories/ipromart_repository.dart';

class GetProductByCategory {
  GetProductByCategory({required IPromartRepository repository})
      : _repository = repository;

  final IPromartRepository _repository;

  Future<AllProductModel?> call(
          {required String category,
          String limit = '20',
          String sort = 'dsc'}) async =>
      _repository.getCategoryProduct(
          category: category, limit: limit, sort: sort);
}
