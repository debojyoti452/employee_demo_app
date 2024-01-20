import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_model.freezed.dart';

part 'employee_model.g.dart';

abstract class EmployeeItem {}

class EmployeeHeaderItem implements EmployeeItem {
  final String header;

  EmployeeHeaderItem(this.header);
}

class EmployeeDataItem implements EmployeeItem {
  final EmployeeModel employee;

  EmployeeDataItem(this.employee);
}

@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    @JsonKey(name: 'id', includeToJson: false) int? id,
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'designation') String? designation,
    @DateTimeConverter() @JsonKey(name: 'joining_date') DateTime? joiningDate,
    @DateTimeConverter() @JsonKey(name: 'ending_date') DateTime? endingDate,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  factory EmployeeModel.empty() => const EmployeeModel(
        id: null,
        employeeName: null,
        designation: null,
        joiningDate: null,
        endingDate: null,
      );
}

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return DateTime.tryParse(json);
  }

  @override
  String? toJson(DateTime? object) {
    if (object == null) {
      return null;
    }
    return object.toIso8601String();
  }
}
