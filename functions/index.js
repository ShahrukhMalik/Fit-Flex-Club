const { onSchedule } = require("firebase-functions/v2/scheduler");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

exports.sendNotificationsEvery5Min = onSchedule("every 5 minutes", async (event) => {
  try {
    const snapshot = await db.collection("YOUR_COLLECTION_NAME").get();

    if (snapshot.empty) {
      logger.info("No documents found.");
      return;
    }

    for (const doc of snapshot.docs) {
      const data = doc.data();

      const clients = data.selectedClients; // Should be Array<{ fcmToken: string }>
      const title = data.notificationTitle;
      const body = data.notificationBody;

      if (!clients || !Array.isArray(clients)) {
        logger.warn(`No valid selectedClients in doc: ${doc.id}`);
        continue;
      }

      for (const client of clients) {
        if (!client.fcmToken) {
          logger.warn(`Missing fcmToken for client in doc: ${doc.id}`);
          continue;
        }

        const message = {
          token: client.fcmToken,
          notification: {
            title: title || "Notification",
            body: body || "You have a new update.",
          },
        };

        try {
          const response = await messaging.send(message);
          logger.info(`Notification sent to ${client.fcmToken}: ${response}`);
        } catch (err) {
          logger.error(`Error sending to ${client.fcmToken}:`, err);
        }
      }
    }
  } catch (error) {
    logger.error("Error reading documents or sending notifications:", error);
  }
});
