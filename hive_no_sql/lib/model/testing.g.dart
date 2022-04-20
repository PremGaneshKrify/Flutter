// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestingAdapter extends TypeAdapter<Testing> {
  @override
  final int typeId = 1;

  @override
  Testing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Testing()
      ..testname = fields[0] as String
      ..testcreatedDate = fields[1] as DateTime
      ..testisExpense = fields[2] as bool
      ..testamount = fields[3] as double;
  }

  @override
  void write(BinaryWriter writer, Testing obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.testname)
      ..writeByte(1)
      ..write(obj.testcreatedDate)
      ..writeByte(2)
      ..write(obj.testisExpense)
      ..writeByte(3)
      ..write(obj.testamount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
