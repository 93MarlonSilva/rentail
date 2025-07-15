import 'package:flutter/material.dart';
import 'package:rentail/data/models/car.dart';
import 'package:rentail/presentation/widgets/car_card.dart';
import 'package:rentail/presentation/widgets/more.card.dart';

import 'maps_details_page.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;
  const CarDetailsPage({super.key, required this.car});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)..addListener(() { setState(() {
    }); });
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

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
          CarCard(car: Car(model: widget.car.model, distance: widget.car.distance, fuelCapacity: widget.car.fuelCapacity, pricePerHour: widget.car.pricePerHour)),
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
                      builder: (context) => MapsDetailsPage(car: widget.car),
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
                        child: ClipRRect(
                           borderRadius: BorderRadius.circular(20),
                          child: Transform.scale(
                            scale: _animation!.value,
                            alignment: Alignment.center,
                            child: Image.asset('assets/maps.png', fit: BoxFit.cover,),
                          ),
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
                MoreCard(car: Car(model: '${widget.car.model} 1', distance: widget.car.distance + 100, fuelCapacity: widget.car.fuelCapacity + 100, pricePerHour: widget.car.pricePerHour + 100)),
                MoreCard(car: Car(model: '${widget.car.model} 2', distance: widget.car.distance + 200, fuelCapacity: widget.car.fuelCapacity + 200, pricePerHour: widget.car.pricePerHour + 200)),
                MoreCard(car: Car(model: '${widget.car.model} 3', distance: widget.car.distance + 300, fuelCapacity: widget.car.fuelCapacity + 300, pricePerHour: widget.car.pricePerHour + 300)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
