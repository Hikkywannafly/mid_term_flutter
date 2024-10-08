import 'dart:collection';

import 'package:mid_term/database/services.dart';
import 'package:mid_term/database/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

int k = 0;
bool dataIsAvailable = false;

final TextEditingController _nameController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _imageController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _priceController = TextEditingController();

class BottomUpSheet {
  final String? name;
  final String? id;
  final String? image;
  final String? category;
  final String? price;
  final String? description;
  final BuildContext context;
  final bool? dataIsAvailable;

  BottomUpSheet({
    this.name,
    this.id,
    this.image,
    this.category,
    this.price,
    this.description,
    this.dataIsAvailable,
    required this.context,
  });

  void studentsDetailsForm() async {
    // Initialize the image controller if we're editing an existing product
    if (dataIsAvailable != true) {
      _nameController.text = name ?? '';
      _descriptionController.text = description ?? '';
      _imageController.text = image ?? '';
      _categoryController.text = category ?? '';
      _priceController.text = price ?? '';
    }

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
      ),
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Nhập tên sản phẩm'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Mô tả sản phẩm'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _imageController,
              decoration:
                  const InputDecoration(hintText: 'Nhập link ảnh sản phẩm'),
              readOnly: true, // Để ngăn người dùng chỉnh sửa thủ công
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String? imagePath = await _uploadImage();
                if (imagePath != null && context.mounted) {
                  _imageController.text =
                      imagePath; // Cập nhật trường với đường dẫn hình ảnh
                }
              },
              child: const Text('Tải ảnh lên'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _categoryController,
              decoration:
                  const InputDecoration(hintText: 'Nhập danh mục sản phẩm'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(hintText: 'Nhập giá sản phẩm'),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Logic để thêm hoặc cập nhật sản phẩm
                  if (id == null) {
                    // Thêm sản phẩm mới
                    await addProductButton();
                    if (k == 0 && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sản phẩm đã được thêm thành công'),
                          backgroundColor: Color.fromARGB(255, 144, 59, 255),
                        ),
                      );
                    }
                  } else {
                    // Cập nhật sản phẩm
                    // await updateProduct(id!);
                  }

                  // Reset các trường
                  _nameController.clear();
                  _descriptionController.clear();
                  _imageController.clear();
                  _categoryController.clear();
                  _priceController.clear();

                  // Đóng bottom sheet
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(id == null ? 'Thêm sản phẩm' : 'Cập nhật sản phẩm'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addProductButton() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final image = _imageController.text.trim();
    final category = _categoryController.text.trim();
    final price = _priceController.text.trim();

    int? id;

    if (name.isEmpty ||
        description.isEmpty ||
        image.isEmpty ||
        category.isEmpty ||
        price.isEmpty) {
      k = 1;
      return;
    }
    final product = Product(
      id: id.toString(),
      name: name,
      description: description,
      image: image,
      category: category,
      price: double.parse(price),
    );
    ProductService productService = ProductService();
    print(product);
    await productService.addProduct(product);
  }

  // Hàm tải ảnh lên từ thiết bị
  Future<String?> _uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image.path; // Trả về đường dẫn của ảnh
    }
    return null; // Nếu không chọn ảnh
  }
}
