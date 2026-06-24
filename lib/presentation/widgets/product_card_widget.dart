import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/domain/entities/index.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8.sw,
      height: 200,
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: Colors.white38,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12.r)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(product.image),
        ],
      ),
    );
  }
}
