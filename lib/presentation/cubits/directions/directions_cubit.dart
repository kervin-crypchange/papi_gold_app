import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papi_gold/app/core/error/index.dart';
import 'package:papi_gold/domain/entities/address_entity.dart';
import 'package:papi_gold/domain/uses_cases/direcetions_use_case.dart';
import 'package:papi_gold/injection_container.dart';

part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  AddressEntity? _address;

  DirectionsCubit() : super(DirectionsInitial());

  Future<Either<Failure, List<AddressEntity>>> directions() async {
    return await sl<DirectionsUseCase>().call();
  }

  set address(AddressEntity address) {
    _address = address;
  }

  AddressEntity? get address => _address;
}
