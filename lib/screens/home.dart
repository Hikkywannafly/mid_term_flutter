import 'package:flutter/material.dart';
import 'package:mid_term/database/product.dart';
import 'package:mid_term/database/services.dart';
import 'package:mid_term/widgets/bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Các mặc hàng của J97'),
        automaticallyImplyLeading: false,
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // signOutUser(context);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: productListNotifier,
        builder: (context, products, child) {
          if (products.isEmpty) {
            return const Center(
                child: Text('Rất Tiếc bạn không phải là fan của J97'));
          }
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('Price: ${product.price.toString()}'),
                leading: Image.network(product.image),
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  // children: [
                  //   IconButton(
                  //     icon: Icon(Icons.edit),
                  //     onPressed: () {
                  //       // Hàm chỉnh sửa sản phẩm
                  //       _editProduct(product);
                  //     },
                  //   ),
                  //   IconButton(
                  //     icon: Icon(Icons.delete),
                  //     onPressed: () {
                  //       // Hàm xóa sản phẩm
                  //       _productService.deleteProduct(product.id);
                  //     },
                  //   ),
                  // ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final detailsForm =
              BottomUpSheet(context: context, dataIsAvailable: true);
          detailsForm.studentsDetailsForm();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color.fromARGB(255, 242, 243, 248),
    );
  }
}
