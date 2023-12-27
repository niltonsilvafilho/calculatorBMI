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
  double endValueHealthy = 40;
  double endValueUnderWeight = 20;
  double max = 60;

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

  Widget gaugeChart(
      double endValueUnderWeight, double endValueHealthy, double max) {
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
              maximum: max,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: endValueUnderWeight,
                    color: const Color.fromARGB(255, 5, 41, 245),
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.65,
                    endWidth: 0.65),
                GaugeRange(
                  startValue: endValueUnderWeight,
                  endValue: endValueHealthy,
                  color: const Color.fromARGB(255, 7, 248, 7),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.65,
                  endWidth: 0.65,
                ),
                GaugeRange(
                  startValue: endValueHealthy,
                  endValue: max,
                  color: const Color.fromARGB(255, 255, 1, 1),
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
    int age = int.parse(controllerAge.text);
    double imc = weight / (stature * stature);

    if (age < 15 && age >= 6) {
      if (dropdownValueStature == 'Man') {
        switch (age) {
          case 6:
            setState(() {
              endValueUnderWeight = 14.5;
              endValueHealthy = 16.6;
              max = 30;
            });
            break;
          case 7:
            setState(() {
              endValueUnderWeight = 15;
              endValueHealthy = 17.3;
              max = 30;
            });
            break;
          case 8:
            setState(() {
              endValueUnderWeight = 15.6;
              endValueHealthy = 16.7;
              max = 30;
            });
            break;
          case 9:
            setState(() {
              endValueUnderWeight = 16.1;
              endValueHealthy = 18.8;
              max = 30;
            });
            break;
          case 10:
            setState(() {
              endValueUnderWeight = 16.7;
              endValueHealthy = 19.6;
              max = 30;
            });
            break;
          case 11:
            setState(() {
              endValueUnderWeight = 17.2;
              endValueHealthy = 20.3;
              max = 30;
            });
            break;
          case 12:
            setState(() {
              endValueUnderWeight = 17.8;
              endValueHealthy = 21.1;
              max = 30;
            });
            break;
          case 13:
            setState(() {
              endValueUnderWeight = 18.5;
              endValueHealthy = 21.9;
              max = 30;
            });
            break;
          case 14:
            setState(() {
              endValueUnderWeight = 19.2;
              endValueHealthy = 22.7;
              max = 30;
            });
            break;
          case 15:
            setState(() {
              endValueUnderWeight = 19.9;
              endValueHealthy = 23.6;
              max = 30;
            });
            break;
        }
      } else {
        switch (age) {
          case 6:
            setState(() {
              endValueUnderWeight = 14.3;
              endValueHealthy = 16.1;
              max = 30;
            });
            break;
          case 7:
            setState(() {
              endValueUnderWeight = 14.9;
              endValueHealthy = 17.1;
              max = 30;
            });
            break;
          case 8:
            setState(() {
              endValueUnderWeight = 15.6;
              endValueHealthy = 18.1;
              max = 30;
            });
            break;
          case 9:
            setState(() {
              endValueUnderWeight = 16.3;
              endValueHealthy = 19.1;
              max = 30;
            });
            break;
          case 10:
            setState(() {
              endValueUnderWeight = 17;
              endValueHealthy = 20.1;
              max = 30;
            });
            break;
          case 11:
            setState(() {
              endValueUnderWeight = 17.6;
              endValueHealthy = 21.1;
              max = 30;
            });
            break;
          case 12:
            setState(() {
              endValueUnderWeight = 18.3;
              endValueHealthy = 22.1;
              max = 30;
            });
            break;
          case 13:
            setState(() {
              endValueUnderWeight = 18.9;
              endValueHealthy = 23;
              max = 30;
            });
            break;
          case 14:
            setState(() {
              endValueUnderWeight = 19.3;
              endValueHealthy = 23.8;
              max = 30;
            });
            break;
          case 15:
            setState(() {
              endValueUnderWeight = 19.6;
              endValueHealthy = 24.2;
              max = 30;
            });
            break;
        }
      }
    } else if (age < 60) {
      setState(() {
        endValueUnderWeight = 18.5;
        endValueHealthy = 24.9;
        max = 40;
      });
    } else {
      setState(() {
        endValueUnderWeight = 22.0;
        endValueHealthy = 27.0;
        max = 35;
      });
    }

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
              gaugeChart(endValueUnderWeight, endValueHealthy, max),
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
