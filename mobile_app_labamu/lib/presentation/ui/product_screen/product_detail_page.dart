import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/domain/bloc/product_detail_cubit.dart';
import 'package:mobile_app_labamu/state/product_detail_state.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductDetailCubit>();
    final args = ModalRoute.of(context)?.settings.arguments;
    Product product = args as Product;
    cubit.selectProduct(product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProductDetailCubit, ProductDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top: product image
                imageViewWidget(),
                // Details below image
                productDetailContainer(cubit, product),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding productDetailContainer(ProductDetailCubit cubit, Product product) {
    return Padding(
      padding: const EdgeInsets.all(Util.basePaddingMargin16),
      child: Builder(builder: (context) {
        final title = product.name ?? 'Unknown product';
        final price = cubit.generalHelper.formatIdr(product.price);
        final description =
            product.description?.toString() ?? 'No description available.';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: Util.baseWidthHeight8),
            if (price.isNotEmpty)
              Text(
                price,
                style: TextStyle(
                  fontSize: Util.baseTextSize18,
                  fontWeight: FontWeight.bold,
                  color: Palette.green,
                ),
              ),
            const SizedBox(height: Util.baseWidthHeight16),
            Text(
              'Details',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: Util.baseWidthHeight8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        );
      }),
    );
  }

  Builder imageViewWidget() {
    return Builder(
      builder: (context) {
        final imageUrl = "https://placehold.co/600x400/png";
        return SizedBox(
          height: Util.baseWidthHeight300,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, size: Util.baseWidthHeight64),
            ),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
