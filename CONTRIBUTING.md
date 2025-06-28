# Contributing to dbt-focus

Thank you for your interest in contributing to dbt-focus! This project is part of the [open-finops-stack](https://github.com/JGrubb/open-finops-stack) and aims to make FOCUS-compliant FinOps transformations accessible to everyone.

## How to Contribute

We welcome contributions of all kinds:

- **Bug reports** and feature requests
- **Documentation** improvements
- **Code contributions** for new cloud providers or FOCUS features
- **Testing** and validation of transformations
- **Examples** and use cases

## Getting Started

### Prerequisites

- Python 3.7+
- dbt-core 1.0+
- A supported data warehouse (DuckDB, Snowflake, BigQuery, Redshift, etc.)
- Access to cloud billing data (AWS CUR, Azure usage details, GCP billing export)

### Development Setup

1. **Fork and clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dbt-focus.git
   cd dbt-focus
   ```

2. **Install dependencies**
   ```bash
   pip install dbt-core dbt-duckdb  # or your preferred adapter
   dbt deps
   ```

3. **Set up your development profile**
   Create a `profiles.yml` with a `dev` target pointing to your test database.

4. **Test the existing models**
   ```bash
   dbt run --target dev
   dbt test --target dev
   ```

## Contribution Guidelines

### Adding a New Cloud Provider

When adding support for a new cloud provider (e.g., Azure, GCP):

1. **Create provider directory structure**
   ```
   models/staging/[provider]/
   ├── schema.yml
   ├── stg_[provider]_billing.sql
   └── _[provider]__models.yml  # optional model groups
   ```

2. **Add provider configuration**
   Update `dbt_project.yml` with new provider variables:
   ```yaml
   vars:
     azure:  # or gcp, oci, etc.
       billing_schema: 'azure_billing'
       billing_table: 'usage_details'
       columns:
         # Map Azure fields to standardized names
         billing_period_start: 'BillingPeriodStartDate'
         # ... etc
   ```

3. **Follow naming conventions**
   - Use the provider's native field names in configuration
   - Output standardized column names that can map to FOCUS
   - Include a `provider` column with the provider identifier

4. **Add comprehensive documentation**
   - Document all columns in `schema.yml`
   - Include data quality tests
   - Add usage examples in docstrings

5. **Test thoroughly**
   - Test with real billing data if possible
   - Validate against FOCUS specification requirements
   - Include edge cases (null values, different billing periods, etc.)

### Extending FOCUS Coverage

To add new FOCUS columns or improve existing mappings:

1. **Reference the FOCUS specification**
   - Check the [official FOCUS spec](https://focus.finops.org/) for requirements
   - Ensure mandatory fields are properly handled
   - Follow FOCUS naming conventions exactly

2. **Update staging models**
   - Add new column mappings to provider configurations
   - Use the `map_column` macro for consistency
   - Handle missing columns gracefully with null defaults

3. **Create FOCUS transformation models**
   - Build models in `models/focus/` directory
   - Transform provider-specific data to FOCUS-compliant format
   - Apply business logic for complex mappings (e.g., charge categorization)

4. **Add validation tests**
   - Test FOCUS column requirements (mandatory fields, data types)
   - Validate business logic with dbt tests
   - Include referential integrity checks

### Code Style and Standards

**SQL Style**
- Use lowercase for keywords and functions
- Indent with 2 spaces
- Use meaningful CTEs with descriptive names
- Comment complex business logic
- Follow existing code patterns in the project

**Configuration**
- Use descriptive variable names
- Group related configurations logically
- Document configuration options
- Provide sensible defaults where possible

**Testing**
- Add tests for all new models
- Use appropriate dbt test types (not_null, unique, relationships, accepted_values)
- Include custom tests for business logic
- Test edge cases and error conditions

**Documentation**
- Document all models and columns in schema.yml files
- Use clear, concise descriptions
- Include examples where helpful
- Reference FOCUS specification when relevant

### Submitting Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/azure-support
   # or: git checkout -b fix/billing-period-mapping
   ```

2. **Make your changes**
   - Follow the guidelines above
   - Test thoroughly
   - Update documentation

3. **Run quality checks**
   ```bash
   dbt run --target dev
   dbt test --target dev
   dbt compile  # check for syntax errors
   ```

4. **Commit with clear messages**
   ```bash
   git commit -m "Add Azure Cost Management staging models

   - Create stg_azure_billing model with comprehensive column mappings
   - Add Azure-specific configuration variables
   - Include data quality tests and documentation
   - Support for EA, MCA, and CSP billing account types"
   ```

5. **Submit a pull request**
   - Provide a clear description of changes
   - Reference any related issues
   - Include testing instructions
   - Request review from maintainers

## Testing Guidelines

### Unit Testing
- Test individual model transformations
- Validate column mappings and data types
- Check null handling and edge cases

### Integration Testing
- Test end-to-end FOCUS transformations
- Validate against sample billing data
- Check multi-provider scenarios

### Data Quality Testing
- Use dbt tests for data validation
- Include business rule tests
- Test with real-world data volumes

## Documentation

### Model Documentation
- Document purpose and business logic
- Describe column mappings and transformations
- Include usage examples and caveats

### Configuration Documentation
- Document all configuration variables
- Provide setup examples
- Explain customization options

### User Documentation
- Update README for new features
- Add configuration examples
- Include troubleshooting guides

## Community

### Getting Help
- [GitHub Discussions](https://github.com/JGrubb/dbt-focus/discussions) for questions
- [GitHub Issues](https://github.com/JGrubb/dbt-focus/issues) for bug reports
- Reference the [FOCUS specification](https://focus.finops.org/) for standards questions

### Code of Conduct
- Be respectful and inclusive
- Help others learn and contribute
- Focus on constructive feedback
- Follow open source best practices

## Release Process

### Versioning
- Follow semantic versioning (MAJOR.MINOR.PATCH)
- MAJOR: Breaking changes to configuration or output schema
- MINOR: New cloud providers or FOCUS features
- PATCH: Bug fixes and documentation updates

### Release Notes
- Document breaking changes clearly
- Include migration instructions
- Highlight new features and improvements
- Credit contributors

## Recognition

Contributors will be recognized in:
- Release notes and changelogs
- README acknowledgments
- Project documentation

Thank you for helping make FOCUS transformations accessible to the entire FinOps community!

---

For questions about contributing, please open a [GitHub Discussion](https://github.com/JGrubb/dbt-focus/discussions) or reach out to the maintainers.