import 'package:flutter/material.dart';
import 'api_service.dart';
void main(){
  runApp(StockAdvisorApp());
}
class StockAdvisorApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Stock AI Advisor',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home:  AdvisorHomePage(),
    );
  }
}
class AdvisorHomePage extends StatefulWidget{
  @override
  State<AdvisorHomePage> createState() => _AdvisorHomePageState();
}
class _AdvisorHomePageState extends State<AdvisorHomePage>{
  TextEditingController _controller = TextEditingController(text: "NSEI");
  Map<String, dynamic>? result; bool loading = false;

  void getPrediction() async{
    setState(() => loading= true);
    try {
  final res = await
  fetchPrediction(_controller.text.trim());
  setState(() {
  result = res;
  loading = false;
  });
  }catch (e){
      setState(() {
        result ={"error": e.toString()};
        loading = false;
      });
  }
}
@override
Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(title: Text("Stock AI Advisor")),
  body: Padding(padding: const EdgeInsets.all(16.0),
  child: Column(children: [TextField(controller: _controller, decoration: InputDecoration(labelText: "Enter Symbol e.g., NSEI"),
  ),
  SizedBox(height: 10),
  ElevatedButton(onPressed: getPrediction, child: Text("Analyze"),
  ),
  SizedBox(height: 20),
  loading
     ?
  CircularProgressIndicator()
      :result == null
  ? Container():
      result!.containsKey("error")?Text("Error: ${result!['error']}"):Card(
  child: Padding(padding: const EdgeInsets.all(16.0),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Signal: ${result!['signak']}"),
  Text("Trend: ${result!['trend']}"),
  Text("Entry: ${result!['entry']}"),
  Text("Target: ${result!['target']}"),
  Text("Stoploss: ${result!['stoploss']}"),
  Text("Confidence: ${result!['confidence']}"),
  ],
  ),
  ),
  )
  ]),
  ),
    );
  }
}