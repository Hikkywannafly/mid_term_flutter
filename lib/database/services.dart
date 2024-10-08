import 'package:mid_term/database/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ValueNotifier<List<Product>> productListNotifier = ValueNotifier([]);

class ProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('product');

  // Thêm sản phẩm vào Firestore
  Future<void> addProduct(Product product) async {
    final docRef = productCollection.doc();
    product.id = docRef.id;
    await docRef.set(product.toMap());

    await getAllProducts(); // Cập nhật danh sách sản phẩm sau khi thêm
  }

  // Lấy tất cả sản phẩm từ Firestore
  Future<void> getAllProducts() async {
    final QuerySnapshot snapshot =
        await productCollection.orderBy('name').get();

    // Cập nhật lại toàn bộ danh sách sản phẩm
    productListNotifier.value = snapshot.docs.map((doc) {
      return Product.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Cập nhật sản phẩm trong Firestore
  Future<void> updateProduct(Product product) async {
    await productCollection.doc(product.id).update(product.toMap());

    await getAllProducts(); // Cập nhật danh sách sản phẩm sau khi sửa
  }

  // Xóa sản phẩm từ Firestore
  Future<void> deleteProduct(String id) async {
    await productCollection.doc(id).delete();

    await getAllProducts(); // Cập nhật danh sách sản phẩm sau khi xóa
  }
}
