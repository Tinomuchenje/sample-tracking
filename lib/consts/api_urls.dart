// const baseUrl = 'https://sample-tracking-backend.herokuapp.com/v1/';
const baseUrl = 'http://10.0.2.2:8080/api/';
final headers = {
  'accept': 'application/json',
  'content-type': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTYzNTQzMzU4N30.md-0uDdYc4NzrsafH5vKFDH60z7YZeXtpq4WuOnyHLkjmntd7NsP5LJ7H3yRuTwBzBXCq4aWMMGpgRF0FEYAlQ'
};

//Authentication
const loginUrl = baseUrl + 'authenticate';

// Patient
const patientsUrl = baseUrl + 'patients';

// Sample
const sampleUrl = baseUrl + 'samples';

// Shipment
const shipmentUrl = baseUrl + 'shipments';

// Clients
const clientUrl = baseUrl + 'clients';

//Account

const accountUrl = baseUrl + 'account';
