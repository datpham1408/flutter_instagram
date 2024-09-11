
import 'package:flutter_instagram/entity/user_instagram_entity.dart';
import 'package:hive/hive.dart';

class UserInstagramAdapter extends TypeAdapter<UserInstagramEntity> {
  @override
  final int typeId = 4;

  @override
  UserInstagramEntity read(BinaryReader reader) {
    return UserInstagramEntity()
      ..email = reader.readString()
      ..password = reader.readString()
      ..age = reader.readString()
      ..phone = reader.readString()
      ..fullName = reader.readString();
  }

  @override
  void write(BinaryWriter writer, UserInstagramEntity user) {
    writer.writeString(user.email ?? '');
    writer.writeString(user.password ?? '');
    writer.writeString(user.age ?? '');
    writer.writeString(user.phone ?? '');
    writer.writeString(user.fullName ?? '');

  }
}
