import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/core/helper/general_helpepr.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/data/repository_impl/product_repository_impl.dart';
import 'package:mobile_app_labamu/domain/use_case/product_use_case.dart';
import 'package:mobile_app_labamu/state/product_add_state.dart';

class ProductAddCubit extends BaseCubit<ProductAddState> {
  ProductUseCase productUseCase = ProductUseCase(new ProductRepositoryImpl());
  Product product = Product();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  String status = 'Active';

  GeneralHelper generalHelper = GeneralHelper();

  ProductAddCubit() : super(ProductAddInitial());

  @override
  FutureOr<void> initCubit() async {
    emit(ProductAddInitial());
  }

  @override
  FutureOr<void> loadCubit() async {
    emit(ProductAddLoading());
  }

  @override
  FutureOr<void> postCubit() async {
    emit(ProductAddLoading());
    final currentState = formKey.currentState;
    if (currentState == null || !currentState.validate()) {
      // form validation failed
      emit(ProductAddInitial());
      return;
    }

    final name = nameController.text.trim();
    final priceText = priceController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty || priceText.isEmpty || desc.isEmpty) {
      // all fields mandatory
      emit(ProductAddInitial());
      return;
    }

    final price = int.tryParse(priceText);
    if (price == null) {
      // invalid price
      emit(ProductAddInitial());
      return;
    }

    try {
      // Replace the following with your repository/service save call.
      var savedProduct = Product(
        id: generalHelper.generateCode(),
        name: name,
        price: price,
        description: desc,
        status: status.toLowerCase(),
        imageUrl: "https://placehold.co/600x400/png",
        updatedAt: DateTime.now().toString(),
      );

      await productUseCase.addProduct(savedProduct);

      // clear form after successful save (use null-aware access in case the form was disposed)
      formKey.currentState?.reset();
      nameController.clear();
      priceController.clear();
      descController.clear();

      // emit success state with result if needed
      emit(ProductAddSuccess());
      return;
    } catch (e, st) {
      // emit error or initial (adjust to your actual error state if available)
      log("Hello: ${e.toString()}");
      log(st.toString());
      emit(ProductAddFailedSubmit('Failed to add product. Please try again.'));
    }
  }
}
