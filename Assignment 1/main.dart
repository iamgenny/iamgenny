import 'dart:io';

// Abstract base class representing a generic customer
abstract class Customer {
  String destination;
  String contactPhone;
  String contactName;
  double price;

  Customer(this.destination, this.contactPhone, this.contactName, this.price);

  // Common actions for all customers
  void bookTravel() {
    print('$contactName booked a trip to $destination.');
  }

  void getTransportToAirport() {
    print('$contactName is getting transportation to the airport.');
  }

  void additionalInfo(); // Abstract method for specific customer details
}

// Individual customer class
class Individual extends Customer {
  String insurancePolicy;

  Individual(String destination, String contactPhone, String contactName, double price, this.insurancePolicy)
      : super(destination, contactPhone, contactName, price);

  @override
  void additionalInfo() {
    print("$contactName has travel insurance policy: $insurancePolicy.");
    print("${contactName}'s workplace has been notified.");
  }
}

// Family customer class
class Family extends Customer {
  String healthInsurance;
  String membersRemaining;

  Family(String destination, String contactPhone, String contactName, double price, this.healthInsurance, this.membersRemaining)
      : super(destination, contactPhone, contactName, price);

  @override
  void additionalInfo() {
    print("${contactName}'s family has health coverage from $healthInsurance.");
    print('Family members staying in Canada: $membersRemaining.');
  }
}

// Group customer class
class Group extends Customer {
  String organizingHardware;
  String destinationCompany;

  Group(String destination, String contactPhone, String contactName, double price, this.organizingHardware, this.destinationCompany)
      : super(destination, contactPhone, contactName, price);

  @override
  void additionalInfo() {
    print('Group led by $contactName is using $organizingHardware for organization.');
    print('Destination company $destinationCompany has been notified.');
  }
}

// Function to safely read user input
String getInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

// Function to safely read a double value
double getDoubleInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String input = stdin.readLineSync() ?? '';
    double? value = double.tryParse(input);
    if (value != null) return value;
    print("Invalid input. Please enter a valid number.");
  }
}

// Main function
void main() {
  List<Customer> customers = []; // List to store customer objects
  double totalPrice = 0; // Variable to track total trip cost

  // Loop to input multiple customer entries
  while (true) {
    int choice = int.tryParse(getInput('\nEnter customer type (1: Individual, 2: Family, 3: Group, 0: Exit): ')) ?? -1;

    if (choice == 0) break; // Exit condition

    String destination = getInput('Enter Destination: ');
    String contactPhone = getInput('Enter Contact Phone: ');
    String contactName = getInput('Enter Contact Name: ');
    double price = getDoubleInput('Enter Price: ');

    // Switch statement for different customer types
    switch (choice) {
      case 1:
        String policy = getInput('Enter Travel Insurance Policy Number: ');
        customers.add(Individual(destination, contactPhone, contactName, price, policy));
        break;
      case 2:
        String healthInsurance = getInput('Enter Family Health Insurance Company: ');
        String membersRemaining = getInput('Enter Family Members Remaining in Canada: ');
        customers.add(Family(destination, contactPhone, contactName, price, healthInsurance, membersRemaining));
        break;
      case 3:
        String hardware = getInput('Enter Organizing Hardware (e.g., whistles, flags): ');
        String destinationCompany = getInput('Enter Destination Company Name: ');
        customers.add(Group(destination, contactPhone, contactName, price, hardware, destinationCompany));
        break;
      default:
        print('Invalid option. Try again.');
    }
  }

  // Print Receipt
  print("\n==================== RECEIPT ====================\n");
  for (var customer in customers) {
    print("Customer: ${customer.contactName}");
    print("Destination: ${customer.destination}");
    print("Contact: ${customer.contactPhone}");
    print("Price: \$${customer.price.toStringAsFixed(2)}");
    customer.additionalInfo();
    print("--------------------------------");
    totalPrice += customer.price;
  }

  // Display total price using an arrow function
  print("\n==================== TOTAL COST ========");
  var displayTotal = () => print('Total Price of all trips: \$${totalPrice.toStringAsFixed(2)}');
  displayTotal();
  print("==============================");
}
