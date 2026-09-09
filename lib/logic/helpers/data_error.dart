enum DataError {
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
