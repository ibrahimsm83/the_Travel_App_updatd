const functions = require("firebase-functions");
const admin=require('firebase-admin');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//
admin.initializeApp(functions.config().firestore);
//db use for data get from firebase
var db=admin.firestore();
//var fcm=admin.messaging();

exports.notifyNewMessage = functions.firestore.document("/DailyRides/{dailyrideid}").onCreate(async(snapshot,context)=>{
  if(snapshot.empty){
    console.log("no device");
    return;
  }
  const message=snapshot.data();
 const querySnapshot=db.collection('Drivers').doc(message.driverid).collection('tokens').get();
 const token=(await querySnapshot).docs.map((snap)=>snap.id);
  // console.log(token);
  // console.log("message.userid");
  // console.log(message.userid);
   // Notification details.
   const payload = {
    notification: {
        title: "The Travel App",
        body:message.destination,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        priority: "high",
        sound: 'default',
    },
    data: {
      command:message.userid,
    },
  };
  // try{
// //const response=fcm.sendToDevice(token1,payload);
// admin.messaging() 
// const response=fcm.sendToDevice(token1,payload);
// console.log("Notification send successfully ");
//    } catch (err){
//     console.log(err.message);
//     console.log(err.messaging);
//     console.log("Error sending Notification.");
//    }
    // data: {
    //     'title': 'You have new message(s)',
    //     'body': 'New message(s) recieved.',
    //     'peerid': message.from,
    //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    // },

//};
return admin.messaging().sendToDevice(token,payload);
}
);


