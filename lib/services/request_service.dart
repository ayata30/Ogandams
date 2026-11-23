
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/request_model.dart';

/// Handles creating and retrieving support requests in Firestore
class RequestService {

  /// Provides access to the Cloud Firestore database.
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;


  /// Provides access to the currently authenticated user.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Submit a new request.
  /// Associates the request with the currently authenticated user.
  /// Returns the Firestore document ID after successful submission.
  Future<String> submitRequest({
    required String title,
    required String category,
    required String description,
    double? amount,

    /// Throws an Exception if no user is currently authenticated.
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('You must be logged in to submit a request.');
    }

    final request = RequestModel(
      requestId: '',
      userId: user.uid,
      title: title,
      category: category,
      description: description,
      amount: amount,
    );

    final document = await _firestore
        .collection('requests')
        .add({
      ...request.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return document.id;
  }

  /// Retrieve requests submitted by the current user
  /// Automatically emits updated request lists when Firestore data changes.
  /// Throws an Exception if no user is currently authenticated
  Stream<List<RequestModel>> getMyRequests() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('You must be logged in.');
    }

    return _firestore
        .collection('requests')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return RequestModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }
}
