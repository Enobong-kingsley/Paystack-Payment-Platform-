import 'package:flutter/material.dart';
import 'package:paystack_shop/payments/paystack_payment_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedIndex;

  int price = 0;

  String email = "enobongndedde@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text('Payment App'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Choose\nDaily Plan",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              children: List.generate(
                plans.length,
                (index) {
                  final data = plans[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        price = data["price"]!;
                      });
                    },
                    child: Card(
                      shadowColor: Colors.blue,
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: selectedIndex == null
                              ? null
                              : selectedIndex == index
                                  ? Colors.blue
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "NGN \n${data["price"]}",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Get ${data["items"]} more",
                            ),
                            Text(
                              "items",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: (() {
              if (selectedIndex == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please Select a plan'),
                  ),
                );
              } else {
                print(price);
                MakePayment(ctx: context, price: price, email: email)
                    .chargeCardAndMakePayment();
              }
            }),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Proceed to payment",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: (() {}),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notes,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Transaction History",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  final plans = [
    {"price": 3500, "items": 5},
    {"price": 1000, "items": 10},
    {"price": 1800, "items": 4},
    {"price": 2000, "items": 6},
  ];
}
