
import 'package:material_ui/material_ui.dart';

//Main entry point of the application
//Starts the Tip Calculator app
void main() => runApp(const TipApp());

//Main application widget
//Sets the app title, theme, and starting screen
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

//Converts the user's bill input into a number
//Returns null if the input is invalid
double? parseBill(String input) =>
    double.tryParse(input.trim());

//Calculates the tip amount and total bill
//Returns both values using a Dart record
({double tip, double total}) computeTip(
    double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

//TipPage is the main screen of the calculator
class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  //Controls and stores the bill amount entered by the user
  final TextEditingController _billController =
      TextEditingController();

  //Default selected tip percentage is 15%
  int _selectedPercent = 15;

  //Releases the text controller when the screen is removed
  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  //Builds the user interface of the Tip Calculator
  @override
  Widget build(BuildContext context) {
    //Reads and converts the entered bill amount
    final bill = parseBill(_billController.text);

    //Calculates the tip only when the bill is valid.
    final result = bill != null && bill >= 0
        ? computeTip(bill, _selectedPercent)
        : null;

    return Scaffold(
      //Displays the application title at the top
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            //Heading displayed on the calculator screen
            const Text(
              'Calculate Your Tip',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            //BILL AMOUNT
            //Allows the user to enter the bill amount
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

              //Updates the screen whenever the input changes
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 25),

            //Label for the available tip percentages
            const Text(
              'Select Tip Percentage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            //TIP PERCENTAGE BUTTONS
            //Allows the user to choose between 10%, 15%, and 20%
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

              //Updates the selected tip percentage
              onSelectionChanged: (selection) {
                setState(() {
                  _selectedPercent = selection.first;
                });
              },
            ),

            const SizedBox(height: 30),

            // TIP RESULT
            // Displays the calculated tip and total bill
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Tip Amount'),
                    const SizedBox(height: 8),

                    //Displays the tip amount or an error prompt
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

                    //Displays the final bill including the tip.
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
