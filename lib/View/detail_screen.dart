
import 'package:covid_app/View/world_score.dart';
import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,totalDeaths, totalRecoverd, active,critical,todayRecoverd,test;

 DetailScreen({Key? key,
   required this.image,
   required this.name,
   required this.totalCases,
   required this.totalDeaths,
   required this.totalRecoverd,
   required this.active,
   required this.critical,
   required this.todayRecoverd,
   required this.test
 }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .05,),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.todayRecoverd.toString()),
                      ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'TotalRecovered', value: widget.totalRecoverd.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
