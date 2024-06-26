import 'package:calcutator/button_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class calculatorScreen extends StatefulWidget {
  const calculatorScreen({super.key});

  @override
  State<calculatorScreen> createState() => _calcutorScreenState();
}

class _calcutorScreenState extends State<calculatorScreen> {
//  APPS functionality
  String num1 = "";
  String operand = "";
  String num3 = "";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Section for dispaly
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "$num1$operand$num3".isEmpty ? "0" : "$num1$operand$num3",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // section for buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: value == Btn.n0
                            ? screenSize.width / 2
                            : (screenSize.width / 4),
                        height: screenSize.width / 5,
                        child: buildButton(value)),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
    // );
  }

// }
  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: getBtnColor(value),
        // ClipBehavior fix your hover behavoir to fix your button
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white24)),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
                child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ))),
      ),
    );
  }

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }

  void onBtnTap(String value) {
    //
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.per) {
      convertToPercentage();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }
    appendValue(value);
  }

  // ##### calculate function
  void calculate() {
    if (num1.isEmpty) return;
    if (operand.isEmpty) return;
    if (num3.isEmpty) return;
    double number1 = double.parse(num1);
    double number3 = double.parse(num3);
    var result = 0.00;
    switch (operand) {
      case Btn.add:
        result = number1 + number3;
        break;
      case Btn.multiply:
        result = number1 * number3;
        break;
      case Btn.divide:
        result = number1 / number3;
        break;
      case Btn.subtract:
        result = number1 - number3;
        break;
      // case Btn.multiply:
      //   result = number1 * number3;
      //   break;
      default:
    }
    setState(() {
      num1 = "$result";
      if (num1.endsWith(".0")) {
        num1 = num1.substring(0, num1.length - 2);
      }
      operand = "";
      num3 = "";
    });
  }

  // ### convert to percentage\
  void convertToPercentage() {
    if (num1.isNotEmpty && operand.isNotEmpty && num3.isNotEmpty) {
      // Calculate before converting
      calculate();
    }
    if (operand.isNotEmpty) {
      // can not be converted
      return;
    }
    final number = double.parse(num1);

    setState(() {
      num1 = "${number / 100}";
      operand = "";
      num3 = "";
    });
  }

  // ####### clear function
  void clearAll() {
    setState(() {
      num1 = "";
      operand = "";
      num3 = "";
    });
  }

  // ####### Delete function
  void delete() {
    if (num3.isNotEmpty) {
      num3 = num3.substring(0, num3.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }
    setState(() {});
  }

//####### append value to the end
  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && num3.isNotEmpty) {
        // Calculate the equation
        calculate();
      }
      operand = value;
      // Assign values to number1 variable
    } else if (num1.isEmpty || operand.isEmpty) {
      // check if value is not dot(.) ex:number1 = "1.2"
      if (value == Btn.dot && num1.contains(Btn.dot)) return;
      if (value == Btn.dot && (num1.isEmpty || num1 == Btn.n0)) {
        value = "0.";
      }
      num1 += value;
      // Assign values to number3 or 2 variable
    } else if (num3.isEmpty || operand.isNotEmpty) {
      // number1 = "1.2"
      if (value == Btn.dot && num3.contains(Btn.dot)) return;
      if (value == Btn.dot && (num3.isEmpty || num3 == Btn.n0)) {
        value = "0.";
      }
      num3 += value;
    }
    setState(() {});
  }
}
