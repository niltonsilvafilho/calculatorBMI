import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'BMI Calculator!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerStature = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  String resultBMI = '0';

  String dropdownValueStature = 'inch';
  String dropdownValueWeight = 'lb';

  List<String> listGender = [
    'Man',
    'Woman',
  ];

  Widget inputFields(
      String titleLabel, String label, TextEditingController controller) {
    return Expanded(
        child: ListTile(
      dense: true,
      title: Text(
        titleLabel,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          alignLabelWithHint: true,
        ),
        keyboardType: const TextInputType.numberWithOptions(),
        controller: controller,
        textAlign: TextAlign.center,
      ),
      isThreeLine: true,
    ));
  }

  Widget customDropdownButton(List<String> listItems, titleLabel, label) {
    return Expanded(
      child: ListTile(
          dense: true,
          title: Text(
            titleLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: DropdownButtonFormField(
            decoration: InputDecoration(
              isDense: true,
              labelText: label,
              labelStyle: const TextStyle(fontSize: 14),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12.2),
            ),
            items: listItems.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValueStature = newValue!;
              });
            },
          )),
    );
  }

  Widget gaugeChart() {
    return SizedBox(
      width: 350,
      height: 250,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showAxisLine: false,
              showTicks: false,
              minimum: 0,
              maximum: 50,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 18.5,
                    color: const Color.fromARGB(255, 5, 41, 245),
                    label: 'Under Weight',
                    sizeUnit: GaugeSizeUnit.factor,
                    labelStyle:
                        const GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                    startWidth: 0.65,
                    endWidth: 0.65),
                GaugeRange(
                  startValue: 18.5,
                  endValue: 24.99,
                  color: const Color.fromARGB(255, 7, 248, 7),
                  label: 'Healthy',
                  labelStyle:
                      const GaugeTextStyle(fontFamily: 'Times', fontSize: 15),
                  startWidth: 0.65,
                  endWidth: 0.65,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                GaugeRange(
                  startValue: 25.0,
                  endValue: 50,
                  color: const Color.fromARGB(255, 255, 1, 1),
                  label: 'Overweight',
                  labelStyle:
                      const GaugeTextStyle(fontFamily: 'Times', fontSize: 20),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.65,
                  endWidth: 0.65,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: double.parse(resultBMI),
                  enableAnimation: true,
                )
              ])
        ],
      ),
    );
  }

  Widget titles(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  void _calculate() {
    double weight = double.parse(controllerWeight.text);
    double stature = double.parse(controllerStature.text);
    double imc = weight / (stature * stature);

    setState(() {
      resultBMI = imc.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                inputFields(
                    "Weight *", "Enter To Weight (kg)", controllerWeight),
                inputFields("Age *", "Enter to Age (years)", controllerAge),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                inputFields(
                    "Stature *", "Enter To Stature (m)", controllerStature),
                customDropdownButton(listGender, "Gender", "Select To Gender"),
              ]),
              const SizedBox(height: 12),
              gaugeChart(),
              titles(resultBMI),
              const SizedBox(height: 12),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      _calculate();
                    },
                    child: const Text('Calculate')),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            resultBMI = '0';
          });
        },
        tooltip: 'clean',
        child: const Text('Clean'),
      ),
    );
  }
}
