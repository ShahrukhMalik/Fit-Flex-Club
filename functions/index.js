const { onSchedule } = require("firebase-functions/v2/scheduler");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();
exports.sendNotificationsEvery5Min = onSchedule(
  "every 5 minutes",
  async (event) => {
    try {
      const snapshot = await db.collection("Notifications").get();

      if (snapshot.empty) {
        logger.info("No documents found.");
        return;
      }

      for (const doc of snapshot.docs) {
        const data = doc.data();

        const clients = data.selectedClients;
        const title = data.notificationTitle;
        const body = data.notificationBody;

        if (!clients || !Array.isArray(clients)) {
          logger.warn(`No valid selectedClients in doc: ${doc.id}`);
          continue;
        }

        let updatedClients = [...clients];

        for (let i = 0; i < clients.length; i++) {
          const client = clients[i];

          // ✅ Skip if already sent
          if (client.is_sent === true) {
            continue;
          }

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

            // Mark as sent
            updatedClients[i] = {
              ...client,
              is_sent: true,
              notification_sent_at: new Date().getTime(),
              remark: `Notification sent to ${client.fcmToken}: ${response}`,
            };
          } catch (err) {
            logger.error(`Error sending to ${client.fcmToken}:`, err);

            // Optionally mark failure too
            updatedClients[i] = {
              ...client,
              is_sent: false,
              notification_sent_at: new Date().getTime(),
              remark: `Error sending to ${client.fcmToken}: ${err}`,
            };
          }
        }

        await db.collection("Notifications").doc(doc.id).update({
          selectedClients: updatedClients,
        });

        logger.info(`Updated selectedClients for doc: ${doc.id}`);
      }
    } catch (error) {
      logger.error("Error reading documents or sending notifications:", error);
    }
  }
);
