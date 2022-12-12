import 'package:flutter/material.dart';

class BMIscreen extends StatefulWidget {
  const BMIscreen({Key? key}) : super(key: key);

  @override
  State<BMIscreen> createState() => _BMIscreenState();
}

class _BMIscreenState extends State<BMIscreen> {
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale= true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isMale ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('images/male.png'),
                              height: 80.0,
                              width: 80.0,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Male',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isMale ? Colors.grey : Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('images/female.png'),
                              height: 80.0,
                              width: 80.0,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Female',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Height',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: const [
                          Text(
                            '180',
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'CM',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Slider(
                          value: 120.0,
                          max: 220.0,
                          min: 80.0,
                          onChanged: (value) {
                            print(value.round());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '180',
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {},
                                mini: true,
                                child: const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed: () {},
                                mini: true,
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '180',
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {},
                                mini: true,
                                child: const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed: () {},
                                mini: true,
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            height: 50.0,
            width: double.infinity,
            child: MaterialButton(
              onPressed: () {},
              child: const Text(
                'CALCULATE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
