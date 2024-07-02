import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/entity/weather_entity.dart';
import 'package:weather_app/features/search_city/presentation/bloc/weather_bloc.dart';

class WeatherDetailScreen extends StatefulWidget {
  WeatherEntity weather;
  WeatherDetailScreen({super.key, required this.weather});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(),
          actions: [
            GestureDetector(
              onTap: () {
                _controller.forward(from: 0.0);
                context
                    .read<WeatherBloc>()
                    .add(RefreshWeatherEvent(city: widget.weather.cityName));
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * 3.141592653589793,
                    child: child,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.refresh_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherRefreshed) {
              widget.weather = state.weatherEntity;
            }
          },
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg.webp",
                      ),
                      fit: BoxFit.fill)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        widget.weather.cityName,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${(widget.weather.tempKelvin - 273.15).truncate()}°",
                      style: const TextStyle(fontSize: 70),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Weather Condition :",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(widget.weather.condition,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Image.network(
                                "https://openweathermap.org/img/wn/${widget.weather.icon}@2x.png"),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Humidity : ${widget.weather.humidity}%",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Windspeed : ${widget.weather.windSpeed}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
