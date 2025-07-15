import 'package:rentail/data/datasources/firebase_car_data_surce.dart';
import 'package:rentail/domain/repositories/car_repository.dart';

import '../models/car.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseCarDataSource dataSource;

  CarRepositoryImpl(this.dataSource);

  @override
  Future<List<Car>> fetchCars() {
    return dataSource.getCars();
  }
}