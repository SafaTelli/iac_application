import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  // dtabase ref
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('staff');
}
