import 'dart:typed_data';

class Company {
  final int id;
  final String companyName;
  final String companyIndustry;
  final String? companySize;
  final String? companyLocation;
  final String companyEmail;
  final String? companyPhone;
  final String? companyWebsite;
  final Uint8List? companyLogo; // Change to Uint8List to store binary data
  final String? companyDescription;
  final String tradeRegisterNumber;
  final String taxIdentificationNumber;
  final String createdAt;

  Company({
    required this.id,
    required this.companyName,
    required this.companyIndustry,
    this.companySize,
    this.companyLocation,
    required this.companyEmail,
    this.companyPhone,
    this.companyWebsite,
    this.companyLogo,
    this.companyDescription,
    required this.tradeRegisterNumber,
    required this.taxIdentificationNumber,
    required this.createdAt,
  });

  // Convert a Company object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_name': companyName,
      'company_industry': companyIndustry,
      'company_size': companySize,
      'company_location': companyLocation,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_website': companyWebsite,
      'company_logo': companyLogo,
      'company_description': companyDescription,
      'trade_register_number': tradeRegisterNumber,
      'tax_identification_number': taxIdentificationNumber,
      'created_at': createdAt,
    };
  }

  // Convert a Map object into a Company object
  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      companyName: map['company_name'],
      companyIndustry: map['company_industry'],
      companySize: map['company_size'],
      companyLocation: map['company_location'],
      companyEmail: map['company_email'],
      companyPhone: map['company_phone'],
      companyWebsite: map['company_website'],
      companyLogo: map['company_logo'],
      companyDescription: map['company_description'],
      tradeRegisterNumber: map['trade_register_number'],
      taxIdentificationNumber: map['tax_identification_number'],
      createdAt: map['created_at'],
    );
  }
}
