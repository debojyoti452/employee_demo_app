part of 'custom_calendar_cubit.dart';

@freezed
class CustomCalendarState with _$CustomCalendarState {
  factory CustomCalendarState({
    DateTime? selectedDate,
    required DateTime monthAndYear,
    required DateTime todayDate,
    required BaseCubitState appState,
    required List<String> daysOfWeek,
  }) = _CustomCalendarState;
}
