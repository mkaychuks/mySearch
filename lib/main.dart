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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Countries'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchCountriesDelegate());
            },
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// My dummy data for the search engine..
final cities = [
  'France',
  'Germany',
  'Brazil',
  'Morocco',
  'Argentina',
  'Madagascar',
  'Canada',
  'Netherlands'
];

final recentCities = ['Madagascar', 'Canada', 'Netherlands'];

// my search delegate for the search engine
class SearchCountriesDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return  NewScreen(text: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.travel_explore),
        title: Text(
          suggestions[index],
        ),
        onTap: () {
          query = suggestions[index];
          // showResults(context);
          close(context, "");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewScreen(
                text: query,
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text(text!),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 60,),
            Text(text!, style: const TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
