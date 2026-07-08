import 'package:papi_gold/app/common/widgets/index.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive(),);
    // return Container(
    //   height: 1.sh,
    //   width: 1.sw,
    //   decoration: BoxDecoration(color: Colors.black87),
    //   child:LoadingWidget(),
    // );
  }
}
