import 'package:flutter/material.dart';
import 'package:petspaw_user/common_widgets.dart/custom_search.dart';

class HospitalScreen extends StatelessWidget {
  final List<Map<String, String>> hospitals = [
    {
      'name': 'City Animal Hospital',
      'image':
          'https://plus.unsplash.com/premium_photo-1661962620229-614e281fe009?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV0JTIwaG9zcGl0YWx8ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Pet Care Clinic',
      'image':
          'https://plus.unsplash.com/premium_photo-1661962620229-614e281fe009?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV0JTIwaG9zcGl0YWx8ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Animal Wellness Center',
      'image':
          'https://plus.unsplash.com/premium_photo-1661962620229-614e281fe009?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGV0JTIwaG9zcGl0YWx8ZW58MHx8MHx8fDA%3D',
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
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final hospital = hospitals[index];
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
                      child: Image.network(
                        hospital['image']!,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        hospital['name']!,
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
