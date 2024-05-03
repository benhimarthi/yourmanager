import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/categories/domain/entities/category.dart';

class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class AddCategorySuccessfully extends CategoryState {
  const AddCategorySuccessfully();
}

class AddCategoryFailed extends CategoryState {
  final String message;
  const AddCategoryFailed(this.message);
}

class GetCategorySuccessfully extends CategoryState {
  final Category category;
  const GetCategorySuccessfully(this.category);
}

class GetCategoryFailed extends CategoryState {
  final String message;
  const GetCategoryFailed(this.message);
}

class GetAllCategoriesSuccessfully extends CategoryState {
  final List<Category> categories;
  const GetAllCategoriesSuccessfully(this.categories);
}

class GetAllCategoryFailed extends CategoryState {
  final String message;
  const GetAllCategoryFailed(this.message);
}

class UpdateCategorySuccessfully extends CategoryState {
  const UpdateCategorySuccessfully();
}

class UpdateCategoryFailed extends CategoryState {
  final String message;
  const UpdateCategoryFailed(this.message);
}

class DeleteCategorySuccessfully extends CategoryState {
  const DeleteCategorySuccessfully();
}

class DeleteCategoryFailed extends CategoryState {
  final String message;
  const DeleteCategoryFailed(this.message);
}
