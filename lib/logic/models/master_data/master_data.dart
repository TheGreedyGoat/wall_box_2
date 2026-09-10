import 'package:wall_box_2/logic/helpers/enums/data_error.dart';

/// abstract class for Master data (Stammdaten)
///
/// includes a validation system
abstract class MasterData {
  /// abstract class for Master data (Stammdaten)
  ///
  /// includes a validation system
  MasterData();

  /// used in[validate] to validate the data block.
  ///
  /// null within the list represents a successful validation
  /// Example in Personal Data:
  /// ```dart
  /// @override
  /// List<DataError?> get validationList => [
  ///   (prename ?? '').isEmpty ? DataError.noPrename : null,
  ///   (surname ?? '').isEmpty ? DataError.noSurname : null,
  ///   address == null ? DataError.noAddress : null,
  ///   contact == null ? DataError.noContact : null,
  ///   if (address != null) ...address!.validate(), /// <= include validations of child data
  ///    if (contact != null) ...contact!.validate(),
  ///  ];
  ///```
  ///
  List<DataError?> get validationList;

  /// use to validate the data. ([validationList] has to be setup properly)
  ///
  /// the validation is considered succesful, if the retuned list is empty
  ///
  List<DataError> validate() => validationList.whereType<DataError>().toList();
}
