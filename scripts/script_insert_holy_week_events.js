const { v4: uuidv4 } = require('uuid');
const admin = require('firebase-admin');

const serviceAccount = require('/home/rafa/cosas/TFG/director_app_tfg/scripts/director-2024-redencion-firebase-adminsdk-i9dcs-21f4869b99.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://director-2024-redencion.firebaseio.com/'
});

const db = admin.firestore();

const eventos = [
  {
    id: uuidv4(),
    location: "Puente Romano de Cordoba",
    type: "Salida Procesional",
    date: new Date("2024-06-07T12:00:00"),
    duration: 120,
    moreInformation: "Concert by the Symphony Orchestra",
    holyWeekName: "Lunes Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/DomingoResurreccion.jpeg?alt=media&token=d376f999-e5fe-41cd-b02d-46c3dffe0462"
  }
];

const eventosCollectionRef = db.collection('semanaSanta');

eventos.forEach(evento => {
  eventosCollectionRef.doc(evento.id).set(evento)
    .then(() => {
      console.log(' Evento insertado con ID:', evento.id);
    })
    .catch((error) => {
      console.error('Error al insertar evento:', error);
    });
});
