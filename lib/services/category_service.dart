import 'package:mtodo/models/category.dart';
import 'package:mtodo/repositories/repository.dart';

class CategoryService{

  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category) async{
   return await _repository.save('categories', category.createMap());
  }

  getCategories() async{
    return await _repository.getAll('categories');

  }

   getCategoryById(categoryId) async {
    return await _repository.getById('categories', categoryId);
   }

  updateCategory(Category category) async{
    return await _repository.update('categories', category.createMap());
  }

  deleteCategory(categoryId) async{
    return await _repository.delete('categories', categoryId);
  }

}

