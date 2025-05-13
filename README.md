# 24BITS Events - Mobile Application

## Project Overview
24BITS Events is a Flutter-based mobile application designed for event management and ticket booking. The application provides a seamless experience for users to browse, book, and manage event tickets, while also offering administrative capabilities for event management.

## Application Architecture

### Core Components

#### 1. Database Layer (`/lib/database`)
- Handles all database operations
- Manages data persistence
- Implements SQLite integration

#### 2. Repositories (`/lib/repositories`)
- Implements data access patterns
- Manages CRUD operations
- Handles data caching and synchronization

#### 3. Services (`/lib/services`)
- Implements business logic
- Handles authentication and authorization
- Manages API communications

#### 4. Models (`/lib/models`)
- `User`: User data structure and management
- `Event`: Event-related data structure
- Contains data models for the application

### Screens (Views)

#### 1. Welcome Screen (`welcome_screen.dart`)
- Initial landing page
- Provides navigation options to login/register
- Introduces users to the application

#### 2. Authentication Screens
- `login_screen.dart`: User authentication interface
- `registration_screen.dart`: New user registration
- `admin_login_screen.dart`: Administrative access
- `change_password_screen.dart`: Password management

#### 3. Main Application Screens
- `home_screen.dart`: Main dashboard showing events
- `event_details_screen.dart`: Detailed event information
- `checkout_screen.dart`: Ticket purchase interface
- `digital_ticket_screen.dart`: Digital ticket display
- `edit_profile_screen.dart`: User profile management

### Widgets (`/lib/widgets`)
- Reusable UI components
- Custom widgets for consistent design
- Shared UI elements

## Features

### User Features
1. **Account Management**
   - User registration
   - Login/Logout functionality
   - Profile editing
   - Password management

2. **Event Management**
   - Browse events
   - View event details
   - Purchase tickets
   - Access digital tickets

3. **Ticket Management**
   - Multiple ticket types (Regular, VIP, Multi-day)
   - Digital ticket storage
   - Ticket validation

### Admin Features
1. **Event Administration**
   - Create and manage events
   - Update event details
   - Monitor ticket sales

2. **User Management**
   - View user statistics
   - Manage user accounts

## Technical Implementation

### UI/UX Design
- Material Design 3 implementation
- Consistent color scheme (Primary: Blue)
- Responsive layout design
- Intuitive navigation flow

### Security Features
- Secure authentication
- Password encryption
- Protected admin access
- Secure ticket validation

### Data Management
- Local data persistence
- Efficient data synchronization
- Robust error handling
- Data validation

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Git

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure your local environment
4. Run the application using `flutter run`

## Development Guidelines
- Follow Flutter best practices
- Maintain consistent code formatting
- Write comprehensive documentation
- Implement proper error handling

## Testing
- Unit tests for core functionality
- Integration tests for user flows
- UI testing for components
- Performance testing

## Future Enhancements
1. Payment gateway integration
2. Social media sharing
3. Event recommendations
4. Real-time notifications
5. Analytics dashboard

## Contributors
- Team Triple Logic Mobile
