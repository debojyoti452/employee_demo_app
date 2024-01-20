abstract class BaseCubitState {}

mixin class BaseCubitEvent {
  static const String TAG = 'BaseCubitEvent';
  static const String EVENT_LOADING = 'EVENT_LOADING';
  static const String EVENT_INITIAL = 'EVENT_INITIAL';
  static const String EVENT_LOADED = 'EVENT_LOADED';
  static const String EVENT_SUCCESS = 'EVENT_SUCCESS';
  static const String EVENT_ERROR = 'EVENT_ERROR';
}

mixin CubitStatus {
  static CubitLoading loading({String? event}) => CubitLoading(event: event);

  static CubitSuccess<T> success<T>({String? event, String? message, T? data}) =>
      CubitSuccess<T>(event: event, data: data, message: message);

  static CubitError error({
    String? message,
    String? event,
  }) =>
      CubitError(message: message, event: event);

  static CubitInitial initial({String? event}) => CubitInitial(event: event);

  static CubitLoaded loaded({String? event}) => CubitLoaded(event: event);
}

class CubitInitial extends BaseCubitState {
  final String? event;

  CubitInitial({this.event});
}

class CubitLoading extends BaseCubitState {
  final String? event;

  CubitLoading({this.event});
}

class CubitSuccess<T> extends BaseCubitState {
  final String? message;

  final String? event;
  final T? data;

  CubitSuccess({this.message, this.event, this.data});
}

class CubitError extends BaseCubitState {
  final String? message;
  final String? event;

  CubitError({this.message, this.event});
}

class CubitLoaded extends BaseCubitState {
  final String? event;

  CubitLoaded({this.event});
}
