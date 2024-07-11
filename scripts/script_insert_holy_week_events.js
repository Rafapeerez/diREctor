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
    location: "Parroquia de Nuestra Señora del Carmen Puerta Nueva",
    type: "Salida Procesional",
    date: new Date("2025-04-10T19:40:00"),
    duration: 120,
    moreInformation: "",
    holyWeekName: "Jueves de Pasión",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/JuevesPasion.jpg?alt=media&token=71b6f341-f984-4f98-87d0-aba70e3ff26e"
  },
  {
    id: uuidv4(),
    location: "",
    type: "Salida Procesional",
    date: new Date("2025-04-11T00:00:00"),
    duration: 0,
    moreInformation: "",
    holyWeekName: "Viernes de Dolores",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/Descanso.png?alt=media&token=2fbb86b3-b765-4c31-b938-b2c45025cc7a"
  },
  {
    id: uuidv4(),
    location: "Parroquia San Vicente Ferrer Cordoba",
    type: "Salida Procesional",
    date: new Date("2025-04-12T19:40:00"),
    duration: 8,
    moreInformation: "",
    holyWeekName: "Sábado de Pasión",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/SabadoPasion.jpg?alt=media&token=2a7a57d5-077e-47dd-9eca-526360bb988b"
  },
  {
    id: uuidv4(),
    location: "Iglesia de San Francisco y San Eulogio",
    type: "Salida Procesional",
    date: new Date("2025-04-13T19:40:00"),
    duration: 120,
    moreInformation: "",
    holyWeekName: "Domingo de Ramos",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/DomingoRamos.jpg?alt=media&token=ea808e7d-b2e7-44fc-9f3b-7f4039e363f1"
  },
  {
    id: uuidv4(),
    location: "Parroquia de San Fernando Córdoba",
    type: "Salida Procesional",
    date: new Date("2025-04-14T15:15:00"),
    duration: 10,
    moreInformation: "",
    holyWeekName: "Lunes Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/LunesSanto.jpeg?alt=media&token=bd216e7c-6f9d-4801-b8d5-f3443b0fbc94"
  },
  {
    id: uuidv4(),
    location: "",
    type: "Salida Procesional",
    date: new Date("2025-04-15T00:00:00"),
    duration: 0,
    moreInformation: "",
    holyWeekName: "Martes Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/Descanso.png?alt=media&token=2fbb86b3-b765-4c31-b938-b2c45025cc7a"
  },
  {
    id: uuidv4(),
    location: "Parroquia Nuestra Señora de las Nieves, La Rinconada",
    type: "Salida Procesional",
    date: new Date("2025-04-16T20:00:00"),
    duration: 4,
    moreInformation: "Hay que estar a las 18 de la tarde en el local de ensayo.",
    holyWeekName: "Miércoles Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/MiercolesSanto.jpg?alt=media&token=a31c13a3-0188-47c4-bfdf-c10d0df757f9"
  },
  {
    id: uuidv4(),
    location: "Hermandad de la Sagrada Cena, Málaga",
    type: "Salida Procesional",
    date: new Date("2025-04-17T17:15:00"),
    duration: 6,
    moreInformation: "Hay que estar a las 14 de la tarde en el local de ensayo.",
    holyWeekName: "Jueves Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/JuevesSanto.jpg?alt=media&token=e08fabbe-25a6-4170-babd-4e69207afb4f"
  },
  {
    id: uuidv4(),
    location: "Parroquia Nuestra Señora del Rosario y Santa Beatriz De Silva",
    type: "Salida Procesional",
    date: new Date("2025-04-18T16:20:00"),
    duration: 10,
    moreInformation: "",
    holyWeekName: "Viernes Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/ViernesSanto.jpg?alt=media&token=a6075ec1-c780-4f54-a4ac-078a57a29691"
  },
  {
    id: uuidv4(),
    location: "",
    type: "Salida Procesional",
    date: new Date("2025-04-19T00:00:00"),
    duration: 0,
    moreInformation: "",
    holyWeekName: "Sábado Santo",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/Descanso.png?alt=media&token=2fbb86b3-b765-4c31-b938-b2c45025cc7a"
  },
  {
    id: uuidv4(),
    location: "Ermita de la Virgen de Gracia, Montoro",
    type: "Salida Procesional",
    date: new Date("2025-04-20T10:30:00"),
    duration: 120,
    moreInformation: "Hay que estar a las 8 de la mañana en el local de ensayo.",
    holyWeekName: "Domigo de Resurrección",
    imageURL: "https://firebasestorage.googleapis.com/v0/b/director-2024-redencion.appspot.com/o/DomingoResurreccion.jpeg?alt=media&token=d376f999-e5fe-41cd-b02d-46c3dffe0462"
  },
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
