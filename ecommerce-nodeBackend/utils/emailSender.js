// const nodemailer = require("nodemailer");

// const transporter = nodemailer.createTransport({
//   service: "gmail",
//   auth: {
//     user: process.env.EMAIL_USER,      // your email
//     pass: process.env.EMAIL_PASS,      // app password
//   },
// });

// async function sendOrderEmail(to, subject, html) {
//   await transporter.sendMail({
//     from: `"Ecommerce Store" <${process.env.EMAIL_USER}>`,
//     to,
//     subject,
//     html,
//   });
// }

// module.exports = sendOrderEmail;
const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,       // smtp.mj.smtp.com
  port: 587,
  secure: false,
  auth: {
    user: process.env.SMTP_USER,     // Supabase SMTP username
    pass: process.env.SMTP_PASS      // Supabase SMTP password
  }
});

async function sendOrderEmail(to, subject, html) {
  await transporter.sendMail({
    from: process.env.SMTP_FROM,     // e.g: no-reply@yourdomain.com
    to,
    subject,
    html
  });
}

module.exports = sendOrderEmail;
