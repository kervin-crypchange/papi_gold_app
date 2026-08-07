import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/constants/routes.dart';
import 'package:papi_gold/data/models/product_info_model.dart';
import 'package:papi_gold/presentation/widgets/product_card.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.data,
  });

  final ProductInfoModel data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.7,
        mainAxisSpacing: 20,
        crossAxisSpacing: 8,
      ),
      itemCount: data.products.length,
      itemBuilder: (context, index) {
        final p = data.products[index];
        return ProductCard(
          product: p,
          onPress: () => context.goNamed(
            Routes.product,
            pathParameters: {'id': safeString(p.id)},
          ),
        );
      },
    );
  }
}