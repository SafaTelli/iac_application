import 'package:iac/data/models/staff.dart';

abstract class StaffRepository {
  List<Staff> refresh();
  List<Staff> getList();
}
