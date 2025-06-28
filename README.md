# dbt-focus

A dbt package for transforming cloud billing data to the [FOCUS specification](https://focus.finops.org/) - part of the [open-finops-stack](https://github.com/JGrubb/open-finops-stack).

## Overview

This package provides data transformations to convert cloud provider billing data into the standardized FinOps Open Cost and Usage Specification (FOCUS) format. It enables consistent cost analysis and reporting across multiple cloud providers through a unified schema.

## Features

- **Configuration-driven**: Flexible column mappings to adapt to different data ingestion pipelines
- **Multi-cloud ready**: Designed for AWS, Azure, GCP, and other cloud providers `--TODO`
- **FOCUS compliant**: Transforms data to meet FOCUS specification requirements  
- **FinOps focused**: Optimized for cost visibility, allocation, and analysis use cases
- **Well documented**: Comprehensive column documentation and data quality tests

## Supported Cloud Providers

- **AWS** - Cost and Usage Report (CUR) data
- **Azure** - Coming soon
- **GCP** - Coming soon

## Installation

Add this package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/JGrubb/dbt-focus.git"
    revision: main
```

Then run:
```bash
dbt deps
```

## Configuration

### AWS Configuration

Configure your AWS billing data source in your `dbt_project.yml`:

```yaml
vars:
  aws:
    # Source table location
    billing_table: 'name_of_aws_billing_source_table'
    
    # Column mappings (customize based on your data pipeline)
    columns:
      # Core billing fields
      bill_billing_period_start_date: 'bill_billing_period_start_date'
      bill_billing_period_end_date: 'bill_billing_period_end_date'
      bill_payer_account_id: 'bill_payer_account_id'
      line_item_usage_account_id: 'line_item_usage_account_id'
      
      # Service identification
      product_servicecode: 'product_servicecode'
      product_servicename: 'product__servicename'
      
      # Cost fields
      line_item_unblended_cost: 'line_item_unblended_cost'
      line_item_currency_code: 'line_item_currency_code'
      
      # Set to null for columns not present in your data
      resource_tags: null
      # ... (see dbt_project.yml for full configuration)
```

### Source Data Setup

Define your source data in your project:

```yaml
# models/sources.yml
version: 2

sources:
  - name: aws_billing
    tables:
      - name: cur_2_0_append_parquet_unified
        description: "AWS Cost and Usage Report data"
```

## Usage

### Basic Usage

1. **Run the staging models** to standardize your cloud billing data:
   ```bash
   dbt run --select tag:staging
   ```

2. **Run FOCUS transformations** (coming soon) to generate FOCUS-compliant output:
   ```bash
   dbt run --select tag:focus
   ```

### Available Models

#### Staging Layer
- `stg_aws_billing` - Standardized AWS CUR data with consistent column names

#### FOCUS Layer (Coming Soon)
- `focus_billing_data` - FOCUS-compliant unified billing data
- `focus_*` - Additional FOCUS dimension and fact tables

## Column Mappings

The package uses a flexible configuration system to map your source columns to standardized names. Key AWS CUR fields include:

| FOCUS Concept | AWS CUR Field | Configuration Key |
|---------------|---------------|-------------------|
| Billing Period | `bill_billing_period_start_date` | `bill_billing_period_start_date` |
| Account ID | `bill_payer_account_id` | `bill_payer_account_id` |
| Service Name | `product__servicename` | `product_servicename` |
| Cost Amount | `line_item_unblended_cost` | `line_item_unblended_cost` |
| Currency | `line_item_currency_code` | `line_item_currency_code` |

See the [full configuration](dbt_project.yml) for all available mappings.

## Data Quality

The package includes comprehensive data quality tests:

- **Not null checks** on critical fields
- **Accepted values** for categorical fields
- **Referential integrity** between related tables
- **Custom business logic** validation

Run tests with:
```bash
dbt test
```

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Raw Billing   │    │   Staging Layer  │    │  FOCUS Layer    │
│   Data Sources  │ -> │  (Standardized)  │ -> │  (Compliant)    │
│  (AWS, Azure,   │    │                  │    │                 │
│   GCP, etc.)    │    │  - stg_aws_*     │    │  - focus_*      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Contributing

We welcome contributions! Please see our [contributing guidelines](CONTRIBUTING.md) for details on:

- Adding new cloud providers
- Extending FOCUS coverage
- Improving data quality tests
- Documentation improvements

## Related Projects

- [open-finops-stack](https://github.com/JGrubb/open-finops-stack) - Complete open-source FinOps platform
- [FOCUS Specification](https://focus.finops.org/) - Official FOCUS documentation
- [FinOps Foundation](https://www.finops.org/) - FinOps best practices and community

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- [Report issues](https://github.com/JGrubb/dbt-focus/issues)
- [Read the docs](https://focus.finops.org/)

---

Built with ❤️ for the FinOps community