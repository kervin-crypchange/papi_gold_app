import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingAnimatedWidget extends StatelessWidget {
  const LoadingAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: LoadingBouncingGrid.square() )),
    );
  }
}
