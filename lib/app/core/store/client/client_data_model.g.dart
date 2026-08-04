// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersistentClientDataModelAdapter
    extends TypeAdapter<PersistentClientDataModel> {
  @override
  final typeId = 1;

  @override
  PersistentClientDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersistentClientDataModel(
      id: fields[0] as int,
      name: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      country: (fields[5] as Map).cast<String, dynamic>(),
      state: (fields[6] as Map).cast<String, dynamic>(),
      city: (fields[7] as Map).cast<String, dynamic>(),
      address1: fields[8] as String,
      address2: fields[9] as String,
      codeZip: fields[10] as String,
      receiveAdvertise: fields[11] as bool,
      category: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersistentClientDataModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.address1)
      ..writeByte(9)
      ..write(obj.address2)
      ..writeByte(10)
      ..write(obj.codeZip)
      ..writeByte(11)
      ..write(obj.receiveAdvertise)
      ..writeByte(12)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersistentClientDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
