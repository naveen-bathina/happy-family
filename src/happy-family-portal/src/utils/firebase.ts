import { initializeApp } from 'firebase/app';
import { getAuth, RecaptchaVerifier, signInWithPhoneNumber, PhoneAuthProvider, signInWithCredential } from 'firebase/auth';

const firebaseConfig = {
    apiKey: 'AIzaSyB3AhbriG9BJC53MWPIglt-yr9Ey9m65GY',
    authDomain: 'e-learning-ecf0b.firebaseapp.com',
    projectId: 'e-learning-ecf0b',
    storageBucket: 'e-learning-ecf0b.firebasestorage.app',
    messagingSenderId: '1002989095665',
    appId: '1:1002989095665:web:72cd549be6f1cf44b8b750',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);

export { auth, RecaptchaVerifier, signInWithPhoneNumber, PhoneAuthProvider, signInWithCredential };
