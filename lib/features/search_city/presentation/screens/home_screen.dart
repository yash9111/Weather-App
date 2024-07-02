import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/snackbar/snackbar.dart';
import 'package:weather_app/features/search_city/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/search_city/presentation/screens/weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  String lastSearched = "Nothing to show here ";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherFetched) {
          final weather = state.weatherEntity;
          lastSearched = _controller.text;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WeatherDetailScreen(
                        weather: weather,
                      )));
        }
        if (state is WeatherFailure) {
          showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF), // White
                  Color(0xFF8381F9), // Blue
                ],
                stops: [0.5, 1],
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/cloud.png")),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Weather App",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SearchBar(
                    hintText: "Enter Location",
                    hintStyle: const MaterialStatePropertyAll(
                        TextStyle(color: Colors.grey)),
                    controller: _controller,
                    leading: const Icon(Icons.search),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(
                              Size(double.infinity, 50))),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context
                              .read<WeatherBloc>()
                              .add(GetWeatherEvent(city: _controller.text));
                        } else {
                          showSnackbar(context, "Please enter a city name");
                        }
                      },
                      child: const Text("Submit")),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Last Searched",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      lastSearched,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
