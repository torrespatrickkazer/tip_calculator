
import 'package:material_ui/material_ui.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) =>
    double.tryParse(input.trim());

({double tip, double total}) computeTip(
    double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController =
      TextEditingController();

  int _selectedPercent = 15;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

 
@override
Widget build(BuildContext context) {
  final bill = parseBill(_billController.text);

  final result = bill != null && bill >= 0
      ? computeTip(bill, _selectedPercent)
      : null;

  return Scaffold(
    appBar: AppBar(
      title: const Text('Tip Calculator'),
      centerTitle: true,
    ),

    body: Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const Text(
            'Calculate Your Tip',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // BILL AMOUNT
          TextField(
            controller: _billController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Bill Amount',
              prefixText: '₱ ',
              border: OutlineInputBorder(),
              hintText: 'Enter bill amount',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),

          const SizedBox(height: 25),

          const Text(
            'Select Tip Percentage',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          // TIP PERCENTAGE BUTTONS
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(
                value: 10,
                label: Text('10%'),
              ),
              ButtonSegment(
                value: 15,
                label: Text('15%'),
              ),
              ButtonSegment(
                value: 20,
                label: Text('20%'),
              ),
            ],
            selected: {_selectedPercent},
            onSelectionChanged: (selection) {
              setState(() {
                _selectedPercent = selection.first;
              });
            },
          ),

          const SizedBox(height: 30),

          // TIP RESULT
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Tip Amount'),
                  const SizedBox(height: 8),
                  Text(
                    result == null
                        ? 'Enter a valid amount'
                        : '₱ ${result.tip.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Divider(height: 30),

                  const Text('Total Bill'),
                  const SizedBox(height: 8),
                  Text(
                    result == null
                        ? 'Enter a valid amount'
                        : '₱ ${result.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
