import 'package:flutter/cupertino.dart';
import 'package:subspace/data/model/blogsModel.dart';
import 'package:subspace/data/repository/repository.dart';

class HomeProvider {
  final HomeRepository _homeRepository;

  HomeProvider(this._homeRepository);

  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<List<Blogs>> blogData = ValueNotifier([]);
  ValueNotifier<List<Blogs>> favBlogs = ValueNotifier([]);
  ValueNotifier<List<bool>> isFav = ValueNotifier([]);

  fetchBlogs() async{
    try {
      isLoading.value = true;
    var res = await _homeRepository.fetchBlogs();
    if(res != null){
      blogData.value = [];
      blogData.value.addAll(res.blogs as Iterable<Blogs>);
      isFav.value = List.filled(blogData.value.length, false);
    }
    } catch (e) {
      print("error ${e.toString()}");
    }finally{
      isLoading.value = false;
    }
  }

  blogExist(String id) {
    for(int i=0;i<favBlogs.value.length;i++){
      if(id == favBlogs.value[i].id){
        return "yes";
      }
    }
  }
}