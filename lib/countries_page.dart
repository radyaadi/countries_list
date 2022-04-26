import 'package:flutter/material.dart';
import 'package:countries_list/model.dart';
import 'package:countries_list/data_source.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries List"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (BuildContext context,
            AsyncSnapshot<dynamic> snapshot,) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CountriesModel data) {
    return ListView.builder(
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCountries("${data.countries?[index].name}", "${data.countries?[index].iso3}");
      },
    );
  }

  Widget _buildItemCountries(String name, String iso) {
    //return Text(value1);
    return Card(
      child: InkWell(
        onTap: (){
          debugPrint(name);
        },
        child: SizedBox(
          height: 80,
          child: Center(
            child: Column(
              children: [
                Text(name),
                Text(iso)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
