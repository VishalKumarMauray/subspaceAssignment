import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subspace/data/model/blogsModel.dart';
import 'package:subspace/utils/constant.dart';

class BlogDetailPage extends StatelessWidget {
  final Blogs? data;
  final bool isFav;
  const BlogDetailPage({super.key,required this.data,required this.isFav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("",style: TextStyle(color: Colors.white),),
        backgroundColor: K.primary,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: "${data?.imageUrl}",
                  fit: BoxFit.cover,
                  width: 1.sw,
                ),
              ),
              SizedBox(height: 10,),
              Text("${data?.title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}
