import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double _volume = 0.0;

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerStature = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  String resultBMI = '';

  @override
  Widget build(BuildContext context) {
    String dropdownvalueStature = 'inch';
    String dropdownvalueWeight = 'lb';

    var itemsStature = [
      'inch',
      'foot',
      'yard',
      'mile',
    ];

    var itemsWeight = [
      'lb',
      'oz',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Calculate your BMI:',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: controllerAge,
                      decoration: const InputDecoration(
                          label: Center(
                            child: Text("Age *"),
                          ),
                          border: UnderlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: controllerStature,
                      decoration: const InputDecoration(
                          label: Center(
                            child: Text("Stature *"),
                          ),
                          border: UnderlineInputBorder()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 100,
                    child: DropdownButton(
                      value: dropdownvalueStature,
                      items: itemsStature.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalueStature = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.woman),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.man),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: controllerWeight,
                      decoration: const InputDecoration(
                          label: Center(
                            child: Text("Weight *"),
                          ),
                          border: UnderlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: DropdownButton(
                      value: dropdownvalueWeight,
                      items: itemsWeight.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalueWeight = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(
                resultBMI,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        num numAux = (num.parse(controllerWeight.text) /
                            (num.parse(controllerStature.text) *
                                num.parse(controllerStature.text)));

                        resultBMI = numAux.toStringAsFixed(2);
                      });
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
            resultBMI = '';
          });
        },
        tooltip: 'clean',
        child: const Text('Clean'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
