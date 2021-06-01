part of 'staff_cubit.dart';

@immutable
abstract class StaffState {}

class StaffLoadingState extends StaffState {}

class StaffHasDataState extends StaffState {
  List<Staff> data = [];
  // ignore: avoid_unused_constructor_parameters
  // ignore: sort_constructors_first
  StaffHasDataState({required this.data});
}
