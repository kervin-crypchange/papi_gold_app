import 'package:dartz/dartz.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/remote/index.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/domain/repositories/index.dart';
import 'package:papi_gold/injection_container.dart';

class CommonRepositoryImpl extends CommonRepository {
  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    Either<Failure, List<CountryEntity>> countries =
        await sl<CommonRemoteData>().getCountries();

    return countries.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocation() async {
    Either<Failure, List<LocationEntity>> locations =
        await sl<CommonRemoteData>().getLocation();

    return locations.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<MetalEntity>>> getMetalList(
    String? symbol,
  ) async {
    Either<Failure, List<MetalEntity>> metals = await sl<CommonRemoteData>()
        .getMetalList(symbol);

    return metals.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ApiResponseEntity<ProductInfoEntity>>>
  getProdutList() async {
    Either<Failure, ApiResponseEntity<ProductInfoEntity>> res =
        await sl<CommonRemoteData>().getProdutList();

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(
    LocationParamEntity params,
  ) async {
    Either<Failure, ProductEntity> res = await sl<CommonRemoteData>()
        .getProductDetail(LocationParamModel.fromEntity(params));

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
