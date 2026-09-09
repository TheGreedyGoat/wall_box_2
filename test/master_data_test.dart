import 'package:flutter_test/flutter_test.dart';
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
      expect(validAddress.validate(), isNull);
    });

    test('reports every required field that is missing', () {
      expect(
        Address(id: 'address-1').validate(),
        'Streetname not set\nhouse number not set\nPostcode not set\ncity not set',
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
      expect(email.validate(), isNull);
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
        'email has to start with a letter',
      );
    });
  });

  group('Phone', () {
    test('parses a national code and number', () {
      final phone = Phone.tryParse('+49 30 1234567');

      expect(phone, isNotNull);
      expect(phone!.nationalCode, '+49');
      expect(phone.number, '30 1234567');
      expect(phone.validate(), isNull);
    });

    test('rejects input without a separated number', () {
      expect(Phone.tryParse('+49'), isNull);
      expect(
        Phone(nationalCode: '+49', number: 'abc').validate(),
        'number contains not only numbers',
      );
    });
  });

  group('ContactData', () {
    test('accepts a phone contact with optional email', () {
      expect(validContact.validate(), isNull);
    });

    test('requires at least one phone number', () {
      expect(
        ContactData(id: 'contact-1', email: validEmail).validate(),
        'Neither phone nor mobile set',
      );
    });

    test('includes nested validation errors', () {
      expect(
        ContactData(id: 'contact-1', phone: Phone()).validate(),
        'National Code missing\nNumber is missing',
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
        isNull,
      );
    });

    test('reports missing company data and nested errors', () {
      expect(
        CompanyData(id: 'company-1').validate(),
        'no company name provided\nadress missing\ncontact missing',
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
        isNull,
      );
    });

    test('reports all missing required fields', () {
      expect(
        PersonalData(id: 'person-1').validate(),
        'prename missing\nsurname missing\ncontact missing\naddress missing',
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
        isNull,
      );
    });

    test('requires company or personal data', () {
      expect(
        Customer(id: 'customer-1').validate(),
        'Neither company nor personal data set',
      );
    });

    test('propagates nested customer validation errors', () {
      expect(
        Customer(
          id: 'customer-1',
          personal: PersonalData(id: 'person-1'),
        ).validate(),
        'prename missing\nsurname missing\ncontact missing\naddress missing',
      );
    });
  });
}
