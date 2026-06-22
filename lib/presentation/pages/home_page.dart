import 'package:papi_gold/app/common/widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(6, (index) {
              return Text('Non proident dolor aute sit dolor ut consequat non eu labore consectetur ut. Dolore elit consequat non eu. Consequat voluptate ullamco magna reprehenderit laboris adipisicing commodo eiusmod deserunt labore in eiusmod. Enim cupidatat sunt deserunt et. Dolor deserunt aute reprehenderit elit dolore tempor culpa incididunt. Consectetur dolore reprehenderit Lorem nostrud eu elit anim magna Lorem proident adipisicing aute dolor quis. Aute eu enim adipisicing nostrud est aliqua id proident adipisicing et.');
            }),
          ),
        ),
      ),
    );
  }
}
