import 'package:earthquake/bloc/earthquake_bloc.dart';
import 'package:earthquake/data/domain/earthquake.dart';
import 'package:earthquake/service_locator.dart';
import 'package:earthquake/widgets/earthquake_card.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String ROUTE_ID = "main-screen-path";
  MainScreen({Key? key}) : super(key: key);
  final bloc = getit<EarthquakeBloc>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<List<Earthquake>>(
            stream: widget.bloc.earthquakes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Earthquake> earthquakes = snapshot.data!;
                return ListView.builder(
                    controller: scrollController,
                    itemCount: earthquakes.length,
                    itemBuilder: (context, index) =>
                        EarthquakeCard(earthquake: earthquakes[index]));
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder<bool>(
              stream: widget.bloc.loading,
              builder: (context, snapshot) {
                return Visibility(
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  ),
                  visible: snapshot.hasData ? snapshot.data! : false,
                );
              }),
        ],
      ),
    );
  }

  void loadMore() async {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 20 &&
        !scrollController.position.outOfRange) {
      await widget.bloc.loadMore();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }
}
