import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/domain/bloc/product_add_cubit.dart';
import 'package:mobile_app_labamu/state/product_add_state.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<StatefulWidget> createState() => ProductAddPageState();
}

class ProductAddPageState extends State<ProductAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<ProductAddCubit, ProductAddState>(
        listener: (context, state) {
          if (state is ProductAddSuccess) {
            Navigator.pop(context);
          } else if (state is ProductAddError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductAddLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return const Center(
            child: Text('Product Add Page'),
          );
        },
      ),
    );
  }
}
