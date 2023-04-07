part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class ChangeBottomNavIndexState extends MainState {}
class ChooseStudentLevelState extends MainState {}
class ChooseStudentDepartmentState extends MainState {}
class ChooseStudentLevelAddingState extends MainState {}
class NfcNotFoundState extends MainState {}
class GetAllStudentsLoading extends MainState {}
class GetAllStudentsError extends MainState {}
class GetAllStudentsSuccess extends MainState {}
class CreateDatabaseState extends MainState {}
class DeleteDatabaseState extends MainState {}
class GetAllAttendsSuccess extends MainState {}
class GetAllSearchSuccess extends MainState {}
class GetALlReportByDateState extends MainState {}
class ChooseUpdatedStudentState extends MainState {}
class ChoosePdfSuccess extends MainState {}
class ChooseState extends MainState {}
class FilterState extends MainState {}
class ChangeCheckBoxState extends MainState {}
