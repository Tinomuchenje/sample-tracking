const baseUrl = 'http://196.27.127.58:4080/api/';
final headers = {
  'accept': 'application/json',
  'content-type': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTYzNjkyMzE4NH0.s4MqeCCovubFdjcck4Rw1CIBqI3YpKqngilqgyOxhqaNWJSzMC-B84H9zdGC9STKB84vI02cEzNKYmit0EUGQw'
};

//Authentication
const loginUrl = baseUrl + 'authenticate';
const getAccountUrl = baseUrl + 'account';

// Patient
const patientsUrl = baseUrl + 'patients';

// Sample
const sampleUrl = baseUrl + 'samples';

// Shipment
const shipmentUrl = baseUrl + 'shipments';
