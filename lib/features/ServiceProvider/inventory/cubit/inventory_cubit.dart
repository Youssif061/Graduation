import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/repository/inventory_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/repository/inventory_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_state.dart';

enum InventoryFilter {
  all,
  active,
  lowStock,
  outOfStock,
}

enum InventorySort {
  newest,
  oldest,
  priceLowHigh,
  priceHighLow,
  nameAZ,
  nameZA,
}

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit()
      : _repository = InventoryRepositoryImpl(),
        super(const InventoryInitial());

  final InventoryRepository _repository;

  List<ProductModel> products = [];

  List<ProductModel> filteredProducts = [];

  String searchText = "";

  InventoryFilter currentFilter =
      InventoryFilter.all;

  InventorySort currentSort =
      InventorySort.newest;

  //---------------------------------------
  // Load Inventory
  //---------------------------------------

  Future<void> loadInventory() async {
    try {
      emit(const InventoryLoading());

      products =
          await _repository.loadInventory();

      _applyFilters();
    } catch (e) {
      emit(
        InventoryFailure(
          e.toString(),
        ),
      );
    }
  }

  //---------------------------------------
  // Refresh
  //---------------------------------------

  Future<void> refresh() async {
    await loadInventory();
  }

  //---------------------------------------
  // Search
  //---------------------------------------

  void search(String value) {
    searchText = value.trim();

    _applyFilters();
  }

  void clearSearch() {
    searchText = "";

    _applyFilters();
  }

  //---------------------------------------
  // Filter
  //---------------------------------------

  void changeFilter(
    InventoryFilter filter,
  ) {
    currentFilter = filter;

    _applyFilters();
  }

  //---------------------------------------
  // Sort
  //---------------------------------------

  void changeSort(
    InventorySort sort,
  ) {
    currentSort = sort;

    _applyFilters();
  }

  //---------------------------------------
  // Apply Search + Filter + Sort
  //---------------------------------------

  void _applyFilters() {
    filteredProducts =
        List<ProductModel>.from(products);

    // Search

    if (searchText.isNotEmpty) {
      filteredProducts =
          filteredProducts.where((product) {
        return product.name
                .toLowerCase()
                .contains(
                  searchText.toLowerCase(),
                ) ||
            product.category
                .toLowerCase()
                .contains(
                  searchText.toLowerCase(),
                );
      }).toList();
    }

    // Filter

    switch (currentFilter) {
      case InventoryFilter.all:
        break;

      case InventoryFilter.active:
        filteredProducts =
            filteredProducts.where(
          (product) {
            return product.stock > 0;
          },
        ).toList();
        break;

      case InventoryFilter.lowStock:
        filteredProducts =
            filteredProducts.where(
          (product) {
            return product.stock > 0 &&
                product.stock <= 5;
          },
        ).toList();
        break;

      case InventoryFilter.outOfStock:
        filteredProducts =
            filteredProducts.where(
          (product) {
            return product.stock == 0;
          },
        ).toList();
        break;
    }

    // Sort
        switch (currentSort) {
      case InventorySort.newest:
        filteredProducts.sort(
          (a, b) =>
              b.createdAt.compareTo(a.createdAt),
        );
        break;

      case InventorySort.oldest:
        filteredProducts.sort(
          (a, b) =>
              a.createdAt.compareTo(b.createdAt),
        );
        break;

      case InventorySort.priceLowHigh:
        filteredProducts.sort(
          (a, b) =>
              a.price.compareTo(b.price),
        );
        break;

      case InventorySort.priceHighLow:
        filteredProducts.sort(
          (a, b) =>
              b.price.compareTo(a.price),
        );
        break;

      case InventorySort.nameAZ:
        filteredProducts.sort(
          (a, b) =>
              a.name.toLowerCase().compareTo(
                    b.name.toLowerCase(),
                  ),
        );
        break;

      case InventorySort.nameZA:
        filteredProducts.sort(
          (a, b) =>
              b.name.toLowerCase().compareTo(
                    a.name.toLowerCase(),
                  ),
        );
        break;
    }

    emit(
      InventoryLoaded(
        products: List<ProductModel>.from(
          filteredProducts,
        ),
      ),
    );
  }

  //---------------------------------------
  // Delete Product
  //---------------------------------------

  Future<void> deleteProduct(
    String productId,
  ) async {
    try {
      emit(const InventoryDeleting());

      await _repository.deleteProduct(
        productId,
      );

      products.removeWhere(
        (product) =>
            product.id == productId,
      );

      _applyFilters();
    } catch (e) {
      emit(
        InventoryFailure(
          e.toString(),
        ),
      );
    }
  }
}