import 'package:flutter_test/flutter_test.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/customer.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';

void main() {
  final validAddress = Address(
    id: 'address-1',
    street: 'Main Street',
    number: '12',
    postcode: '10115',
    city: 'Berlin',
  );
  final validPhone = Phone(nationalCode: '+49', number: '301234567');
  final validEmail = Email(
    local: 'person',
    subdomain: 'example',
    topLevelDomain: 'com',
  );
  final validContact = ContactData(
    id: 'contact-1',
    phone: validPhone,
    email: validEmail,
  );

  group('Address', () {
    test('accepts a complete address', () {
      expect(validAddress.validate(), isEmpty);
    });

    test('reports every required field that is missing', () {
      expect(
        Address(id: 'address-1').validate(),
        [
          DataError.noStreet,
          DataError.noHouseNumber,
          DataError.noPostcode,
          DataError.noCity,
        ],
      );
    });
  });

  group('Email', () {
    test('parses and validates a complete email address', () {
      final email = Email.tryParse('person@example.com');

      expect(email, isNotNull);
      expect(email!.local, 'person');
      expect(email.subdomain, 'example');
      expect(email.topLevelDomain, 'com');
      expect(email.validate(), isEmpty);
      expect(email.toString(), 'person@example.com');
    });

    test('rejects malformed email input', () {
      expect(Email.tryParse('not-an-email'), isNull);
      expect(
        Email(
          local: '1person',
          subdomain: 'example',
          topLevelDomain: 'com',
        ).validate(),
        [DataError.invalidEmailLocal],
      );
    });
  });

  group('Phone', () {
    test('parses a national code and number', () {
      final phone = Phone.tryParse('+49 30 1234567');

      expect(phone, isNotNull);
      expect(phone!.nationalCode, '+49');
      expect(phone.number, '30 1234567');
      expect(phone.validate(), isEmpty);
    });

    test('rejects input without a separated number', () {
      expect(Phone.tryParse('+49'), isNull);
      expect(
        Phone(nationalCode: '+49', number: 'abc').validate(),
        [DataError.invalidPhoneNumber],
      );
    });
  });

  group('ContactData', () {
    test('accepts a phone contact with optional email', () {
      expect(validContact.validate(), isEmpty);
    });

    test('requires at least one phone number', () {
      expect(
        ContactData(id: 'contact-1', email: validEmail).validate(),
        [DataError.noPhoneOrMobile],
      );
    });

    test('includes nested validation errors', () {
      expect(
        ContactData(id: 'contact-1', phone: Phone()).validate(),
        [DataError.noNationalCode, DataError.noPhoneNumber],
      );
    });
  });

  group('CompanyData', () {
    test('accepts complete company data', () {
      expect(
        CompanyData(
          id: 'company-1',
          companyName: 'Example GmbH',
          address: validAddress,
          contact: validContact,
        ).validate(),
        isEmpty,
      );
    });

    test('reports missing company data and nested errors', () {
      expect(
        CompanyData(id: 'company-1').validate(),
        [DataError.noCompanyName, DataError.noAddress, DataError.noContact],
      );
    });
  });

  group('PersonalData', () {
    test('accepts complete personal data', () {
      expect(
        PersonalData(
          id: 'person-1',
          prename: 'Ada',
          surname: 'Lovelace',
          contact: validContact,
          address: validAddress,
        ).validate(),
        isEmpty,
      );
    });

    test('reports all missing required fields', () {
      expect(
        PersonalData(id: 'person-1').validate(),
        [
          DataError.noPrename,
          DataError.noSurname,
          DataError.noAddress,
          DataError.noContact,
        ],
      );
    });
  });

  group('Customer', () {
    test('accepts either company or personal data', () {
      expect(
        Customer(
          id: 'customer-1',
          company: CompanyData(
            id: 'company-1',
            companyName: 'Example GmbH',
            address: validAddress,
            contact: validContact,
          ),
        ).validate(),
        isEmpty,
      );
    });

    test('requires company or personal data', () {
      expect(
        Customer(id: 'customer-1').validate(),
        [DataError.noCompanyOrPersonal],
      );
    });

    test('propagates nested customer validation errors', () {
      expect(
        Customer(
          id: 'customer-1',
          personal: PersonalData(id: 'person-1'),
        ).validate(),
        [
          DataError.noPrename,
          DataError.noSurname,
          DataError.noAddress,
          DataError.noContact,
        ],
      );
    });
  });
}
