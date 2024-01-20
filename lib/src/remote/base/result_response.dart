import 'dart:developer';

class Result<Success, Error> {
  final Success? response;
  final Error? error;
  Result({this.response, this.error});

  bool get hasError => error != null;

  bool get hasResponse => response != null;

  bool get hasData => hasResponse && !hasError;

  bool get hasNoData => !hasResponse && !hasError;

  // when method
  void when({
    Function(Success response)? success,
    Function(Error error)? failure,
  }) {
    if (hasData) {
      success?.call(response as Success);
    } else if (hasError) {
      log('Error: ${this.error}', name: 'Result');
      failure?.call(this.error as Error);
    } else {
      throw Exception('Result has no data and no error');
    }
  }
}

final class Success<T> {
  final int? statusCode;
  final String? message;
  final bool? status;
  final T? data;

  Success({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  // Map<String, dynamic> toMap()
  factory Success.fromJson(Map<String, dynamic> map) {
    return Success(
      statusCode: map['status_code'],
      message: map['message'],
      status: map['status'],
      data: map['data'],
    );
  }

  Map<String, dynamic> toMap(Success success) {
    return {
      'statusCode': success.statusCode,
      'message': success.message,
      'status': success.status,
      'data': success.data,
    };
  }
}

final class Error {
  final int? statusCode;
  final bool? status;
  final String? message;

  Error({this.statusCode, this.status, this.message});

  // Map<String, dynamic> toMap()
  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      statusCode: map['status_code'],
      status: map['status'],
      message: map['message'],
    );
  }

  Map<String, dynamic> toMap(Error error) {
    return {
      'statusCode': error.statusCode,
      'status': error.status,
      'message': error.message,
    };
  }
}
