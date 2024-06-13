const { v4: uuidv4 } = require('uuid');
const admin = require('firebase-admin');

const serviceAccount = require('/home/rafa/cosas/TFG/director-2024-redencion-firebase-adminsdk-i9dcs-21f4869b99.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://director-2024-redencion.firebaseio.com/'
});

const db = admin.firestore();

const eventos = [
  {
    id: uuidv4(),
    location: "Puente Romano de Cordoba",
    type: "Concert",
    date: new Date("2024-06-07T12:00:00"),
    repertoire: [],
    duration: 120,
    attendance: [],
    moreInformation: "Concert by the Symphony Orchestra"
  }
];

const eventosCollectionRef = db.collection('eventos');

eventos.forEach(evento => {
  eventosCollectionRef.doc(evento.id).set(evento)
    .then(() => {
      console.log(' Evento insertado con ID:', evento.id);
    })
    .catch((error) => {
      console.error('Error al insertar evento:', error);
    });
});
