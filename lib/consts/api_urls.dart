const baseUrl = 'https://sample-tracking-backend.herokuapp.com/v1/';
final headers = {
  'accept': 'application/json',
  'content-type': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTYzNjkyMzE4NH0.s4MqeCCovubFdjcck4Rw1CIBqI3YpKqngilqgyOxhqaNWJSzMC-B84H9zdGC9STKB84vI02cEzNKYmit0EUGQw'
};

//Authentication
const loginUrl = baseUrl + 'authenticate';

// Patient
const patientsUrl = baseUrl + 'patient';

// Sample
const sampleUrl = baseUrl + 'sample';

// Shipment
const shipmentUrl = baseUrl + 'shipment';
