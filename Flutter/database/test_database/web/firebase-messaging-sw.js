importScripts("https://www.gstatic.com/firebasejs/10.5.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.5.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyBNnRJknHIxUHDrqloRinz_j3kRMRHo2KQ",
  authDomain: "testproject-ee7d9.firebaseapp.com",
  projectId: "testproject-ee7d9",
  storageBucket: "testproject-ee7d9.appspot.com",
  messagingSenderId: "262898323986",
  appId: "1:262898323986:web:ed05ab88b06be98858fecb",
});

const messaging = firebase.messaging();
