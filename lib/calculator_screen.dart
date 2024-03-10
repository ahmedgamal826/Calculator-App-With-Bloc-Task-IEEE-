import 'package:calculator_app_new/bloc/calculator_bloc.dart';
import 'package:calculator_app_new/bloc/calculator_events.dart';
import 'package:calculator_app_new/bloc/calculator_state.dart';
import 'package:calculator_app_new/buttons_list.dart';
import 'package:calculator_app_new/cubit/calculator_cubit.dart';
import 'package:calculator_app_new/cubit/calculator_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Calculator With Bloc',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: 100,
            alignment: Alignment.topRight,
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Text(
                  // overflow: TextOverflow.clip,
                  state.input,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.topRight,
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return Text(
                  state.output,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0, crossAxisSpacing: 5, crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<CalculatorBloc>().add(
                              CalculatorButtonsEvent(
                                  ButtonText: buttons[index]));
                        },
                        child: Text(
                          buttons[index],
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
