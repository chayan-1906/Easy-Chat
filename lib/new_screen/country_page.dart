import 'package:easy_chat/model/country_model.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final Function setCountryData;
  const CountryPage({Key key, this.setCountryData}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    // CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    // CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    // CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    // CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    // CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    // CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    // CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Choose a country',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.teal,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            return customCard(countries[index]);
          }),
    );
  }

  Widget customCard(CountryModel countryModel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.setCountryData(countryModel);
        });
      },
      child: Card(
        margin: EdgeInsets.all(0.15),
        child: Container(
          height: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
            children: [
              Text(countryModel.flag),
              SizedBox(width: 15.0),
              Text(countryModel.name),
              SizedBox(width: 15.0),
              Expanded(
                child: Container(
                  width: 150.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(countryModel.code),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
