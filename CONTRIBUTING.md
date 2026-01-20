# Contributing to Lipila Flutter SDK

First off, thank you for considering contributing to the Lipila Flutter SDK! It's people like you that make this SDK better for the entire Zambian fintech ecosystem.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct:

- Be respectful and inclusive
- Welcome newcomers and encourage diversity
- Focus on what is best for the community
- Show empathy towards other community members

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

**Bug Report Template:**

```markdown
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Initialize client with '...'
2. Call method '...'
3. See error

**Expected behavior**
What you expected to happen.

**Actual behavior**
What actually happened.

**Code snippet**
```dart
// Your code here
```

**Environment:**
- SDK Version: [e.g., 1.0.0]
- Flutter Version: [e.g., 3.10.0]
- Dart Version: [e.g., 3.0.0]
- Platform: [e.g., Android, iOS, Web]
- Device: [e.g., iPhone 12, Pixel 6]

**Additional context**
Any other context about the problem.
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful**
- **List any alternatives you've considered**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the coding style** (see below)
3. **Add tests** for any new functionality
4. **Update documentation** as needed
5. **Ensure tests pass** (`flutter test`)
6. **Run the analyzer** (`dart analyze`)
7. **Format your code** (`dart format .`)
8. **Create a pull request**

## Development Setup

### Prerequisites

- Flutter 3.0.0 or higher
- Dart 3.0.0 or higher

### Setting Up Your Environment

```bash
# Clone your fork
git clone https://github.com/your-username/lipila-flutter.git
cd lipila-flutter

# Install dependencies
flutter pub get

# Run tests
flutter test

# Run analyzer
dart analyze

# Format code
dart format .
```

### Project Structure

```
lib/
├── lipila_flutter.dart       # Main export file
└── src/
    ├── client/               # HTTP client and main SDK client
    ├── config/               # Configuration classes
    ├── exceptions/           # Custom exceptions
    ├── models/               # Data models
    ├── services/             # Service layer (Balance, Collections, etc.)
    └── utils/                # Utilities and validators
```

## Coding Style

We follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide and use `very_good_analysis` for linting.

### Key Points

1. **Use meaningful names**
   ```dart
   // Good
   final client = LipilaClient.sandbox(apiKey);
   
   // Bad
   final c = LipilaClient.sandbox(k);
   ```

2. **Document public APIs**
   ```dart
   /// Creates a new collection request.
   /// 
   /// [referenceId] - Unique reference for this transaction
   /// [amount] - Amount to collect
   Future<CollectionResponse> createCollection({
     required String referenceId,
     required double amount,
   });
   ```

3. **Handle errors appropriately**
   ```dart
   try {
     final result = await client.balance.getBalance();
     return result;
   } on AuthException catch (e) {
     // Handle auth error
   } on NetworkException catch (e) {
     // Handle network error
   }
   ```

4. **Write tests for new features**
   ```dart
   test('validates phone number correctly', () {
     expect(Validators.isValidZambianPhone('0977123456'), true);
     expect(Validators.isValidZambianPhone('invalid'), false);
   });
   ```

5. **Use const constructors when possible**
   ```dart
   const config = LipilaConfig(
     apiKey: 'test',
     environment: Environment.sandbox,
   );
   ```

## Testing Guidelines

### Writing Tests

- Place tests in the `test/` directory
- Name test files with `_test.dart` suffix
- Group related tests
- Use descriptive test names

```dart
group('Validators', () {
  group('Phone Number Validation', () {
    test('validates correct Zambian phone numbers', () {
      expect(Validators.isValidZambianPhone('0977123456'), true);
    });
    
    test('rejects invalid phone numbers', () {
      expect(Validators.isValidZambianPhone('123'), false);
    });
  });
});
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/validators_test.dart

# Run with coverage
flutter test --coverage

# Run in verbose mode
flutter test --reporter expanded
```

### Test Coverage Goals

- Aim for >80% code coverage
- All public APIs must have tests
- Critical paths must have comprehensive tests
- Edge cases should be tested

## Documentation Guidelines

### Code Documentation

Use dartdoc comments for public APIs:

```dart
/// Creates a mobile money collection.
/// 
/// This method initiates a collection request from a customer's
/// mobile money account.
/// 
/// Example:
/// ```dart
/// final collection = await client.collections.createCollection(
///   referenceId: 'ORDER-123',
///   amount: 100.00,
///   accountNumber: '260977123456',
///   currency: 'ZMW',
/// );
/// ```
/// 
/// Throws [ValidationException] if parameters are invalid.
/// Throws [AuthException] if API key is invalid.
/// Throws [ApiException] if the request fails.
Future<CollectionResponse> createCollection({
  required String referenceId,
  required double amount,
  required String accountNumber,
  required String currency,
});
```

### README Updates

If you add new features, update the README.md with:
- New feature description
- Usage examples
- Any breaking changes

### Changelog

Update CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [Unreleased]

### Added
- New feature description

### Changed
- Changes to existing functionality

### Fixed
- Bug fixes
```

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```
feat(collections): add support for card payments

Implemented card collection endpoint with checkout URL generation.
Updated CollectionService to handle both mobile and card payments.

Closes #123
```

```
fix(validators): correct phone number regex pattern

Fixed regex to properly validate Zambian phone numbers starting with 09X.

Fixes #456
```

## Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feat/my-new-feature
   ```

2. **Make your changes**
   - Write code
   - Add tests
   - Update documentation

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat(service): add new feature"
   ```

4. **Push to your fork**
   ```bash
   git push origin feat/my-new-feature
   ```

5. **Create a Pull Request**
   - Use a clear title
   - Describe what changes you made
   - Reference any related issues
   - Ensure all checks pass

### PR Checklist

Before submitting your PR, ensure:

- [ ] Code follows the style guide
- [ ] All tests pass (`flutter test`)
- [ ] No analyzer warnings (`dart analyze`)
- [ ] Code is formatted (`dart format .`)
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated
- [ ] Commit messages follow conventions
- [ ] No breaking changes (or clearly documented)

## Release Process

Releases are handled by maintainers. The process involves:

1. Update version in `pubspec.yaml`
2. Update CHANGELOG.md
3. Create a git tag
4. Publish to pub.dev
5. Create GitHub release

## Questions?

Feel free to:
- Open an issue for questions
- Join our community discussions
- Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Lipila Flutter SDK! 🎉
