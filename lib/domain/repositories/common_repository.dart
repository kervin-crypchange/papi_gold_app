import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

abstract class CommonRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<LocationEntity>>> getLocation();
  Future<Either<Failure, List<MetalEntity>>> getMetalList();
  Future<Either<Failure, List<ProductEntity>>> getProdutList();
  
}
