import 'package:wall_box_2/logic/helpers/enums/data_error.dart';

const german = Language(
  customerID: 'Kundenkennung',
  generate: 'generieren',
  mrs: 'Frau',
  mr: 'Herr',
  company: 'Firma',
  companyAddition: 'Firmenzusatz',
  salutation: 'Anrede',
  title: 'Titel',
  prename: 'Vorname',
  surname: 'Nachname',
  street: 'Straße',
  houseNumber: 'Haus-Nr',
  addressAddition: 'Addresszusatz',
  postcode: 'PLZ',
  city: 'Ort',
  state: 'Bundesland',
  country: 'Land',
  email: 'E-Mail',
  phone: 'Telefon',
  mobile: 'Mobil',
  fax: 'Fax',
  website: 'Webseite',
  dataErrorMessages: {
    // customer
    DataError.noCompanyOrPersonal: 'Firmen- oder Nachname benötigt',
  },
  save: 'Speichern',
  discard: 'Verwerfen',
  isRequired: 'benötigt',
  edit: 'Bearbeiten',
  delete: 'Löschen',
  saveSuccessful: 'Speichern erfolgreich',
  errorOccured: 'Etwas ist schiefgelaufen',
  assignedTags: 'Zugewiesene Tags:',
  cancel: 'abbrechen',
  confirm: 'fortfahren',
);

var currentLanguage = german;

class Language {
  const Language({
    required this.mr,
    required this.mrs,
    required this.customerID,
    required this.generate,
    required this.company,
    required this.companyAddition,
    required this.salutation,
    required this.title,
    required this.prename,
    required this.surname,
    required this.street,
    required this.houseNumber,
    required this.addressAddition,
    required this.postcode,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.fax,
    required this.website,
    required this.dataErrorMessages,
    required this.save,
    required this.discard,
    required this.isRequired,
    required this.edit,
    required this.delete,
    required this.saveSuccessful,
    required this.errorOccured,
    required this.assignedTags,
    required this.cancel,
    required this.confirm,
  });

  final String assignedTags;
  final String cancel, confirm;
  final String company;
  final String companyAddition;
  final String customerID;
  final String edit;
  final String delete;
  final String discard;
  final String generate;

  final String mrs;
  final String mr;
  final String prename, surname;

  final String salutation;
  final String street,
      houseNumber,
      addressAddition,
      postcode,
      city,
      state,
      country;

  final String email, phone, mobile, fax, website;
  final String title;

  final String save;
  final String saveSuccessful;
  final String errorOccured;

  final Map<DataError, String> dataErrorMessages;
  final String isRequired;

  String getDataErrorMsg(DataError error) =>
      dataErrorMessages[error] ?? isRequired;
}
