import 'package:mid_term/database/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ValueNotifier<List<Product>> productListNotifier = ValueNotifier([]);

final CollectionReference productCollection =
    FirebaseFirestore.instance.collection('product');

Future<void> addProduct(Product product) async {
  final docRef = productCollection.doc();
  product.id = docRef.id;
  await docRef.set(product.toMap());

  await getAllProducts();
}

Future<void> getAllProducts() async {
  final QuerySnapshot snapshot = await productCollection.get();
  productListNotifier.value = snapshot.docs.map((doc) {
    return Product.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }).toList();
}

Future<void> updateProduct(Product product) async {
  await productCollection.doc(product.id).update(product.toMap());

  await getAllProducts();
}

// Xóa sản phẩm từ Firestore
Future<void> deleteProduct(String id) async {
  await productCollection.doc(id).delete();

  await getAllProducts();
}
