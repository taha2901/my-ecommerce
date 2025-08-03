const functions = require('firebase-functions');
const stripe = require('stripe')('sk_test_51RCn9fJtG2QSex5zbHjguNWuw2XzHCXqND8H1TgZqjspHZd7iiMVy97TnEPEEahqWzKhZoPfqZHjxstH99MIZUit000TAh9dqj');

exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  try {
    const { amount, currency = 'usd', customerId } = data;
    
    const paymentIntent = await stripe.paymentIntents.create({
      amount: Math.round(amount * 100), // تحويل إلى cents
      currency: currency,
      customer: customerId,
      automatic_payment_methods: {
        enabled: true,
      },
    });

    return {
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
    };
  } catch (error) {
    console.error('Error creating payment intent:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

exports.createCustomer = functions.https.onCall(async (data, context) => {
  try {
    const { email, name } = data;
    
    const customer = await stripe.customers.create({
      email: email,
      name: name,
    });

    return {
      customerId: customer.id,
    };
  } catch (error) {
    console.error('Error creating customer:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});