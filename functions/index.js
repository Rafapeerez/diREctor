const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTopic =
    functions.firestore.document("eventos/{uid}").onWrite(
        async (event) => {
          const message = {
            notification: {
              title: "Nuevo evento",
              body: "Se ha añadido un nuevo evento, entra para ver su información con más detalle.",
            },
            topic: "events",
          };

          const response = await admin.messaging().send(message);
          console.log(response);
        },
    );
