import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:subspace/UI/Home/blogDetailPage.dart';
import 'package:subspace/data/model/blogsModel.dart';
import 'package:subspace/data/repository/repository.dart';
import 'package:subspace/provider/homeProvider.dart';
import 'package:subspace/utils/constant.dart';

import 'favouriteBlogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider home;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    home = HomeProvider(context.read<HomeRepository>());
    super.initState();
    home.fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs",style: TextStyle(color: Colors.white),),
        backgroundColor: K.primary,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Provider.value(value: home,child: const FavouriteBlogs(),)));
          }, icon: const Icon(Icons.favorite,color: Colors.red,size: 28,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
        child: ValueListenableBuilder(
          valueListenable: home.isLoading,
          builder: (context,bool loading,_) {
            if(loading){
              return const Center(child: CircularProgressIndicator(color: K.secondary,),);
            }
            return ValueListenableBuilder(
              valueListenable: home.blogData,
              builder: (context,List<Blogs> data,_) {
                if(data.isEmpty){
                  return const Center(
                    child: Text("Something went wrong!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                  );
                }
                return MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlogDetailPage(data: home.blogData.value[index],isFav: home.isFav.value[index],)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: K.secondary.withOpacity(0.3),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: "${data[index].imageUrl}",
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 1.sw,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
                                  child: Text("${data[index].title}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: ValueListenableBuilder(
                            valueListenable: home.isFav,
                            builder: (context,List<bool> fav,_) {
                              return IconButton(
                                onPressed: () async{
                                  home.isFav.value[index] = !home.isFav.value[index];
                                  home.isFav.notifyListeners();
                                  print(fav[index]);
                                  var res = await home.blogExist("${home.blogData.value[index].id}");
                                  if(res == "yes"){
                                    home.favBlogs.value.removeWhere((element) => element.id == home.blogData.value[index].id);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Blog removed from favourite!"),duration: Duration(seconds:1)));
                                  }else{
                                    home.favBlogs.value.add(home.blogData.value[index]);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Blog added to favourite!"),duration: Duration(seconds: 1),));
                                  }
                                },
                                icon: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child:fav[index] ? const Icon(Icons.favorite,color: Colors.red,size: 20,):const Icon(Icons.favorite_outline,color: Colors.red,size: 20,)),
                              );
                            }
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            );
          }
        ),
      ),
    );
  }
}
