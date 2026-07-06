import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:papi_gold/app/common/mixins/messenger_mixin.dart';
import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/constants/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/theme/index.dart';
import 'package:papi_gold/presentation/cubits/index.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ProductPage extends StatelessWidget with MessengerMixin {
  final String id;
  ProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().detail(safeInt(id));
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.goNamed(Routes.navigation),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductFailure) {
              messenger.showSnackBar(
                message: state.message,
                color: AppColors.error,
              );
            }
          },
          builder: (context, state) {
            if (state is ProductLoadding) {
              return LoadingWidget();
            }
            if (state is ProductSuccess) {
              final p = state.product;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 0.7.sw),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: p.imagen,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                                height: 250.h,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.55.sh,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.0.r),
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentGeometry.bottomCenter,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12.h,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(p.name, style: context.labelLarge),
                                Text(
                                  p.category.name,
                                  style: context.labelSmall,
                                ),
                              ],
                            ),
                            Text(
                              getFormatMoney(p.price),
                              style: context.titleSmall,
                            ),
                            Text(p.description, maxLines: 3),
                            RichText(
                              text: TextSpan(
                                text: 'Disponible: ',
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '${p.stock}',
                                    style: TextStyle(
                                      color: (p.stock > 0
                                          ? AppColors.success
                                          : AppColors.error),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.w, vertical: 24.h),
                        SizedBox(
                          width: 0.9.sw,
                          child: FilledButtonWidget(
                            title: 'Agregar al carrito',
                            onPressed: () async {
                              messenger.showSnackBar(
                                message: 'Item agregado al carrito',
                                color: AppColors.success,
                                seconds: 1,
                              );
                              await PersistentShoppingCart().addToCart(
                                PersistentShoppingCartItem(
                                  productId: safeString(p.id),
                                  productName: p.name,
                                  productDescription: p.description,
                                  unitPrice: p.price,
                                  quantity: 1,
                                  productImages: [p.imagen],
                                ),
                              );
                            },
                          ),
                        ).paddingSymmetric(vertical: 16.h),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('Ha ocurrido un error'));
          },
        ),
      ),
    );
  }
}
