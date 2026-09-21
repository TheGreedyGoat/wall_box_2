// ignore_for_file: public_member_api_docs

/// lists all possible kinds of errors that can occur within any masterdata
enum DataError {
  noID,
  idTaken,
  // customer
  noCompanyOrPersonal,
  // company, personal
  noCompanyName,
  noPrename,
  noSurname,
  //address
  noAddress,
  noStreet,
  noHouseNumber,
  noPostcode,
  noCity,
  noCountry,

  // contact
  noContact,
  noPhoneOrMobile,
  noNationalCode,

  //phone
  noPhoneNumber,
  invalidPhoneNumber,

  //email
  noEmailLocal,
  noEmailSubdomain,
  noEmailTLD,
  invalidEmailLocal,
}
