import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saverecipe/constant.dart';
import 'package:saverecipe/models/category_model.dart';
import 'package:saverecipe/models/recipe_model.dart';
import 'package:saverecipe/provider/app_provider.dart';
import 'package:saverecipe/repository/category_repo.dart';
import 'package:saverecipe/repository/recipe_repo.dart';

class HiveDb {
  Future initHive() async {
    await Hive.initFlutter();
   await Hive.registerAdapter(
     CategoryModelAdapter(),
   );
   await Hive.registerAdapter(
     RecipeModelAdapter(),
   );
    //TODO: clean up
    RecipeRepo recipeRepo = RecipeRepo();
    initTestData();
  }

  void initTestData() async {
    final List<CategoryModel> _categories = [
      CategoryModel(
        "Noodles",
        imageUrl: kImageUrlRecipeOfDay, recipes: null, file: null, dominantImageColor: null,
      ),
      CategoryModel('Rice', imageUrl: kImageUrlRecipeOfDay, dominantImageColor: null, file: null, id: '', recipes: null),
      CategoryModel('Chicken', imageUrl: kImageUrlRecipeOfDay),
      CategoryModel('Beef', imageUrl: kImageUrlRecipeOfDay),
      CategoryModel('Veggie', imageUrl: kImageUrlRecipeOfDay)
    ];

    CategoryRepo _repo = CategoryRepo();

    var categories = await _repo.readCategories();
    if (categories.isEmpty)
      _categories.forEach((element) {
        element.id = uuid.v4();
        _repo.saveCategory(element);
      });
  }
}
