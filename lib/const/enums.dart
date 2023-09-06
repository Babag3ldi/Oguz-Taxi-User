enum ShopType { gold, silver, bronze, simple }

enum Internet { econom, standart }

enum ApiStatus { nothing, loading, error, errorDio, success, dogry, noInternet }

enum BadgeType { publications, sergi, shops, products, videos, announcements, biznes }

enum Banks { halk, rysgal, senagat, vneshka }

enum InfoType { about, contact, policy, ads, qa }

enum InputType { string, int, double, select, bool, multiSelect, nestedSelect, multinestedSelect }

enum StoreGornush { sergi, store }

enum CategoryType { bildirish, store, sergi }

enum ProductType { store, sergi, bildirish }

enum AdType { web, mall, mallProduct, excebition, excebitionProduct, adAccount, biznes }

enum FiltrType { category, shop, brand, filtr, none }

String badgeName(BadgeType type) {
  switch (type) {
    case BadgeType.publications:
      return "publications";
    case BadgeType.sergi:
      return "exhibition_stores";

    case BadgeType.shops:
      return "mall_stores";

    case BadgeType.products:
      return "mall_products";

    case BadgeType.videos:
      return "videos";

    case BadgeType.announcements:
      return "announcements";

    case BadgeType.biznes:
      return "business_accounts";
  }
}

AdType adType(int s) {
  switch (s) {
    case 0:
      return AdType.web;
    case 1:
      return AdType.mall;
    case 2:
      return AdType.mallProduct;
    case 3:
      return AdType.excebition;
    case 4:
      return AdType.excebitionProduct;
    case 5:
      return AdType.adAccount;
    case 6:
      return AdType.biznes;
    default:
      return AdType.web;
  }
}

enum LocationType {
  sergi,
  bildirish,
  bazar,
  dukan,
  habarlar,
  biznes,
}

InputType toInputType(int inx) {
  switch (inx) {
    case 0:
      return InputType.string;
    case 1:
      return InputType.int;
    case 2:
      return InputType.double;
    case 3:
      return InputType.bool;
    case 4:
      return InputType.select;
    case 5:
      return InputType.multiSelect;
    case 6:
      return InputType.nestedSelect;
    case 7:
      return InputType.multinestedSelect;
  }
  return InputType.string;
}
