import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/cubit.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Shared/ResusableComponent.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  @override
  var searchContoller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onTap: () {
                    print('titletapped');
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getssearch(value);
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      labelText: "Enter Search",
                      hintText: "Title"),
                  controller: searchContoller,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) => nyDivider(),
                    itemCount: list.length),
              )
            ],
          ),
        );
      },
    );
  }
}
