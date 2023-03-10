import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paystack_shop/services/user_service.dart';

class TransactionHistoryPage extends StatelessWidget {
  final items = List.generate(50, (i) => i);
  TransactionHistoryPage({Key? key}) : super(key: key) {
    loadTotal();
  }
  loadTotal() async {
    final transactionhistory = await UserService().getUser();
    print(transactionhistory.length);
    transactionhistory.forEach((element) {
      print(element.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paystack',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text('user-data $item'),
                subtitle: const Text('message'),
                onTap: (() => null),
                trailing: const Icon(Icons.chevron_right_outlined),
              );
            }),
      ),
    );
  }
}
 //Navigator.pop(context);