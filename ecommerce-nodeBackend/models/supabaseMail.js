const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: process.env.SUPABASE_SMTP_HOST,
  port: process.env.SUPABASE_SMTP_PORT,
  secure: false,
  auth: {
    user: process.env.SUPABASE_SMTP_USER,
    pass: process.env.SUPABASE_SMTP_PASS,
  },
});

async function sendOrderConfirmation(email, order) {
  const mailOptions = {
    from: `Tech Store <${process.env.SUPABASE_SMTP_FROM}>`,
    to: email,
    subject: `Your Order #${order._id} Confirmation`,
    html: `
      <h2>Thank you for your order!</h2>
      <p>Hello <b>${order.billingDetails.fullName}</b>,</p>
      <p>Your order is confirmed and now being processed.</p>

      <h3>Order Items:</h3>
      <ul>
        ${order.items
          .map(
            (item) =>
              `<li>${item.product_name} — Qty: ${item.quantity} — $${item.price}</li>`
          )
          .join("")}
      </ul>

      <p><b>Total:</b> $${order.totalAmount}</p>
      <p><b>Payment Method:</b> ${order.paymentMethod}</p>

      <br><p>We'll notify you when your order ships.</p>
    `,
  };

  await transporter.sendMail(mailOptions);
}

module.exports = { sendOrderConfirmation };
