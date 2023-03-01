import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Models/world_state.dart';
import '../services/state_services.dart';
import 'countries_lits.dart';

class WorldScore extends StatefulWidget {
  const WorldScore({Key? key}) : super(key: key);

  @override
  State<WorldScore> createState() => _WorldScoreState();
}

class _WorldScoreState extends State<WorldScore> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [

  ];



  @override
  Widget build(BuildContext context) {
    
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          FutureBuilder(
              future: stateServices.fetchRecord(),
              builder: (context,AsyncSnapshot<WorldState> snapshot){
                if(!snapshot.hasData){
                  return Expanded(child: SpinKitFadingCircle(
                      color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ));
                }else{
                    return Column(
                      children: [
                         Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: PieChart(

                             dataMap: {
                             'Total': double.parse(snapshot.data!.cases.toString()),
                             'Recovered': double.parse(snapshot.data!.recovered.toString()),
                             'Death': double.parse(snapshot.data!.deaths.toString())
                             },
                             chartValuesOptions: const ChartValuesOptions(
                               showChartValuesInPercentage: true
                             ),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: [
                              Color(0xff4285F4),
                              Color(0xff1aa260),
                              Color(0xffde5246),
                            ],
                        ),
                         ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReusableRow(title: 'TodayDeaths', value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: 'TodayRecovered', value: snapshot.data!.todayRecovered.toString()),

                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(187, 50, 35, 1.0), // background
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  )
                              ),
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> CountryList()));
                              },
                              child: Text('Track Countries',style: TextStyle(fontSize: 22))),
                        )
                      ],
                    );
                }
          }),

        ],
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 18),),
              Text(value,style: TextStyle(fontSize: 18),),
            ],
          ),
        ],
      ),
    );
  }
}

