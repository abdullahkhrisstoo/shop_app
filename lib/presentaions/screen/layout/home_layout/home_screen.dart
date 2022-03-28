// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/components.dart';
import 'package:project1/presentaions/screen/layout/home_layout/cubit/layout_cubit.dart';
import 'package:project1/presentaions/screen/layout/search_screen.dart';
import 'package:project1/presentaions/screen/login/login_screen.dart';

import '../../../../network/local/shared_pref_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getHomeDate()
        ..getCategoriesDate()
        ..getFavoriteProducts()
        ..getUserData(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    navigatTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                )
              ],
              title: const Text(
                'LABEL',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            body: cubit.bottomNavBar[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.items,
            ),
          );
        },
      ),
    );
  }
}
