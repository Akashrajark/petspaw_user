import 'package:flutter/material.dart';
import 'package:petspaw_user/common_widgets.dart/custom_search.dart';

class PetStoreScreen extends StatelessWidget {
  final List<Map<String, String>> petStores = [
    {
      'name': 'Happy Paws Pet Store',
      'image': 'assets/images/dog2.jpg',
    },
    {
      'name': 'Furry Friends Shop',
      'image': 'assets/images/dog.jpg',
    },
    {
      'name': 'Pet Haven',
      'image': 'assets/images/dog.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: CustomSearch(
            onSearch: (sp) {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: petStores.length,
            itemBuilder: (context, index) {
              final store = petStores[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                      child: Image.asset(
                        store['image']!,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        store['name']!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
