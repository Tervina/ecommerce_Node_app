// n BLoC (Business Logic Component), events represent user actions or triggers in your app — things that tell the app:
// ➡️ “Hey! Something needs to happen.”

import 'package:equatable/equatable.dart'; //Without this, Flutter can't properly know if two events or states are the same.

// `abstract` = you **can’t create an object directly** from this class.
// - It’s like a **template or blueprint**.
abstract class ProductEvent extends Equatable {
  // For ProductEvent, it has no special fields — so it returns an empty list.
  @override
  List<Object?> get props => [];
}

class LoadProducts
    extends ProductEvent {} //- It says: “Hey Bloc! Load the product list now.”
