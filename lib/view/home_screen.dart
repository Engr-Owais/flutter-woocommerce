import 'package:flutter/material.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    homeViewViewModel.fetchProdListApi(page, '', '');
    homeViewViewModel.fetchCatListApi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        homeViewViewModel.setLoadingStatus(LodeMoreStatus.LOADING);
        homeViewViewModel.fetchProdListApi(++page, '', '');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    // Initial Selected Value

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.order_history);
            },
            child: Center(child: Icon(Icons.history))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      userPrefernece.remove().then((value) {
                        Navigator.pushNamed(context, RoutesName.signUp);
                      });
                    },
                    child: Center(child: Icon(Icons.logout))),
              ],
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        // builder: ,
        child: Consumer<HomeViewViewModel>(builder: (context, model, _) {
          if (model.catList.status! == Status.LOADING) {
            return Center(child: CircularProgressIndicator());
          } else if (model.catList.status! == Status.ERROR) {
            return Center(child: Text(model.productsList.message.toString()));
          } else if (model.catList.status == Status.COMPLETED) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Categories"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 70.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(model.catList.data!.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.clear();
                                  controller.text = '';

                                  model.setChip(
                                      model.catList.data![index].id!.toString(),
                                      index);
                                  model.fetchProdListApi(
                                    page,
                                    model.catList.data![index].id!.toString(),
                                    controller.text,
                                  );
                                },
                                child: Consumer<HomeViewViewModel>(
                                  builder: (context, value, child) {
                                    return Chip(
                                      backgroundColor:
                                          index == model.coloredChip
                                              ? Colors.blue
                                              : Colors.amber,
                                      label: Text(
                                          model.catList.data![index].name!),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      MaterialButton(
                        child: Text("Cler Filters"),
                        onPressed: () {
                          model.chipSelected = '';
                          model.coloredChip = null;
                          model.fetchProdListApi(page, '', '');
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Search"),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Card(
                      child: new ListTile(
                        leading: new Icon(Icons.search),
                        title: new TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          // onChanged: (value) =>
                          //     model.fetchProdListApi(model.chipSelected, value),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            model.fetchProdListApi(
                              page,
                              model.chipSelected,
                              controller.text,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<HomeViewViewModel>(
                    builder: (context, model, child) {
                      if (model.productsList.status! == Status.LOADING) {
                        return Center(child: CircularProgressIndicator());
                      } else if (model.productsList.status! == Status.ERROR) {
                        return Center(
                            child: Text(model.productsList.message.toString()));
                      } else if (model.productsList.status! ==
                          Status.COMPLETED) {
                        if (model.productsList.data!.length > 0 &&
                            model.getLoadMoreStatus() !=
                                LodeMoreStatus.INITIAL) {
                          model.getLoadMoreStatus() == LodeMoreStatus.LOADING;
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: model.productsList.data!.length,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RoutesName.detail,
                                                arguments: model
                                                    .productsList.data![index]);
                                          },
                                          title: Text(model
                                              .productsList.data![index].name!),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              model.productsList.data![index]
                                                          .price !=
                                                      ''
                                                  ? Text(model.productsList
                                                      .data![index].price!)
                                                  : Text("No Price"),
                                              Text(model
                                                  .productsList
                                                  .data![index]
                                                  .categories!
                                                  .first
                                                  .name
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: model
                                                            .productsList
                                                            .data![index]
                                                            .stockQuantity !=
                                                        null
                                                    ? Colors.green
                                                    : Colors.red,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Visibility(
                                child: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                                visible: model.getLoadMoreStatus() ==
                                        LodeMoreStatus.LOADING
                                    ? true
                                    : false,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text("NO DATA SORRY !"),
                          );
                        }
                      } else
                        return SizedBox.expand();
                    },
                  ),
                ),
              ],
            );
          } else
            return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
