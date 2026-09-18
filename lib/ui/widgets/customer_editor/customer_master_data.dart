import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_address.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_company.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_contact.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_id.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_personals.dart';

/// Root widget to display and edit all Data of a customer
class CustomerMasterData extends ConsumerStatefulWidget {
  ///the original state wich is being edited if not null
  final CustomerDataPackage? original;

  /// Root widget to display and edit all Data of a customer
  ///
  /// [original] : the original state wich is being edited if not null
  const CustomerMasterData({this.original, super.key});

  @override
  ConsumerState<CustomerMasterData> createState() => _CustomerMasterDataState();
}

class _CustomerMasterDataState extends ConsumerState<CustomerMasterData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 1000,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 32.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20.0,
                  children: [
                    CustomerID(
                      editable: (widget.original?.id ?? '').isEmpty,
                    ),
                    CustomerCompany(),
                    CustomerPersonals(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 20.0,
                  children: [
                    CustomerAddress(),
                    CustomerContact(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
