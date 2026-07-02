import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

/// A customizable card widget for displaying product information.
class ProductCard extends StatefulWidget {
  /// The unique identifier of the product.
  final String? id;

  /// The URL of the product image.
  final String imageUrl;

  /// A short description of the product.
  final String? shortDescription;

  /// The category name of the product.
  final String categoryName;

  /// The name of the product.
  final String productName;

  /// The price of the product.
  final double price;

  /// A callback function triggered when the card is tapped.
  final VoidCallback? onTap;

  /// A callback function triggered when the favorite button is pressed.
  final VoidCallback? onFavoritePressed;

  /// The border radius of the card.
  final double borderRadius;

  /// The rating of the product (optional).
  final double? rating;

  /// The width of the card
  final double? width;

  /// The height of the card
  final double? height;

  /// Creates a [ProductCard] widget.
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.productName,
    required this.price,
    this.onTap,
    this.onFavoritePressed,
    this.shortDescription = '',
    this.id,
    this.borderRadius = 12.0,
    this.rating,
    this.width = 300,
    this.height = 360,
  });

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (widget.onTap != null) {
        //   widget.onTap!();
        // }
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          elevation: 4,
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image and favorite button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Builder(
                      builder: (context) {
                        try {
                          return Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            height: 170,
                            width: double.infinity,
                          );
                        } catch (e) {
                          // Handle error
                          return const Center(
                            child: Text('Failed to load image'),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () {
                          if (widget.onTap != null) {
                            widget.onTap!();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Product details
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoryName.capitalizeFirst,
                      style: context.bodyMedium.copyWith(color: AppColors.grey),
                    ).medium,
                    const SizedBox(height: 4),
                    Text(
                      widget.productName,
                      style: context.bodyLarge.copyWith(color: AppColors.black),
                    ).medium,
                    // Short description (if provided)
                    if (widget.shortDescription!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          widget.shortDescription!,
                          style: context.bodySmall.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    // Product rating (if available)
                    if (widget.rating != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < widget.rating!.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    Gap(6.h),
                    // Product availability and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          getFormatMoney(widget.price),
                          style: context.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ).medium,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
