import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:unnamed_budgeting_app/presentation/screen.dart';
import 'package:unnamed_budgeting_app/presentation/screens/transactions/transaction_list/transactions.dart';

class TransactionsFrame extends StatefulWidget {
  @override
  State createState() => _TransactionsFrameState();
}

List<Screen> _screens = <Screen>[
  Screen(
    icon: Icons.attach_money,
    text: 'Transaction List',
    name: 'transactionlist',
    widget: TransactionList(),
  ),
  Screen(
    icon: Icons.print,
    text: 'TEST 1',
    name: 'test1',
    widget: Container(
      color: Colors.red,
    ),
  ),
  Screen(
    icon: Icons.close,
    text: 'TEST 2',
    name: 'test2',
    widget: Container(
      color: Colors.blueAccent,
    ),
  ),
];

class _TransactionsFrameState extends State<TransactionsFrame>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _screens.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: _screens.map<Tab>((Screen screen) {
            return Tab(text: screen.text, icon: Icon(screen.icon));
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _screens.map<Widget>((Screen screen) {
          return screen.widget;
        }).toList(),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: (Theme.of(context).brightness == Brightness.dark)
            ? Colors.grey[800]
            : Colors.white,
        overlayOpacity: 0.8,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.attach_money),
            labelWidget: Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 18.0,
                decorationColor:
                (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.grey[850]
                    : Colors.grey[100],
                backgroundColor:
                (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.grey[850]
                    : Colors.grey[100],
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.attach_money),
            labelWidget: Text(
              'Add Account Balance',
              style: TextStyle(
                fontSize: 18.0,
                decorationColor:
                (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.grey[850]
                    : Colors.grey[100],
                backgroundColor:
                (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.grey[850]
                    : Colors.grey[100],
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
