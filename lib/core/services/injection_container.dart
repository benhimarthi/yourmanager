import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yourmanager/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:yourmanager/features/authentication/data/data_source/user_admin_manager_remote_data_source.dart';
import 'package:yourmanager/features/authentication/data/repositories/authentication_repository_implement.dart';
import 'package:yourmanager/features/authentication/data/repositories/user_admin_manager_repository_impl.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:yourmanager/features/authentication/domain/repositories/user_admin_manager_repository.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/black_list_user.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/delete_user_account.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_all_users.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_user.dart';
import 'package:yourmanager/features/authentication/domain/usecases/get_user_informations_from_google.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:yourmanager/features/authentication/domain/usecases/register_account_informations.dart';
import 'package:yourmanager/features/authentication/domain/usecases/register_account_with_email_and_password.dart';
import 'package:yourmanager/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:yourmanager/features/categories/datas/data_source/product_category_remote_data_source.dart';

import 'package:yourmanager/features/categories/datas/repositories/product_category_repository_impl.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';
import 'package:yourmanager/features/categories/domain/usecases/add_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/delete_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/get_all_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/get_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/update_product_category.dart';
import 'package:yourmanager/features/categories/presentation/cubit/product_category_cubit.dart';
import 'package:yourmanager/features/img_vids/datas/data_source/representation_remote_data_source.dart';
import 'package:yourmanager/features/img_vids/datas/repositories/images_repository.dart';
import 'package:yourmanager/features/img_vids/domain/repositories/representation_repository.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/delete_image.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/get_image.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/upload_image.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/product/data/data_source/product_remote_data_source.dart';
import 'package:yourmanager/features/product/data/repositories/product_repository_impl.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';
import 'package:yourmanager/features/product/domain/usecases/add_new_product.dart';
import 'package:yourmanager/features/product/domain/usecases/get_all_products.dart';
import 'package:yourmanager/features/product/domain/usecases/remove_product.dart';
import 'package:yourmanager/features/product/domain/usecases/update_product_informations.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:yourmanager/features/stock/data/repositories/stock_repository_impl_admin.dart';
import 'package:yourmanager/features/stock/data/stock_remote_data_source/stock_remote_data_src_admin.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository_admin.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/create_new_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_all_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_product_stock_by_product_id.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/remove_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/update_product_stock.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(
      () => AuthenticationCubit(
        login: sl(),
        registerAccountInformations: sl(),
        verifyPhoneNumber: sl(),
        getUserInfosFromGoogle: sl(),
        loginWithEmailAndPassword: sl(),
        registerAccountWithEmailAndPassword: sl(),
      ),
    )

    //Use cases
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => RegisterAccountInformations(sl()))
    ..registerLazySingleton(() => VerifyPhoneNumber(sl()))
    ..registerLazySingleton(() => GetUserInfosFromGoogle(sl()))
    ..registerLazySingleton(() => LoginWithEmailAndPassword(sl()))
    ..registerLazySingleton(() => RegisterAccountWithEmailAndPassword(sl()))

    //Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))

    //Data sources
    ..registerLazySingleton<AuthenticationRemoteDataSrc>(
        () => AuthenticationRemoteDataSrcImpl(sl(), sl(), sl()))

    //External Dependancies
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => GoogleSignIn());

  sl
    ..registerFactory(() => ProductManagerCubit(
          addAProduct: sl(),
          getAllProducts: sl(),
          removeProduct: sl(),
          updateProductInformations: sl(),
        ))
    ..registerLazySingleton(() => AddNewProduct(sl()))
    ..registerLazySingleton(() => GetAllProducts(sl()))
    ..registerLazySingleton(() => RemoveProduct(sl()))
    ..registerLazySingleton(() => UpdateProductInformations(sl()))
    ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()))
    ..registerLazySingleton<ProductRemoteDataSrc>(
        () => ProductRemoteDataScrImpl(sl()));

  sl
    ..registerFactory(() => RepresentationCubit(
          uploadImage: sl(),
          getImage: sl(),
          deleteImage: sl(),
        ))
    ..registerLazySingleton(() => UploadImage(sl()))
    ..registerLazySingleton(() => GetImage(sl()))
    ..registerLazySingleton(() => DeleteImage(sl()))
    ..registerLazySingleton<ReprensentionRepository>(
        () => ImagesRepository(sl()))
    ..registerLazySingleton<RepresentationRemoteDataSource>(
        () => RepresentationRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(() => FirebaseStorage.instance);

  sl
    ..registerFactory(
      () => ProductCategoryCubit(
        addProductCategory: sl(),
        getProductCategory: sl(),
        getAllProductCategory: sl(),
        updateProductCategory: sl(),
        deleteProductCategory: sl(),
      ),
    )
    ..registerLazySingleton(() => AddProductCategory(sl()))
    ..registerLazySingleton(() => GetProductCategory(sl()))
    ..registerLazySingleton(() => GetAllProductCategory(sl()))
    ..registerLazySingleton(() => UpdateProductCategory(sl()))
    ..registerLazySingleton(() => DeleteProductCategory(sl()))
    ..registerLazySingleton<ProductCategoryRepository>(
        () => ProductCategoryRepositoryImpl(sl()))
    ..registerLazySingleton<ProductCategoryRemoteDataSource>(
        () => ProductCategoryRemoteDataSourceImpl(sl()));

  sl
    ..registerFactory(
      () => StockAdminCubit(
        createNewProductStock: sl(),
        getProductStock: sl(),
        getProductStockByProductId: sl(),
        getAllProducts: sl(),
        removeProductStock: sl(),
        updateProductStock: sl(),
      ),
    )
    ..registerLazySingleton(() => CreateNewProductStock(sl()))
    ..registerLazySingleton(() => GetProductStock(sl()))
    ..registerLazySingleton(() => GetProductStockByProductId(sl()))
    ..registerLazySingleton(() => GetAllProductStock(sl()))
    ..registerLazySingleton(() => RemoveProductStock(sl()))
    ..registerLazySingleton(() => UpdateProductStock(sl()))
    ..registerLazySingleton<StockRepositoryAdmin>(
        () => StockRepositoryImplAdmin(sl()))
    ..registerLazySingleton<StockRemoteDataSourceAdmin>(
        () => StockRemoteDataSourceImpl(sl()));

  sl
    ..registerFactory(() => UserAdminManagerCubit(
          getUser: sl(),
          allUsers: sl(),
          blackListUser: sl(),
          deleteUserAccount: sl(),
        ))
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton(() => GetAllUsers(sl()))
    ..registerLazySingleton(() => BlackListUser(sl()))
    ..registerLazySingleton(() => DeleteUserAccount(sl()))
    ..registerLazySingleton<UserAdminManagerRepository>(
        () => UserAdminManagerRepositoryImpl(sl()))
    ..registerLazySingleton<UserAdminManagerRemoteDataSource>(
        () => UserAdminManagerRemoteDataSourceImpl(sl()));
}
