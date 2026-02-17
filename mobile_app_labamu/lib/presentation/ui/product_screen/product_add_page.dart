import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
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
    var cubit = context.read<ProductAddCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<ProductAddCubit, ProductAddState>(
        listener: (context, state) {
          if (state is ProductAddSuccess) {
            Navigator.pop(context);
          } 
          
          if (state is ProductAddError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is ProductAddFailedSubmit) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

        },
        builder: (context, state) { 
          if (state is ProductAddLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: cubit.nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter a name'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: cubit.priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty)
                        return 'Please enter a price';
                      if (double.tryParse(v.trim()) == null)
                        return 'Enter a valid number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: cubit.descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: cubit.status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(value: 'Active', child: Text('Active')),
                      DropdownMenuItem(
                          value: 'Inactive', child: Text('Inactive')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        cubit.status = v;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (!cubit.formKey.currentState!.validate()) return;

                      // Call your cubit to add product. Adjust parameters to match your cubit's API.
                      cubit.postCubit();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.red,
                    ),
                    child: const Text(
                      'Add Product',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
