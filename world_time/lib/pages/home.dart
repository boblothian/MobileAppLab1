import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //this will store data sent from loading
  Map data = {};

  @override
  Widget build(BuildContext context) {
    //receives arguments sent from loading and assigns them to the map we just made
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    //set background
    String bgImage = data['isDaytime'] ? 'Day.jpg' : 'Night.jpg';
    Color bgColor = data['isDaytime'] ? Colors.lightBlueAccent : Colors.indigo;

    //home page layout
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 380, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style:
                          const TextStyle(fontSize: 28.0, letterSpacing: 2.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontSize: 66.0,
                  ),
                ),
              ], //widget
            ),
          ),
        ),
      ),
    );
  }
}
