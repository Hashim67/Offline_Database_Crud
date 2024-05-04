
import 'dart:convert';

import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';

CategoryModel categoryModelFromMap(String str) => CategoryModel.fromMap(json.decode(str));

String categoryModelToMap(CategoryModel data) => json.encode(data.toMap());

class CategoryModel {
    int? code;
    List<CategoryDatum>? data;

    CategoryModel({
        this.code,
        this.data,
    });

factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
    code: json["code"],
    data: json["data"] == null ? [] : (json["data"] is List<dynamic> ? List<CategoryDatum>.from(json["data"]!.map((x) => CategoryDatum.fromMap(x))) : []),
);



    Map<String, dynamic> toMap() => {
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };

  map(DatabaseCategoryModel Function(dynamic datum) param0) {}
}

class CategoryDatum {
    int? id;
    String? name;
    int? parentId;
    String? description;
    int? createdBy;
    String? categoryType;
    int? isAgeRestricted;
    String? ageRestricted;
    int? isReconciled;
    int? isReportDisplay;
    int? openPrice;
    String? image;
    String? imageUrl;
    List<ModifierSet>? modifierSets;

    CategoryDatum({
        this.id,
        this.name,
        this.parentId,
        this.description,
        this.createdBy,
        this.categoryType,
        this.isAgeRestricted,
        this.ageRestricted,
        this.isReconciled,
        this.isReportDisplay,
        this.openPrice,
        this.image,
        this.imageUrl,
        this.modifierSets,
    });

    factory CategoryDatum.fromMap(Map<String, dynamic> json) => CategoryDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        parentId: json["parent_id"] ?? 0,
        description: json["description"],
        createdBy: json["created_by"],
        categoryType: json["category_type"],
        isAgeRestricted: json["is_age_restricted"],
        ageRestricted: json["age_restricted"],
        isReconciled: json["is_reconciled"],
        isReportDisplay: json["is_report_display"],
        openPrice: json["open_price"],
        image: json["image"],
        imageUrl: json["image_url"],
        modifierSets: json["modifier_sets"] == null ? [] : List<ModifierSet>.from(json["modifier_sets"]!.map((x) => ModifierSet.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "description": description,
        "created_by": createdBy,
        "category_type": categoryType,
        "is_age_restricted": isAgeRestricted,
        "age_restricted": ageRestricted,
        "is_reconciled": isReconciled,
        "is_report_display": isReportDisplay,
        "open_price": openPrice,
        "image": image,
        "image_url": imageUrl,
        "modifier_sets": modifierSets == null ? [] : List<dynamic>.from(modifierSets!.map((x) => x.toMap())),
    };

  toDatabaseModel() {}
}

class ModifierSet {
    int? id;
    String? name;
    int? businessId;
    String? type;
    dynamic unitId;
    dynamic subUnitIds;
    dynamic brandId;
    dynamic categoryId;
    dynamic subCategoryId;
    dynamic tax;
    String? taxType;
    int? enableStock;
    String? alertQuantity;
    String? sku;
    dynamic plu;
    String? barcodeType;
    dynamic expiryPeriod;
    dynamic expiryPeriodType;
    int? enableSrNo;
    dynamic weight;
    dynamic productCustomField1;
    dynamic productCustomField2;
    dynamic productCustomField3;
    dynamic productCustomField4;
    dynamic image;
    dynamic productDescription;
    int? createdBy;
    dynamic warrantyId;
    int? isInactive;
    dynamic repairModelId;
    int? notForSelling;
    DateTime? createdAt;
    dynamic unitWeight;
    dynamic caseWeight;
    DateTime? updatedAt;
    dynamic productCode;
    String? caseSize;
    String? caseCost;
    String? unitCost;
    String? retailPrice;
    int? salePerInvoice;
    dynamic transactionUnit;
    int? weightItem;
    int? wicEligible;
    int? ingredient;
    int? ebtEligible;
    int? activeItem;
    int? showInMenu;
    int? inventory;
    int? mustAskQty;
    int? showInKiosk;
    int? kitchenPrinter;
    dynamic packageUpc;
    String? packagePrice;
    dynamic item;
    dynamic rebateGroup;
    dynamic groupPlu;
    dynamic manufacturer;
    dynamic mixMatchGroup;
    dynamic detailType;
    String? onHandQty;
    dynamic packSize;
    dynamic dealName;
    dynamic loyaltyDescription;
    dynamic smartMenu;
    String? loyaltyAmount;
    String? loyaltyPoint;
    dynamic itemIngredient;
    dynamic photoTags;
    dynamic inventoryGroup;
    dynamic tagAlongItem;
    int? inSmartMenuShortcut;
    int? keepInventory;
    int? ingredientItem;
    int? onSpecial;
    String? specialPrice;
    dynamic startDate;
    dynamic endDate;
    int? sendToScale;
    dynamic hotKey;
    dynamic itemExpireIn;
    int? weightAtScale;
    String? category;
    dynamic onlineItem;
    String? caseAllowance;
    String? caseOtherCost;
    String? netCaseCost;
    String? unitAllowance;
    String? otherCost;
    String? netCost;
    String? netMargin;
    dynamic vendors;
    dynamic taxNumber;
    dynamic itemUpc;
    int? batchId;
    dynamic offlineId;
    dynamic terminalId;
    int? isPriceChanged;
    dynamic online;
    dynamic createForm;
    dynamic quickbookId;
    dynamic syncToken;
    dynamic deletedAt;
    dynamic productBoxId;
    dynamic expiryPeriodDate;
    dynamic parentIdProduct;
    bool? notForMixMatchGroup;
    bool? notForLoyalityPoint;
    dynamic woocommerceProductId;
    bool? woocommerceDisableSync;
    dynamic woocommerceMediaId;
    int? mergeItem;
    dynamic multiSku;
    int? notForTransfers;
    String? cookingTime;
    dynamic locationId;
    String? imageUrl;
    Pivot? pivot;
    List<dynamic>? productSkus;
    List<dynamic>? productLocations;
    List<Variation>? variations;
    List<dynamic>? productTaxRates;

    ModifierSet({
        this.id,
        this.name,
        this.businessId,
        this.type,
        this.unitId,
        this.subUnitIds,
        this.brandId,
        this.categoryId,
        this.subCategoryId,
        this.tax,
        this.taxType,
        this.enableStock,
        this.alertQuantity,
        this.sku,
        this.plu,
        this.barcodeType,
        this.expiryPeriod,
        this.expiryPeriodType,
        this.enableSrNo,
        this.weight,
        this.productCustomField1,
        this.productCustomField2,
        this.productCustomField3,
        this.productCustomField4,
        this.image,
        this.productDescription,
        this.createdBy,
        this.warrantyId,
        this.isInactive,
        this.repairModelId,
        this.notForSelling,
        this.createdAt,
        this.unitWeight,
        this.caseWeight,
        this.updatedAt,
        this.productCode,
        this.caseSize,
        this.caseCost,
        this.unitCost,
        this.retailPrice,
        this.salePerInvoice,
        this.transactionUnit,
        this.weightItem,
        this.wicEligible,
        this.ingredient,
        this.ebtEligible,
        this.activeItem,
        this.showInMenu,
        this.inventory,
        this.mustAskQty,
        this.showInKiosk,
        this.kitchenPrinter,
        this.packageUpc,
        this.packagePrice,
        this.item,
        this.rebateGroup,
        this.groupPlu,
        this.manufacturer,
        this.mixMatchGroup,
        this.detailType,
        this.onHandQty,
        this.packSize,
        this.dealName,
        this.loyaltyDescription,
        this.smartMenu,
        this.loyaltyAmount,
        this.loyaltyPoint,
        this.itemIngredient,
        this.photoTags,
        this.inventoryGroup,
        this.tagAlongItem,
        this.inSmartMenuShortcut,
        this.keepInventory,
        this.ingredientItem,
        this.onSpecial,
        this.specialPrice,
        this.startDate,
        this.endDate,
        this.sendToScale,
        this.hotKey,
        this.itemExpireIn,
        this.weightAtScale,
        this.category,
        this.onlineItem,
        this.caseAllowance,
        this.caseOtherCost,
        this.netCaseCost,
        this.unitAllowance,
        this.otherCost,
        this.netCost,
        this.netMargin,
        this.vendors,
        this.taxNumber,
        this.itemUpc,
        this.batchId,
        this.offlineId,
        this.terminalId,
        this.isPriceChanged,
        this.online,
        this.createForm,
        this.quickbookId,
        this.syncToken,
        this.deletedAt,
        this.productBoxId,
        this.expiryPeriodDate,
        this.parentIdProduct,
        this.notForMixMatchGroup,
        this.notForLoyalityPoint,
        this.woocommerceProductId,
        this.woocommerceDisableSync,
        this.woocommerceMediaId,
        this.mergeItem,
        this.multiSku,
        this.notForTransfers,
        this.cookingTime,
        this.locationId,
        this.imageUrl,
        this.pivot,
        this.productSkus,
        this.productLocations,
        this.variations,
        this.productTaxRates,
    });

    factory ModifierSet.fromMap(Map<String, dynamic> json) => ModifierSet(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        businessId: json["business_id"],
        type: json["type"],
        unitId: json["unit_id"],
        subUnitIds: json["sub_unit_ids"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        tax: json["tax"],
        taxType: json["tax_type"],
        enableStock: json["enable_stock"],
        alertQuantity: json["alert_quantity"],
        sku: json["sku"],
        plu: json["plu"],
        barcodeType: json["barcode_type"],
        expiryPeriod: json["expiry_period"],
        expiryPeriodType: json["expiry_period_type"],
        enableSrNo: json["enable_sr_no"],
        weight: json["weight"],
        productCustomField1: json["product_custom_field1"],
        productCustomField2: json["product_custom_field2"],
        productCustomField3: json["product_custom_field3"],
        productCustomField4: json["product_custom_field4"],
        image: json["image"],
        productDescription: json["product_description"],
        createdBy: json["created_by"],
        warrantyId: json["warranty_id"],
        isInactive: json["is_inactive"],
        repairModelId: json["repair_model_id"],
        notForSelling: json["not_for_selling"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        unitWeight: json["unit_weight"],
        caseWeight: json["case_weight"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productCode: json["product_code"],
        caseSize: json["case_size"],
        caseCost: json["case_cost"],
        unitCost: json["unit_cost"],
        retailPrice: json["retail_price"],
        salePerInvoice: json["sale_per_invoice"],
        transactionUnit: json["transaction_unit"],
        weightItem: json["weight_item"],
        wicEligible: json["wic_eligible"],
        ingredient: json["ingredient"],
        ebtEligible: json["ebt_eligible"],
        activeItem: json["active_item"],
        showInMenu: json["show_in_menu"],
        inventory: json["inventory"],
        mustAskQty: json["must_ask_qty"],
        showInKiosk: json["show_in_kiosk"],
        kitchenPrinter: json["kitchen_printer"],
        packageUpc: json["package_upc"],
        packagePrice: json["package_price"],
        item: json["item"],
        rebateGroup: json["rebate_group"],
        groupPlu: json["group_plu"],
        manufacturer: json["manufacturer"],
        mixMatchGroup: json["mix_match_group"],
        detailType: json["detail_type"],
        onHandQty: json["on_hand_qty"],
        packSize: json["pack_size"],
        dealName: json["deal_name"],
        loyaltyDescription: json["loyalty_description"],
        smartMenu: json["smart_menu"],
        loyaltyAmount: json["loyalty_amount"],
        loyaltyPoint: json["loyalty_point"],
        itemIngredient: json["item_ingredient"],
        photoTags: json["photo_tags"],
        inventoryGroup: json["inventory_group"],
        tagAlongItem: json["tag_along_item"],
        inSmartMenuShortcut: json["in_smart_menu_shortcut"],
        keepInventory: json["keep_inventory"],
        ingredientItem: json["ingredient_item"],
        onSpecial: json["on_special"],
        specialPrice: json["special_price"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        sendToScale: json["send_to_scale"],
        hotKey: json["hot_key"],
        itemExpireIn: json["item_expire_in"],
        weightAtScale: json["weight_at_scale"],
        category: json["category"],
        onlineItem: json["online_item"],
        caseAllowance: json["case_allowance"],
        caseOtherCost: json["case_other_cost"],
        netCaseCost: json["net_case_cost"],
        unitAllowance: json["unit_allowance"],
        otherCost: json["other_cost"],
        netCost: json["net_cost"],
        netMargin: json["net_margin"],
        vendors: json["vendors"],
        taxNumber: json["tax_number"],
        itemUpc: json["item_upc"],
        batchId: json["batch_id"],
        offlineId: json["offline_id"],
        terminalId: json["terminal_id"],
        isPriceChanged: json["is_price_changed"],
        online: json["online"],
        createForm: json["create_form"],
        quickbookId: json["quickbook_id"],
        syncToken: json["sync_token"],
        deletedAt: json["deleted_at"],
        productBoxId: json["product_box_id"],
        expiryPeriodDate: json["expiry_period_date"],
        parentIdProduct: json["parent_id_product"],
        notForMixMatchGroup: json["not_for_mix_match_group"],
        notForLoyalityPoint: json["not_for_loyality_point"],
        woocommerceProductId: json["woocommerce_product_id"],
        woocommerceDisableSync: json["woocommerce_disable_sync"],
        woocommerceMediaId: json["woocommerce_media_id"],
        mergeItem: json["merge_item"],
        multiSku: json["multi_sku"],
        notForTransfers: json["not_for_transfers"],
        cookingTime: json["cooking_time"],
        locationId: json["location_id"],
        imageUrl: json["image_url"],
        pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
        productSkus: json["product_skus"] == null ? [] : List<dynamic>.from(json["product_skus"]!.map((x) => x)),
        productLocations: json["product_locations"] == null ? [] : List<dynamic>.from(json["product_locations"]!.map((x) => x)),
        variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromMap(x))),
        productTaxRates: json["product_tax_rates"] == null ? [] : List<dynamic>.from(json["product_tax_rates"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "type": type,
        "unit_id": unitId,
        "sub_unit_ids": subUnitIds,
        "brand_id": brandId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "tax": tax,
        "tax_type": taxType,
        "enable_stock": enableStock,
        "alert_quantity": alertQuantity,
        "sku": sku,
        "plu": plu,
        "barcode_type": barcodeType,
        "expiry_period": expiryPeriod,
        "expiry_period_type": expiryPeriodType,
        "enable_sr_no": enableSrNo,
        "weight": weight,
        "product_custom_field1": productCustomField1,
        "product_custom_field2": productCustomField2,
        "product_custom_field3": productCustomField3,
        "product_custom_field4": productCustomField4,
        "image": image,
        "product_description": productDescription,
        "created_by": createdBy,
        "warranty_id": warrantyId,
        "is_inactive": isInactive,
        "repair_model_id": repairModelId,
        "not_for_selling": notForSelling,
        "created_at": createdAt?.toIso8601String(),
        "unit_weight": unitWeight,
        "case_weight": caseWeight,
        "updated_at": updatedAt?.toIso8601String(),
        "product_code": productCode,
        "case_size": caseSize,
        "case_cost": caseCost,
        "unit_cost": unitCost,
        "retail_price": retailPrice,
        "sale_per_invoice": salePerInvoice,
        "transaction_unit": transactionUnit,
        "weight_item": weightItem,
        "wic_eligible": wicEligible,
        "ingredient": ingredient,
        "ebt_eligible": ebtEligible,
        "active_item": activeItem,
        "show_in_menu": showInMenu,
        "inventory": inventory,
        "must_ask_qty": mustAskQty,
        "show_in_kiosk": showInKiosk,
        "kitchen_printer": kitchenPrinter,
        "package_upc": packageUpc,
        "package_price": packagePrice,
        "item": item,
        "rebate_group": rebateGroup,
        "group_plu": groupPlu,
        "manufacturer": manufacturer,
        "mix_match_group": mixMatchGroup,
        "detail_type": detailType,
        "on_hand_qty": onHandQty,
        "pack_size": packSize,
        "deal_name": dealName,
        "loyalty_description": loyaltyDescription,
        "smart_menu": smartMenu,
        "loyalty_amount": loyaltyAmount,
        "loyalty_point": loyaltyPoint,
        "item_ingredient": itemIngredient,
        "photo_tags": photoTags,
        "inventory_group": inventoryGroup,
        "tag_along_item": tagAlongItem,
        "in_smart_menu_shortcut": inSmartMenuShortcut,
        "keep_inventory": keepInventory,
        "ingredient_item": ingredientItem,
        "on_special": onSpecial,
        "special_price": specialPrice,
        "start_date": startDate,
        "end_date": endDate,
        "send_to_scale": sendToScale,
        "hot_key": hotKey,
        "item_expire_in": itemExpireIn,
        "weight_at_scale": weightAtScale,
        "category": category,
        "online_item": onlineItem,
        "case_allowance": caseAllowance,
        "case_other_cost": caseOtherCost,
        "net_case_cost": netCaseCost,
        "unit_allowance": unitAllowance,
        "other_cost": otherCost,
        "net_cost": netCost,
        "net_margin": netMargin,
        "vendors": vendors,
        "tax_number": taxNumber,
        "item_upc": itemUpc,
        "batch_id": batchId,
        "offline_id": offlineId,
        "terminal_id": terminalId,
        "is_price_changed": isPriceChanged,
        "online": online,
        "create_form": createForm,
        "quickbook_id": quickbookId,
        "sync_token": syncToken,
        "deleted_at": deletedAt,
        "product_box_id": productBoxId,
        "expiry_period_date": expiryPeriodDate,
        "parent_id_product": parentIdProduct,
        "not_for_mix_match_group": notForMixMatchGroup,
        "not_for_loyality_point": notForLoyalityPoint,
        "woocommerce_product_id": woocommerceProductId,
        "woocommerce_disable_sync": woocommerceDisableSync,
        "woocommerce_media_id": woocommerceMediaId,
        "merge_item": mergeItem,
        "multi_sku": multiSku,
        "not_for_transfers": notForTransfers,
        "cooking_time": cookingTime,
        "location_id": locationId,
        "image_url": imageUrl,
        "pivot": pivot?.toMap(),
        "product_skus": productSkus == null ? [] : List<dynamic>.from(productSkus!.map((x) => x)),
        "product_locations": productLocations == null ? [] : List<dynamic>.from(productLocations!.map((x) => x)),
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toMap())),
        "product_tax_rates": productTaxRates == null ? [] : List<dynamic>.from(productTaxRates!.map((x) => x)),
    };
}

class Pivot {
    int? categoryId;
    int? modifierSetId;

    Pivot({
        this.categoryId,
        this.modifierSetId,
    });

    factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        categoryId: json["category_id"],
        modifierSetId: json["modifier_set_id"],
    );

    Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "modifier_set_id": modifierSetId,
    };
}

class Variation {
    int? id;
    String? name;
    int? productId;
    String? subSku;
    int? productVariationId;
    dynamic variationValueId;
    String? defaultPurchasePrice;
    String? dppIncTax;
    String? profitPercent;
    String? defaultSellPrice;
    String? sellPriceIncTax;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic comboVariations;
    dynamic woocommerceVariationId;
    dynamic offlineId;

    Variation({
        this.id,
        this.name,
        this.productId,
        this.subSku,
        this.productVariationId,
        this.variationValueId,
        this.defaultPurchasePrice,
        this.dppIncTax,
        this.profitPercent,
        this.defaultSellPrice,
        this.sellPriceIncTax,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.comboVariations,
        this.woocommerceVariationId,
        this.offlineId,
    });

    factory Variation.fromMap(Map<String, dynamic> json) => Variation(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        subSku: json["sub_sku"],
        productVariationId: json["product_variation_id"],
        variationValueId: json["variation_value_id"],
        defaultPurchasePrice: json["default_purchase_price"],
        dppIncTax: json["dpp_inc_tax"],
        profitPercent: json["profit_percent"],
        defaultSellPrice: json["default_sell_price"],
        sellPriceIncTax: json["sell_price_inc_tax"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        comboVariations: json["combo_variations"],
        woocommerceVariationId: json["woocommerce_variation_id"],
        offlineId: json["offline_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "sub_sku": subSku,
        "product_variation_id": productVariationId,
        "variation_value_id": variationValueId,
        "default_purchase_price": defaultPurchasePrice,
        "dpp_inc_tax": dppIncTax,
        "profit_percent": profitPercent,
        "default_sell_price": defaultSellPrice,
        "sell_price_inc_tax": sellPriceIncTax,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "combo_variations": comboVariations,
        "woocommerce_variation_id": woocommerceVariationId,
        "offline_id": offlineId,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

