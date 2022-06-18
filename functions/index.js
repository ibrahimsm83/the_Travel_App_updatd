const functions = require("firebase-functions");
const admin = require('firebase-admin');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//
admin.initializeApp(functions.config().firestore);
//db use for data get from firebase
var db = admin.firestore();
//var fcm=admin.messaging();

exports.notifyNewMessage = functions.firestore.document("/DailyRides/{dailyrideid}").onCreate(async (snapshot, context) => {
  if (snapshot.empty) {
    console.log("no device");
    return;
  }
  const message = snapshot.data();
  const querySnapshot = db.collection('Drivers').doc(message.driverid).collection('tokens').get();
  const token = (await querySnapshot).docs.map((snap) => snap.id);
  // console.log(token);
  // console.log("message.userid");
  // console.log(message.userid);
  // Notification details.
  const payload = {
    notification: {
      title: "The Travel App",
      body: message.destination,
      click_action: 'FLUTTER_NOTIFICATION_CLICK',
      priority: "high",
      sound: 'default',
    },
    data: {
      command: message.userid,
    },
  };
  return admin.messaging().sendToDevice(token, payload);
}
);

exports.notifyUpdatedoc = functions.firestore.document("/DailyRides/{dailyrideid}").onUpdate(async (change, context) => {
  // if (change.empty) {
  //   console.log("no device");
  //   return;
  // }
  console.log("---------1- flag------------");
  // console.log(before.flag);
  const before = change.before.data()
  const after = change.after.data()
  console.log("---------before flag------------");
  console.log(before.flag);
  if (before.flag === after.flag) {
    console.log("Nothing change request accepted")
    return null
  } else {
    console.log("------------user token-0-------------");
    console.log(before.userid);
    //const documentId = context.params.docId
    console.log("-----------documentId 1------------");
    //console.log(documentId);
    const usedata = db.collection('UsersData').doc(before.userid);

    const doc = await usedata.get();
    if (!doc.exists) {
      console.log('No such document!');
    } else {
      console.log('Document data:', doc.data());
      console.log("------------user token-1-------------");
      const token = doc.data()['UToken']

      console.log("------------user token------ibr--------");
      console.log(token);
      console.log("------------user token--------ibr2------");
      const payload = {
        notification: {
          title: "The Travel App",
          body: "Your Request Canceled",
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
          priority: "high",
          sound: 'default',
        },
        // data: {
        //   command1:message.userid,
        // },
      };
      return admin.messaging().sendToDevice(token, payload);
    }
  }
});



