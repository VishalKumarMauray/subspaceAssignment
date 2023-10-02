import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:subspace/data/model/blogsModel.dart';
import 'package:subspace/provider/homeProvider.dart';
import 'package:subspace/utils/constant.dart';

class FavouriteBlogs extends StatefulWidget {
  const FavouriteBlogs({super.key});

  @override
  State<FavouriteBlogs> createState() => _FavouriteBlogsState();
}

class _FavouriteBlogsState extends State<FavouriteBlogs> {
  late HomeProvider home;

  @override
  void initState() {
    home = context.read<HomeProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Blogs",style: TextStyle(color: Colors.white),),
        backgroundColor: K.primary,
       automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: ValueListenableBuilder(
        valueListenable: home.favBlogs,
        builder: (context,List<Blogs> data,_) {
          if(data.isEmpty){
            return Center(
              child: Text("No Data Found!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: "${data[index].imageUrl}",
                        height: 80,
                        fit: BoxFit.cover,
                        width: 80,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(child: Text("${data[index].title}",textAlign: TextAlign.start,)),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}
