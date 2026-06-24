import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:papi_gold/domain/entities/index.dart';
import 'package:papi_gold/presentation/widgets/product_card_widget.dart';

class ProductCarouselWidget extends StatefulWidget {
  final List<ProductEntity> products;

  const ProductCarouselWidget({super.key, required this.products});

  @override
  State<ProductCarouselWidget> createState() => _ProductCarouselWidgetState();
}

class _ProductCarouselWidgetState extends State<ProductCarouselWidget> {
  late InfiniteScrollController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      itemCount: widget.products.length,
      itemExtent: 0.7.sw,
      center: false,
      anchor: 0.0,
      velocityFactor: 0.2,
      onIndexChanged: (index) {},
      controller: controller,
      axisDirection: Axis.horizontal,
      loop: true,
      itemBuilder: (context, itemIndex, realIndex) {
        final ProductEntity product = widget.products[itemIndex];
        return ProductCardWidget(product: product,);
      },
    );
  }
}
