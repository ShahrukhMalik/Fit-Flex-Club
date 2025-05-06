const { onSchedule } = require("firebase-functions/v2/scheduler");
const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();


exports.onReactionCreated = functions.firestore.onDocumentCreated(
  "announcements/{announcementId}/reactions/{reactionId}",
  async (snap, context) => {
    const { announcementId } = snap.params;

    // if (!snap.exists) {
    //   console.warn("No reaction data found.");
    //   return null;
    // }

    const db = admin.firestore();
    const reactionsRef = db
      .collection("announcements")
      .doc(announcementId)
      .collection("reactions");

    const announcementRef = db.collection("announcements").doc(announcementId);

    try {
      const reactionsSnapshot = await reactionsRef.get();
      const count = reactionsSnapshot.size;

      await announcementRef.update({ 
        reactionsCount: count,
        updatedAt: Date.now()  // epoch timestamp in ms
      });

      console.log(
        `Updated reactionsCount for announcement ${announcementId} to ${count}`
      );
    } catch (error) {
      console.error("Error updating reactionsCount:", error);
    }

    return null;
  }
);
exports.onReactionWritten = functions.firestore.onDocumentWritten(
  "announcements/{announcementId}/reactions/{reactionId}",
  async (snap, context) => {
    const { announcementId } = snap.params;

    // if (!snap.exists) {
    //   console.warn("No reaction data found.");
    //   return null;
    // }

    const db = admin.firestore();
    const reactionsRef = db
      .collection("announcements")
      .doc(announcementId)
      .collection("reactions");

    const announcementRef = db.collection("announcements").doc(announcementId);

    try {
      const reactionsSnapshot = await reactionsRef.get();
      const count = reactionsSnapshot.size;

      await announcementRef.update({ 
        reactionsCount: count,
        updatedAt: Date.now()  // epoch timestamp in ms
      });

      console.log(
        `Updated reactionsCount for announcement ${announcementId} to ${count}`
      );
    } catch (error) {
      console.error("Error updating reactionsCount:", error);
    }

    return null;
  }
);
exports.onCommentCreated = functions.firestore.onDocumentCreated(
  "announcements/{announcementId}/comments/{commentId}",
  async (snap, context) => {
    const { announcementId } = snap.params;

    // if (!snap.exists) {
    //   console.warn("No reaction data found.");
    //   return null;
    // }

    const db = admin.firestore();
    const commentsRef = db
      .collection("announcements")
      .doc(announcementId)
      .collection("comments");

    const announcementRef = db.collection("announcements").doc(announcementId);

    try {
      const reactionsSnapshot = await commentsRef.get();
      const count = reactionsSnapshot.size;

      await announcementRef.update({ commentsCount: count });

      console.log(
        `Updated reactionsCount for announcement ${announcementId} to ${count}`
      );
    } catch (error) {
      console.error("Error updating commentsCount:", error);
    }

    return null;
  }
);

exports.onMessageCreated = functions.firestore.onDocumentCreated(
  "chats/{chatId}/messages/{messageId}",
  async (snap, context) => {
    const messageData = snap.data;
    const { chatId } = snap.params;

    console.log(messageData);

    if (!messageData) {
      console.warn("Missing message data");
      return null;
    }

    // Fetch members from the chat document
    const chatRef = db.collection("chats").doc(chatId);
    const chatSnap = await chatRef.get();

    if (!chatSnap.exists) {
      console.error(`Chat ${chatId} not found.`);
      return null;
    }

    const chatData = chatSnap.data();
    const lastSenderId = chatData.lastSender;
    const members = chatData.members;

    if (!Array.isArray(members)) {
      console.error(`No valid members array in chat ${chatId}.`);
      return null;
    }

    // Get sender's username from users collection
    let senderUsername = "Someone";
    try {
      const senderDoc = await db.collection("Users").doc(lastSenderId).get();
      if (senderDoc.exists) {
        const senderData = senderDoc.data();
        senderUsername = senderData.username || "Someone";
      }
    } catch (err) {
      console.error("Error fetching sender username:", err);
    }
    console.log("Members", members);
    console.log("Sender Name :", senderUsername);

    // Loop through members and notify others
    const notifyPromises = members.map(async (member) => {
      const memberId = member.userId;
      if (memberId === lastSenderId) return;
      console.log("Member ID", memberId);
      try {
        const userDoc = await db.collection("Users").doc(memberId).get();
        if (!userDoc.exists) return;
        console.log("USER DOC", userDoc.data());
        const userData = userDoc.data();
        const fcmToken = userData.fcmToken;
        if (!fcmToken) return;

        console.log("Reciver FCM :", fcmToken);

        const message = {
          token: fcmToken,
          notification: {
            title: "New Message",
            body: `You got a new message from ${senderUsername}`,
          },
        };

        await messaging.send(message);
        console.log("Message Sent");
      } catch (error) {
        console.error(`Error notifying user ${memberId}:`, error);
      }
    });

    await Promise.all(notifyPromises);
    return null;
  }
);

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
