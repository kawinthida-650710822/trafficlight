import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const TrafficLight(),
    );
  }
}

class TrafficLight extends StatefulWidget {
  const TrafficLight({super.key});

  @override
  _TrafficLightState createState() => _TrafficLightState();
}

class _TrafficLightState extends State<TrafficLight> {
  int _lightStatus = 0; 
  int _timeLeft = 10; 
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _changeLight();
      }
    });
  }

  void _changeLight() {
    setState(() {
      _lightStatus = (_lightStatus + 1) % 3;
      _timeLeft = _getDurationForLight();
    });
  }

  int _getDurationForLight() {
    switch (_lightStatus) {
      case 0: return 10; 
      case 1: return 5;  
      case 2: return 10; 
      default: return 10;
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Traffic Light Animation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLight(Colors.red, _lightStatus == 0),
            const SizedBox(height: 20),
            _buildLight(Colors.yellow, _lightStatus == 1),
            const SizedBox(height: 20),
            _buildLight(Colors.green, _lightStatus == 2),
            const SizedBox(height: 30),
            Text(
              '$_timeLeft s',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changeLight();
                _startTimer();
              },
              child: const Text("Change Light"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLight(Color color, bool isActive) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isActive ? 1.0 : 0.3,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          boxShadow: isActive ? [BoxShadow(color: color, blurRadius: 15)] : [],
        ),
      ),
    );
  }
}
