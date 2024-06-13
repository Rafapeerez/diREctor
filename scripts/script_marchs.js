const { v4: uuidv4 } = require('uuid');
const admin = require('firebase-admin');

const serviceAccount = require('/home/rafa/cosas/TFG/director-2024-redencion-firebase-adminsdk-i9dcs-21f4869b99.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://director-2024-redencion.firebaseio.com/'
});

const db = admin.firestore();

// Array de objetos JSON que representan las marchas que deseas insertar
const marchas = [
  {
    id: uuidv4(),
    name: "Perdona a tu pueblo",
    author: "Bernardo Velado Graña y Antonio Alcalde",
    number: 1,
    link: "https://www.youtube.com/watch?v=YiA5tlCS7BE",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Himno Nacional",
    author: "Manuel Espinosa de los Monteros",
    number: 2,
    link: "https://www.youtube.com/watch?v=4BF20CiOHpg",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "El Pan de vida",
    author: "Juan Manuel Carmona",
    number: 3,
    link: "https://www.youtube.com/watch?v=FOEQgtXT_YE",
    moreInformation: "También tiene los números 7, 16 y 27"
  },
  {
    id: uuidv4(),
    name: "Nazareno de la trinidad",
    author: "José M. Mena Hervás",
    number: 4,
    link: "https://www.youtube.com/watch?v=opFqw8T0Isk",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "El Santísimo Sacramento",
    author: "Francisco David Álvarez Barroso",
    number: 5,
    link: "https://www.youtube.com/watch?v=vZqybSd4kcM",
    moreInformation: "También tiene el número 9"
  },
  {
    id: uuidv4(),
    name: "El Sacramento de Nuestra Fe",
    author: "Felipe Cañizares Navarro",
    number: 6,
    link: "https://www.youtube.com/watch?v=0OSm_0D_GlI",
    moreInformation: "También tiene el número 28"
  },
  {
    id: uuidv4(),
    name: "Rocío del Cielo",
    author: "Antonio Muñoz y Emilio Muñoz",
    number: 8,
    link: "https://www.youtube.com/watch?v=XYv2BGw8ImA",
    moreInformation: "También tiene el número 26"
  },
  {
    id: uuidv4(),
    name: "Reina de Reyes",
    author: "Alejandro Blasco",
    number: 10,
    link: "https://www.youtube.com/watch?v=--ii6SVhXvM",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Eternamente Contigo",
    author: "Juan Manuel Carmona Suarez",
    number: 11,
    link: "https://www.youtube.com/watch?v=wdn6di30BiQ",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "En la cena del Señor",
    author: "José Manuel Mena Hervás",
    number: 12,
    link: "https://www.youtube.com/watch?v=R-JyJ5_HEWI",
    moreInformation: "También tiene los números 22 y 33"
  },
  {
    id: uuidv4(),
    name: "Oración",
    author: "José Manuel Mena Hervás",
    number: 13,
    link: "https://www.youtube.com/watch?v=tPSeWHYZ2No",
    moreInformation: "También tiene el número 34"
  },
  {
    id: uuidv4(),
    name: "Redención, Pasión y Amargura",
    author: "José Manuel Mena Hervás",
    number: 14,
    link: "https://www.youtube.com/watch?v=oD4qmWVKTw8",
    moreInformation: "También tiene el número 41"
  },
  {
    id: uuidv4(),
    name: "La Salve",
    author: "Juan José Martín",
    number: 15,
    link: "https://www.youtube.com/watch?v=hHKtPNITiHM",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "¡OH, PECADOR!",
    author: "Manuel Herrera Raya",
    number: 17,
    link: "https://www.youtube.com/watch?v=rPKtSxspmhk",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Esperanza de María",
    author: "Alejandro Blanco",
    number: 18,
    link: "https://www.youtube.com/watch?v=9zjR9Bo5TxQ&t=87s",
    moreInformation: "También tiene el número 24"
  },
  {
    id: uuidv4(),
    name: "Estrella, Reina del Cielo",
    author: "José Manuel Mena Hervás",
    number: 19,
    link: "https://www.youtube.com/watch?v=zFulWpBjYNI",
    moreInformation: "También tiene el número 43"
  },
  {
    id: uuidv4(),
    name: "Virgen de las Angustias",
    author: "Abel Moreno",
    number: 20,
    link: "https://www.youtube.com/watch?v=gRpGcqTFhfM",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "El Camino, la Verdad y la Vida",
    author: "Francisco José Ortiz Morón",
    number: 21,
    link: "https://www.youtube.com/watch?v=FqPOZA7Q7h8",
    moreInformation: "También tiene el número 29"
  },
  {
    id: uuidv4(),
    name: "Orando al Padre",
    author: "José Manuel Mena Hervás",
    number: 23,
    link: "https://www.youtube.com/watch?v=3k20KJLWPzM&t=6s",
    moreInformation: "También tiene el número 38"
  },
  {
    id: uuidv4(),
    name: "Nuestro Padre Jesús de la Victoria",
    author: "José Manuel Mena Hervás",
    number: 25,
    link: "https://www.youtube.com/watch?v=n8P5HA5CsXU",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Oración en el Huerto",
    author: "Agripino Lozano Perea",
    number: 30,
    link: "https://www.youtube.com/watch?v=9s7XK0unUEs",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Señor de la Salud",
    author: "Norberto Tapia",
    number: 31,
    link: "https://www.youtube.com/watch?v=4pAJHgRoNB4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Y al Tercer Día",
    author: "Alejandro Blanco Hernández",
    number: 32,
    link: "https://www.youtube.com/watch?v=ff0qIT48GV0",
    moreInformation: "También tiene el número 40"
  },
  {
    id: uuidv4(),
    name: "Entregado a su pueblo",
    author: "José Manuel Mena Hervás",
    number: 35,
    link: "https://www.youtube.com/watch?v=5OGCwVTNqdM",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Resucitó",
    author: "Frabcisco José Gómez Argüello",
    number: 36,
    link: "https://www.youtube.com/watch?v=nJeqh5-tyLI",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Sagrada Cena",
    author: "José Manuel Mena Hervás",
    number: 37,
    link: "https://www.youtube.com/watch?v=R7MRQozLmdo",
    moreInformation: "También tiene el número 54"
  },
  {
    id: uuidv4(),
    name: "A los Pies de Sor Angela",
    author: "Francisco David Álvarez Barroso",
    number: 39,
    link: "https://www.youtube.com/watch?v=Fvp19d7MNGE",
    moreInformation: "También tiene el número 42"
  },
  {
    id: uuidv4(),
    name: "Jesús de la Redención",
    author: "-",
    number: 44,
    link: "https://www.youtube.com/watch?v=jGtc_31z4F4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cirineo Para Tí, Señor",
    author: "José Manuel Mena Hervás",
    number: 45,
    link: "https://www.youtube.com/watch?v=mMMr5pZm1uI",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Ante Pilatos",
    author: "Pedro Manuel Pacheco Palomo",
    number: 46,
    link: "https://www.youtube.com/watch?v=gA-bA8-qs74",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Clámide Púrpura",
    author: "Juan Luis Del Valle Pérez y Francisco José Carrasco",
    number: 47,
    link: "https://www.youtube.com/watch?v=PXE5kqIUTQ0",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cerca de Tí, Señor",
    author: "Miguel Ángel Font Morgado",
    number: 48,
    link: "https://www.youtube.com/watch?v=JJuoZMBrvME",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Nazareno Y Gitano",
    author: "Pascual González",
    number: 49,
    link: "https://www.youtube.com/watch?v=LYJnKeGLXTo",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Padre Nuestro",
    author: "Pascual González",
    number: 50,
    link: "https://www.youtube.com/watch?v=Brcmj5rm6QI",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "¡Oh, Bendita Estrella!",
    author: "José Manuel Mena Hervás",
    number: 51,
    link: "https://www.youtube.com/watch?v=nQ804Tq4O_w",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cuando te Miro",
    author: "Lucas López Segura",
    number: 52,
    link: "https://www.youtube.com/watch?v=1z6NIn0joZk",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "A tí, Jesús",
    author: "Juan José Puntas Fernández ",
    number: 53,
    link: "https://www.youtube.com/watch?v=h7LPizEU-x8&t=61s",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Sangre en tus Clavos",
    author: "Nicolás Miguel Barbero Rivas",
    number: 55,
    link: "https://www.youtube.com/watch?v=p21ou4W8LKs",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Presentado a Sevilla",
    author: "Antonio José López Escalante",
    number: 56,
    link: "https://www.youtube.com/watch?v=UDVLfuXkX8s",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Puente de San Bernardo",
    author: "Manuel Rodríguez Ruiz",
    number: 57,
    link: "https://www.youtube.com/watch?v=Krc9D0Xz7zY",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cinco LLagas",
    author: "https://www.youtube.com/watch?v=9JBzpvINsPM",
    number: 58,
    link: "Nicolás Turienzo",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cristo de San Julián",
    author: "https://www.youtube.com/watch?v=wAE6UdIZ85w",
    number: 59,
    link: "Manuel Rodriguez Ruiz",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Pasa la Virgen del Refugio",
    author: "Manuel Rodriguez Ruiz",
    number: 60,
    link: "https://www.youtube.com/watch?v=v3GYO_8KkvU",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Himno de San Antonio",
    author: "fray Julián de Espira",
    number: 61,
    link: "https://www.youtube.com/watch?v=JXzq1-XKkmo",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Creo en Jesús",
    author: "Carmelo Erdozáin Gil",
    number: 62,
    link: "https://www.youtube.com/watch?v=zIX8LYnpnr4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Compasión",
    author: "-",
    number: 63,
    link: "",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cristo de los Gitanos",
    author: "Antonio Velasco Rodríguez",
    number: 64,
    link: "https://www.youtube.com/watch?v=6JDNACEpV_E",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Saeta",
    author: "Joan Manuel Serrat",
    number: 65,
    link: "https://www.youtube.com/watch?v=OC1jiy0FS4Y",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Salud de San Bernardo",
    author: "Manuel Rodríguez Ruiz",
    number: 66,
    link: "https://www.youtube.com/watch?v=8LpKlVFXtlg",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Alma de Dios",
    author: "Manuel Rodríguez Ruiz",
    number: 67,
    link: "https://www.youtube.com/watch?v=m1S7y4f3zCI",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Aurora de Resurrección",
    author: "uan Luis del Valle Pérez y Francisco José Carrasco Benítez",
    number: 68,
    link: "https://www.youtube.com/watch?v=Ah0onI_9hWI&t=13s",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Consuelo Gitano",
    author: "Antonio Velasco Rodríguez",
    number: 69,
    link: "https://www.youtube.com/watch?v=5RfW92zZk0A",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Señor de la Calzá",
    author: "Francisco David Álvarez Barroso",
    number: 70,
    link: "https://www.youtube.com/watch?v=_9sWonL8Jbg",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cristo que Vuelve",
    author: "George Friedrich Händel",
    number: 71,
    link: "https://www.youtube.com/watch?v=7tCfPQr6WnA",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "De Vuelta al Porvenir",
    author: "Francisco David Álvarez Barroso",
    number: 72,
    link: "https://www.youtube.com/watch?v=vjm4JtSvkiw",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Himno Eucarístico",
    author: "-",
    number: 73,
    link: "https://www.youtube.com/watch?v=-imshCxxZ_4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "¡Estrellla!",
    author: "-",
    number: 74,
    link: "https://www.youtube.com/watch?v=lbVK-YPZuUI",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Jesús Ante Caifás",
    author: "José Manuel Mena Hervás",
    number: 75,
    link: "https://www.youtube.com/watch?v=Nog27fTaDQw",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Llora la Soledad",
    author: "Fray Miguel Angel Murcia Muñoz",
    number: 76,
    link: "https://www.youtube.com/watch?v=rbKIkWFlfoA",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Penas en San Francisco",
    author: "José María Sánchez Martín.",
    number: 77,
    link: "https://www.youtube.com/watch?v=Ikuvp-f0Q3s",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Redentor Nuestro",
    author: "Agrupación Musical Nuestro Padre Jesús de la Redención (Córdoba)",
    number: 78,
    link: "https://www.youtube.com/watch?v=YiKhQJoyd8A",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Siete Dolores",
    author: "Nicolás Barbero Rivas",
    number: 79,
    link: "https://www.youtube.com/watch?v=rot-UIbyCXU",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Junto a Ti",
    author: "Jesús Lora Vaquero",
    number: 80,
    link: "https://www.youtube.com/watch?v=eeRl0XEsNrQ",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Padre",
    author: "-",
    number: 81,
    link: "https://www.youtube.com/watch?v=y9lFeLl9Ue4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Estrella que nos Guía",
    author: "José Manuel Mena Hervás",
    number: 82,
    link: "https://www.youtube.com/watch?v=BzWnEEfVpYA",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "El Misterio de la Última Cena",
    author: "Joaquín Gómez",
    number: 83,
    link: "https://www.youtube.com/watch?v=utxovi_YMZw",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Las Cinco Estrellas de tu Cara",
    author: "Pablo López Lomas",
    number: 84,
    link: "https://www.youtube.com/watch?v=m-kJOZpqjQk",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Soñando a tus Pies",
    author: "J. Antonio y Francisco Flores",
    number: 85,
    link: "https://www.youtube.com/watch?v=Oi7LUAG7zcc",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Caenaculum",
    author: "Cristobal López Gándara",
    number: 86,
    link: "https://www.youtube.com/watch?v=qXHRvrRitgk",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Cristo de la Resurrección",
    author: "Joaquín Gómez",
    number: 87,
    link: "https://www.youtube.com/watch?v=K3psyHk-hRQ",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "La Conversión",
    author: "Hermanos Flores",
    number: 88,
    link: "https://www.youtube.com/watch?v=cAl3hGFlLBM",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Ante Caifás",
    author: "Norberto Tapia",
    number: 89,
    link: "https://www.youtube.com/watch?v=P4EjdE_H6Lw",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Ehyeh",
    author: "Alejandro Pedraza Mascaraque",
    number: 90,
    link: "https://www.youtube.com/watch?v=8urdBAGxvn4",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "El Prendimiento de Jesús",
    author: "Alejandro Cubero Romero",
    number: 91,
    link: "https://www.youtube.com/watch?v=TcCu0YKxzRc",
    moreInformation: ""
  },
  {
    id: uuidv4(),
    name: "Military Escort",
    author: "Harold Bennett",
    number: 101,
    link: "https://www.youtube.com/watch?v=mi_4mLlCv1g&t=86s",
    moreInformation: ""
  },
];

// Referencia a la colección donde quieres insertar las marchas
const marchasCollectionRef = db.collection('marchas');

// Iterar sobre cada marcha y agregarla a la colección en Firestore
marchas.forEach(marcha => {
  marchasCollectionRef.doc(marcha.id).set(marcha)
    .then(() => {
      console.log('Marcha insertada con ID:', marcha.id);
    })
    .catch((error) => {
      console.error('Error al insertar marcha:', error);
    });
});
