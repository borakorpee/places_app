import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/place_provider.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<PlaceProvider>(
          child: const Center(child: Text('No Places Yet')),
          builder: (ctx, places, ch) => places.items.length == 0
              ? ch
              : ListView.builder(
                  itemCount: places.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        places.items[i].image,
                      ),
                    ),
                    title: Text(places.items[i].title),
                    onTap: () {},
                  ),
                )),
    );
  }
}
