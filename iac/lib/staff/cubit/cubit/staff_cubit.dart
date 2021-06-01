import 'package:bloc/bloc.dart';
import 'package:iac/data/models/staff.dart';
import 'package:iac/data/repository/staff_repository.dart';
import 'package:meta/meta.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffRepository repository;
  StaffCubit({required this.repository}) : super(StaffLoadingState());

  fetchStaff() {
    repository.refresh();
    emit(StaffHasDataState(data: repository.getList()));
  }
}
