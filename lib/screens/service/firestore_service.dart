import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  static final FirestoreService instance =
      FirestoreService(FirebaseFirestore.instance);

  FirestoreService(this._firestore);

  Future<void> setData(
      String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).set(data);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<void> updateData(
      {required String collection,
      required String documentId,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<void> addItem(String key, String collection, String documentId,
      Map<String, dynamic> data) async {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    DocumentReference docRef = ref.doc(documentId);

    await docRef.update({
      key: FieldValue.arrayUnion([data]),
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String id) async {
    return await _firestore.collection('users').doc(id).get();
  }

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  Future<DocumentSnapshot> getDocument(
      String collection, String documentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(collection).doc(documentId).get();
      return snapshot;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<void> deleteDocument(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
