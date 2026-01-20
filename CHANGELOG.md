# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-20

### Added

#### Core Infrastructure
- Complete SDK architecture with modular design
- HTTP client with automatic retry logic and timeout handling
- Comprehensive error handling with custom exception types
- Configurable logging system with multiple log levels
- Support for both sandbox and production environments

#### Features
- **Balance Operations**: Check wallet balance (available and booked)
- **Collections**: Accept mobile money and card payments
- **Disbursements**: Send money via mobile money and bank transfers
- **Transaction Status**: Query status of collections and disbursements
- **Webhook Support**: Parse and handle callback payloads

#### Models
- `BalanceResponse` - Wallet balance information
- `CollectionRequest` / `CollectionResponse` - Collection transaction data
- `DisbursementRequest` / `DisbursementResponse` - Disbursement transaction data
- `TransactionStatus` - Transaction status information
- `CallbackPayload` - Webhook callback data
- `PaymentType` - Payment type enumeration

#### Services
- `BalanceService` - Balance operations
- `CollectionService` - Collection operations
- `DisbursementService` - Disbursement operations
- `StatusService` - Transaction status queries

#### Utilities
- Zambian phone number validation and normalization
- Amount validation
- Currency validation
- Reference ID validation
- Email validation
- SWIFT code validation

#### Developer Experience
- Type-safe API with full Dart null safety
- Comprehensive documentation with examples
- Clear error messages
- Easy-to-use convenience constructors
- Fluent API design

### Documentation
- Complete README with usage examples
- API reference documentation
- Best practices guide
- Security recommendations
- Testing guidelines

## [0.0.1] - 2026-01-20

### Added
- Initial project structure
- Basic plugin scaffolding

[1.0.0]: https://github.com/yourusername/lipila-flutter/releases/tag/v1.0.0
[0.0.1]: https://github.com/yourusername/lipila-flutter/releases/tag/v0.0.1

