# E-Commerce Project

A full-stack e-commerce application built with Flutter for the frontend and Node.js for the backend, featuring modern UI/UX design and robust backend architecture.

## 🚀 Features

### Frontend (Flutter)
- **Modern UI/UX**: Clean and intuitive interface with responsive design
- **Product Catalog**: Browse products with categories, search, and filtering
- **Shopping Cart**: Add, remove, and manage cart items
- **User Authentication**: Secure login and registration system
- **Order Management**: Track orders and view order history
- **Payment Integration**: Secure payment processing
- **Real-time Updates**: Live inventory and pricing updates

### Backend (Node.js)
- **RESTful API**: Well-structured API endpoints
- **Authentication & Authorization**: JWT-based security
- **Database Integration**: Efficient data management with ORM
- **Product Management**: CRUD operations for products and categories
- **Order Processing**: Complete order lifecycle management
- **User Management**: User profiles and account management
- **Payment Processing**: Secure payment gateway integration

## 🛠️ Tech Stack

### Frontend
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language for Flutter
- **Provider/Bloc**: State management
- **HTTP**: API communication

### Backend
- **Node.js**: Server-side JavaScript runtime
- **Express.js**: Web application framework
- **Database**: SQL/NoSQL database (SQLite, PostgreSQL, or MySQL)
- **Authentication**: JWT (JSON Web Tokens)
- **ORM**: Database abstraction layer

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK** (>=3.0.0)
- **Dart SDK** (>=2.18.0)
- **Node.js** (>=16.0.0)
- **npm** or **yarn**
- **Python** (for some dependencies)
- **Git**

### Development Tools
- **VS Code** or **Android Studio** (recommended)
- **Flutter and Dart extensions**
- **Postman** (for API testing)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/ecommerce-project.git
cd ecommerce-project
```

### 2. Backend Setup

#### Navigate to backend directory
```bash
cd ecommerce-nodeBackend
```

#### Install dependencies
```bash
npm install
```

#### Environment Configuration
Create a `.env` file in the backend root directory:
```env
NODE_ENV=development
PORT=3000
DATABASE_URL=your_database_connection_string
JWT_SECRET=your_jwt_secret_key
STRIPE_SECRET_KEY=your_stripe_secret_key
EMAIL_SERVICE_API_KEY=your_email_service_key
```

#### Database Setup
```bash
# Run database migrations
npm run migrate

# Seed the database (optional)
npm run seed
```

#### Start the backend server
```bash
npm start
# or for development
npm run dev
```

### 3. Frontend Setup

#### Navigate to Flutter app directory
```bash
cd ../ecommerce_flutter_app
```

#### Install Flutter dependencies
```bash
flutter pub get
```

#### Configure API endpoints
Update the API base URL in `lib/config/api_config.dart`:
```dart
class ApiConfig {
  static const String baseUrl = 'http://localhost:5000/api';
  // For physical device testing, use your computer's IP address
  // static const String baseUrl = 'http://192.168.1.100:3000/api';
}
```

#### Run the Flutter app
```bash
# For development
flutter run

# For specific platform
flutter run -d chrome    # Web
flutter run -d android   # Android
flutter run -d ios       # iOS
```

## 📱 Running the Application

### Development Mode
1. Start the backend server:
   ```bash
   cd ecommerce-nodeBackend
   npm run dev
   ```

2. Start the Flutter app:
   ```bash
   cd ecommerce_flutter_app
   flutter run
   ```

### Production Build

#### Backend
```bash
npm run build
npm start
```

#### Frontend
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## 🏗️ Project Structure

```
ecommerce-project/
├── ecommerce_flutter_app/          # Flutter frontend
│   ├── lib/
│   │   ├── features/
│   │   │   ├── product/
│   │   │   ├── auth/
│   │   │   ├── cart/
│   │   │   └── profile/
│   │   ├── domain/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── core/
│   ├── assets/
│   └── pubspec.yaml
├── ecommerce-nodeBackend/           # Node.js backend
│   ├── config/
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── middlewares/
│   ├── utils/
│   └── server.js
└── README.md
```

## 🔧 API Documentation

### Base URL
```
http://localhost:3000/api
```

### Authentication Endpoints
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `GET /auth/profile` - Get user profile

### Product Endpoints
- `GET /products` - Get all products
- `GET /products/:id` - Get product by ID
- `POST /products` - Create new product (Admin)
- `PUT /products/:id` - Update product (Admin)
- `DELETE /products/:id` - Delete product (Admin)

### Cart Endpoints
- `GET /cart` - Get user's cart
- `POST /cart/add` - Add item to cart
- `PUT /cart/update` - Update cart item
- `DELETE /cart/remove/:id` - Remove item from cart

### Order Endpoints
- `GET /orders` - Get user's orders
- `POST /orders` - Create new order
- `GET /orders/:id` - Get order details

## 🧪 Testing

### Backend Testing
```bash
cd ecommerce-nodeBackend
npm test
```

### Frontend Testing
```bash
cd ecommerce_flutter_app
flutter test
```

## 📦 Deployment

### Backend Deployment (Heroku)
1. Install Heroku CLI
2. Create Heroku app
3. Configure environment variables
4. Deploy:
   ```bash
   git subtree push --prefix=ecommerce-nodeBackend heroku main
   ```

### Frontend Deployment
- **Android**: Upload APK to Google Play Store
- **iOS**: Upload to App Store Connect
- **Web**: Deploy to Firebase Hosting, Netlify, or Vercel

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@yourproject.com or join our Slack channel.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Node.js community for excellent packages
- All contributors who helped build this project

---

**Happy Coding! 🎉**