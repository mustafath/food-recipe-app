import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const sendNewFoodNotification = functions.firestore
  .document('foods/{foodId}')
  .onCreate(async (snapshot, context) => {
    const foodData = snapshot.data();

    // Retrieve all users' FCM tokens
    const usersSnapshot = await admin.firestore().collection('users').get();
    const fcmTokens = usersSnapshot.docs.map((doc) => doc.data().fcmToken).filter((token) => token);

    // Create and send the notification
    const payload = {
      notification: {
        title: 'New Food Added',
        body: `${foodData.name} was added to the menu, let's checkout!`,
        click_action: 'FLUTTER_NOTIFICATION_CLICK', // Required for foreground messages
      },
    };

    return admin.messaging().sendToDevice(fcmTokens, payload);
  });