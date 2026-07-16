import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(const InventoryInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> products = [];

  List<ProductModel> filteredProducts = [];

  String searchText = "";

  ///==============================
  /// Load Inventory
  ///==============================

  Future<void> loadInventory({
    required String providerId,
  }) async {
    try {
      emit(const InventoryLoading());

      final snapshot = await _firestore
          .collection("products")
          .where(
            "providerId",
            isEqualTo: providerId,
          )
          .orderBy(
            "createdAt",
            descending: true,
          )
          .get();

      products = snapshot.docs
          .map(
            (doc) => ProductModel.fromJson(
              doc.data(),
              doc.id,
            ),
          )
          .toList();

      filteredProducts = List.from(products);

      emit(
        InventoryLoaded(
          filteredProducts,
        ),
      );
    } on FirebaseException catch (e) {
      emit(
        InventoryFailure(
          e.message ?? "Firebase Error",
        ),
      );
    } catch (e) {
      emit(
        InventoryFailure(
          e.toString(),
        ),
      );
    }
  }

  ///==============================
  /// Search
  ///==============================

  void search(String value) {
    searchText = value;

    if (value.trim().isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products.where((product) {
        return product.name
                .toLowerCase()
                .contains(
                  value.toLowerCase(),
                ) ||
            product.category
                .toLowerCase()
                .contains(
                  value.toLowerCase(),
                );
      }).toList();
    }

    emit(
      InventoryLoaded(
        filteredProducts,
      ),
    );
  }

  ///==============================
  /// Delete Product
  ///==============================

  Future<void> deleteProduct(
    String productId,
  ) async {
    try {
      emit(const InventoryDeleting());

      await _firestore
          .collection("products")
          .doc(productId)
          .delete();

      products.removeWhere(
        (e) => e.id == productId,
      );

      filteredProducts.removeWhere(
        (e) => e.id == productId,
      );

      emit(
        InventoryLoaded(
          filteredProducts,
        ),
      );
    } on FirebaseException catch (e) {
      emit(
        InventoryFailure(
          e.message ?? "Delete Failed",
        ),
      );
    } catch (e) {
      emit(
        InventoryFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> refresh(
    String providerId,
  ) async {
    await loadInventory(
      providerId: providerId,
    );
  }
}