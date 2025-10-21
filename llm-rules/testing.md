# Testing Guidelines

## Test Coverage

- Write tests for all business logic
- Test edge cases and error conditions
- Aim for meaningful coverage, not arbitrary percentages

## Test Structure

- Arrange-Act-Assert pattern
- One assertion per test when practical
- Clear, descriptive test names

## Unit Tests

- Test individual functions/methods in isolation
- Mock external dependencies
- Fast execution (< 1 second per test)

## Integration Tests

- Test component interactions
- Use test doubles for external services
- Verify actual behavior, not implementation

## Test Data

- Use factories or fixtures for test data
- Avoid hardcoded magic values
- Make test data representative of production

## Assertions

- Prefer specific assertions over generic ones
- Assert on behavior, not implementation details
- Include meaningful failure messages

## Test Organization

- Mirror source code structure
- Group related tests
- Keep test files close to code they test
