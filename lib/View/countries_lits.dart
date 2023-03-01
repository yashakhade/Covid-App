
import 'package:covid_app/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: _search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.fetchCountries(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context,index){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                            title: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name  = snapshot.data![index]['country'];

                        if(_search.text.isEmpty){
                          return Column(
                            children: [
                              ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                  ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>
                                    DetailScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        totalRecoverd: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecoverd: snapshot.data![index]['todayRecovered'],
                                        test: snapshot.data![index]['tests'])
                                    ));
                              },
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(_search.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>
                                          DetailScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecoverd: snapshot.data![index]['recovered'],
                                              active: snapshot.data![index]['active'],
                                              critical: snapshot.data![index]['critical'],
                                              todayRecoverd: snapshot.data![index]['todayRecovered'],
                                              test: snapshot.data![index]['tests'])
                                      ));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Container();
                        }


                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
