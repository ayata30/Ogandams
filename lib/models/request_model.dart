
class RequestModel {
  final String requestId;
  final String userId; /// tells us whats user submiiited the request
  final String title; /// title of request
  final String category; /// request category
  final String description;
  final double? amount; /// request amount
  final String status;
  final DateTime? createdAt; /// when the request was created

  RequestModel({
    required this.requestId, /// indentifies the specific request
    required this.userId,
    required this.title,
    required this.category,
    required this.description,
    this.amount,
    this.status = 'Pending',  /// the status of the request first starts as pending
    this.createdAt,
  });

  /// Convert request data into a format Firestore can store.
  /// dart object into data firestone understands
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'category': category,
      'description': description,
      'amount': amount,
      'status': status,
      'createdAt': createdAt,
    };
  }

  ///  Convert a Firestore document or data  into a RequestModel object (dart object).
  factory RequestModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return RequestModel(
      requestId: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      amount: (map['amount'] as num?)?.toDouble(),
      status: map['status'] ?? 'Pending',
      createdAt: (map['createdAt'] as dynamic)?.toDate(),
    );
  }
}
