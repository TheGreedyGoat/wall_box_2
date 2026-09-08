import 'package:freezed_annotation/freezed_annotation.dart';

abstract class MasterData {
  final String id;

  MasterData({required this.id});

  String? validate();

  String? processValidationList(List<String?> messages) {
    final errors = messages.where(
      (element) => element != null,
    );
    return errors.isEmpty
        ? null
        : errors.fold(
            '',
            (previousValue, element) => '$previousValue\n$element',
          );
  }
}

class MasterDataIDConverter<T extends MasterData>
    implements JsonConverter<T, String> {
  @override
  T fromJson(String json) {
    throw UnimplementedError();
  }

  @override
  String toJson(T object) => object.id;
}

class MasterDataIDConverterNullable<T extends MasterData?>
    implements JsonConverter<T?, String?> {
  @override
  T? fromJson(String? json) {
    throw UnimplementedError();
  }

  @override
  String? toJson(T? object) => object?.id;
}
