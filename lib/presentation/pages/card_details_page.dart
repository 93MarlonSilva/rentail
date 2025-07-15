import 'package:flutter/material.dart';
import 'package:rentail/data/models/car.dart';
import 'package:rentail/presentation/widgets/car_card.dart';
import 'package:rentail/presentation/widgets/more.card.dart';

import 'maps_details_page.dart';

class CardDetailsPage extends StatelessWidget {
  final Car car;
  const CardDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Information')
          ],
        ),
      ),
      body: Column(
        children: [
          CarCard(car: Car(model: car.model, distance: car.distance, fuelCapacity: car.fuelCapacity, pricePerHour: car.pricePerHour)),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 40,backgroundImage: AssetImage('assets/user.png'),),
                        SizedBox(height: 10,),
                        Text('Jane Cooper', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('\$4.253', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                   Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => MapsDetailsPage()
                      )),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage('assets/maps.png'),
                                fit: BoxFit.cover
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 5
                              )
                            ]
                        ),
                      ),
                    ),

                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 8,
              children: [
                MoreCard(car: Car(model: '${car.model} 1', distance: car.distance + 100, fuelCapacity: car.fuelCapacity + 100, pricePerHour: car.pricePerHour + 100)),
                MoreCard(car: Car(model: '${car.model} 2', distance: car.distance + 200, fuelCapacity: car.fuelCapacity + 200, pricePerHour: car.pricePerHour + 200)),
                MoreCard(car: Car(model: '${car.model} 3', distance: car.distance + 300, fuelCapacity: car.fuelCapacity + 300, pricePerHour: car.pricePerHour + 300)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
