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
  InventoryCubit({
    InventoryRepository? repository,
  })  : _repository = repository ?? InventoryRepositoryImpl(),
        super(const InventoryInitial());

  final InventoryRepository _repository;

  List<ProductModel> _products = [];

  List<ProductModel> filteredProducts = [];

  String searchText = "";

  InventoryFilter currentFilter = InventoryFilter.all;

  InventorySort currentSort = InventorySort.newest;

  //---------------------------------------------------------
  // Load
  //---------------------------------------------------------

  Future<void> loadInventory() async {
    emit(const InventoryLoading());

    try {
      _products = await _repository.loadInventory();

      _applyFilters();
    } catch (e) {
      emit(
        InventoryFailure(
          e.toString(),
        ),
      );
    }
  }

  //---------------------------------------------------------
  // Refresh
  //---------------------------------------------------------

  Future<void> refresh() async {
    await loadInventory();
  }

  //---------------------------------------------------------
  // Search
  //---------------------------------------------------------

  void search(String value) {
    searchText = value.trim();

    _applyFilters();
  }

  void clearSearch() {
    searchText = "";

    _applyFilters();
  }

  //---------------------------------------------------------
  // Filter
  //---------------------------------------------------------

  void changeFilter(
    InventoryFilter filter,
  ) {
    currentFilter = filter;

    _applyFilters();
  }

  //---------------------------------------------------------
  // Sort
  //---------------------------------------------------------

  void changeSort(
    InventorySort sort,
  ) {
    currentSort = sort;

    _applyFilters();
  }

  //---------------------------------------------------------
  // Delete Product
  //---------------------------------------------------------

  Future<void> deleteProduct(
    String productId,
  ) async {
    emit(const InventoryDeleting());

    try {
      await _repository.deleteProduct(
        productId,
      );

      _products.removeWhere(
        (product) => product.id == productId,
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

  //---------------------------------------------------------
  // Search + Filter + Sort
  //---------------------------------------------------------

  void _applyFilters() {
    filteredProducts = List<ProductModel>.from(
      _products,
    );

    //---------------- Search ----------------//

    if (searchText.isNotEmpty) {
      filteredProducts = filteredProducts.where(
        (product) {
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
        },
      ).toList();
    }

    //---------------- Filter ----------------//

    switch (currentFilter) {
      case InventoryFilter.all:
        break;

      case InventoryFilter.active:
        filteredProducts = filteredProducts.where(
          (product) {
            return product.stock > 0;
          },
        ).toList();
        break;

      case InventoryFilter.lowStock:
        filteredProducts = filteredProducts.where(
          (product) {
            return product.stock > 0 &&
                product.stock <= 5;
          },
        ).toList();
        break;

      case InventoryFilter.outOfStock:
        filteredProducts = filteredProducts.where(
          (product) {
            return product.stock == 0;
          },
        ).toList();
        break;
    }

    //---------------- Sort ----------------//

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
              a.name.compareTo(b.name),
        );
        break;

      case InventorySort.nameZA:
        filteredProducts.sort(
          (a, b) =>
              b.name.compareTo(a.name),
        );
        break;
    }

    emit(
      InventoryLoaded(
        products: filteredProducts,
      ),
    );
  }
}