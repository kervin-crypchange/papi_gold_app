import 'package:papi_gold/app/common/widgets/index.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Mis direcciones'),
            ),
          ),
           SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Item Number ${index + 1}'),
                );
              },
              childCount: 20, // Defines total list capacity
            ),
          ),
        ],
      )
    );
  }
}
