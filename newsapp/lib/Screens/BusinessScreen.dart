import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Cubit/cubit.dart';
import 'package:newsapp/Shared/ResusableComponent.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! NewsGetBusinessLoadingState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(),
              separatorBuilder: (context, index) => nyDivider(),
              itemCount: 10),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
