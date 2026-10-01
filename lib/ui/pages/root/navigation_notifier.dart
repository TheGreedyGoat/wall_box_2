import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_bills.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_customer_details.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_transaction_overview.dart';
import 'package:wall_box_2/ui/pages/root/navigation_item.dart';

final List<NavigationItem> pageMainDestinations = [
  NavigationItem(
    icon: Icon(Icons.person),
    destination: PageCustomerDetails(),
    title: 'Kunden-Details',
  ),
  NavigationItem(
    icon: Icon(Icons.power),
    destination: PageTransactionOverview(),
    title: 'Transaktionen',
  ),
  NavigationItem(
    icon: Icon(Icons.euro),
    destination: PageBills(),
    title: 'Rechnungen',
  ),
];

class NavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  setState(int value) => state = value % pageMainDestinations.length;
}

final navigationProvider = NotifierProvider(() => NavigationNotifier());
