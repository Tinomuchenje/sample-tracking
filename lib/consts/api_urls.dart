const baseUrl = 'http://196.27.127.58:4080/api/';
const headers = {
  'accept': 'application/json',
  'content-type': 'application/json'
};

// class Token {
//   Future<Map<String, String>> buildHeaders() async {
//     String t = await AppInformationDao().getToken();

//     final headers = {
//       'accept': 'application/json',
//       'content-type': 'application/json',
//       'Authorization': "Token " + t
//     };
//     return headers;
//   }
// }

//Authentication
const loginUrl = baseUrl + 'authenticate';
const getAccountUrl = baseUrl + 'account';
const registerAccountUrl = baseUrl + 'admin/users';

// Patient
const patientsUrl = baseUrl + 'patients/';

// Sample
const sampleUrl = baseUrl + 'samples/';

// Shipment
const shipmentUrl = baseUrl + 'shipments/';

// Clients
const getAllClientsUrl = baseUrl + 'clients';

// Districts
const getAllDistrictsUrl = baseUrl + 'districts';

// Provinces
const getAllProvincesUrl = baseUrl + 'districts';
