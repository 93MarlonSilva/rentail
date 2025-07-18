import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentail/presentation/bloc/car_bloc.dart';
import 'package:rentail/presentation/bloc/car_state.dart';
import 'package:rentail/presentation/widgets/car_card.dart';

import '../../data/models/car.dart';
import 'car_details_page.dart';

class CarListScreen extends StatelessWidget {
  // final List<Car> cars = [
  // Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),
  // Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45),//  Car(model: 'Fortuner GR', distance: 870, fuelCapacity: 50, pricePerHour: 45)
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose Your Car'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<CarBloc, CarState>(
            builder: (context, state) {
              if(state is CarsLoading) {
                return Center(child: CircularProgressIndicator(color: Colors.black87,),);
              } else if( state is CarsLoaded) {
                return ListView.builder(
                  itemCount: state.cars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(
                                car: state.cars[index],
                              ),
                            ),
                        ),
                        child: CarCard(car: state.cars[index],));
                  },
                );
              } else if( state is CarsError) {
                return Center(child: Text('Error: ${state.message}'),);
              }
            return Container();
           }
        )
    );
  }
}
