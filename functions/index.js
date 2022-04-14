const functions = require("firebase-functions");
const admin=require('firebase-admin');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//
admin.initializeApp();
//db use for data get from firebase
var db=admin.firestore();
var fcm=admin.messaging();

// _firestore
//         .collection('Drivers')
//         .doc('03054601122')
//         .get()
//         .then((value) => print(" ******************** dsfds        ///////${value.data()?["services"]}"));

exports.notifyNewMessage = functions.firestore.document('DailyRides/{dailyrideid}').onCreate(async(snapshot)=>{
  if(snapshot.empty){
    console.log("no device");
    return;
  }
  //const message=snapshot.data;
  //print("driver data----------------");
  //print(message.driverid)
  //const token="dIbRAFexSgOUFYTqbwuYgg:APA91bFXUcYTD0jmxeMEEjRAFFvjbYwWJSdrNYr-KSkoyZ_vRXo5tiBnMQVJBqwz19gTAciP5-wpFuweNWXgMosFcLMRLitf0lifR_ijauD6rxmltnoQu2tXSpblJSlNwQqjJ6zEodMe";
  const token=db.collection('Drivers').doc(message.driverid).get().then((value)=>value.data()["token"]);
  
  console.log("device token****************");
  
  console.log(token);
   // Notification details.
   const payload = {
    notification: {
        title: 'You have new message(s) ibrahim',
        body: 'New message(s) recieved.',
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        priority: "high",
        sound: 'default',
    },
  };
   try{
const response=fcm.messaging().sendToDevice(token,payload);
console.log("Notification send successfully ");
   } catch (err){
    console.log("Error sending Notification.");
   }
    // data: {
    //     'title': 'You have new message(s)',
    //     'body': 'New message(s) recieved.',
    //     'peerid': message.from,
    //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    // },

//};
//return fcm.sendToDevice(token,payload)
})


