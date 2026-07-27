import 'package:papi_gold/app/common/widgets/index.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive(),);
  }
}
