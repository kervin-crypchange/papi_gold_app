import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.white38, width: 0.5),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(6.r),
                  topRight: Radius.circular(6.r),
                ),
                child: Image.network(
                  product.imagen,
                  fit: BoxFit.fill,
                  width: 0.8.sw,
                  height: 150,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.bodyLarge.copyWith(
                      color: AppColors.secondary,
                    ),
                  ).medium,
                  Text(product.name),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38, width: 0.3),
                    ),
                  ).paddingSymmetric(vertical: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Precio').color(AppColors.grey),
                          Text(
                            getFormatMoney(product.price),
                            style: context.bodyMedium.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          IconButton(
                            onPressed: () => print('press'),
                            icon: Icon(Icons.info_outline_rounded),
                          ),
                          IconButton(
                            onPressed: () => print('press'),
                            icon: Icon(Icons.shopping_cart_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingAll(8.r),
            ],
          ),
          Positioned(
            top: 10.r,
            right: 10.r,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(100.w),
              ),
              child: Text(
                product.category.name,
                style: context.bodyXSmall,
              ).paddingSymmetric(horizontal: 6.w, vertical: 1.h),
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 6.w);
  }
}
