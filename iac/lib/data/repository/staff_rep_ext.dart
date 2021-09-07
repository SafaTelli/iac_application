import 'dart:async';
import 'dart:io';

import 'package:iac/data/models/staff.dart';
import 'package:iac/data/repository/staff_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffRepositoryFireStore extends StaffRepository {
  final _loadedData = <Staff>[];

  // ignore: deprecated_member_use
  // ignore: prefer_collection_literals
  // ignore: deprecated_member_use
  final _cache = <Staff>[];
  @override
  List<Staff> refresh() {
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('staff')
          .snapshots()
          .listen((staffs) {
        print('staffs');
        print(staffs);
        print(staffs.docs.length);
        _loadedData.clear();
        staffs.docs.forEach((staff) {
          final obj = staff.data();
          print(obj);
          // ignore: lines_longer_than_80_chars

          _loadedData.add(Staff(
              image: obj['image'],
              name: obj['name'],
              post: obj['post'],
              tel: obj['tel'],
              email: obj['email']));
        });
      });
    }
    print('cach');
    print(_cache);
    return _cache;
  }

  @override
  List<Staff> getList() {
    print("final list");
    print(_loadedData);
    return _loadedData;
  }
}
