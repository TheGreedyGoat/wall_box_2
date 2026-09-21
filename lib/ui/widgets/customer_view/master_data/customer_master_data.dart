import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_address_fields.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_company_fields.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_contact_fields.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_id_field.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_personals_field.dart';

/// Root widget to display and edit all Data of a customer
class CustomerMasterData extends ConsumerStatefulWidget {
  /// Root widget to display and edit all Data of a customer
  const CustomerMasterData({super.key});

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
                    CustomerIDField(),
                    CustomerCompanyFields(),
                    CustomerPersonalsFields(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 20.0,
                  children: [
                    CustomerAddressFields(),
                    CustomerContactFields(),
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
