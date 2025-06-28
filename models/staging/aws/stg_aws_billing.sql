{{
  config(
    materialized='view'
  )
}}

with source_data as (
  select * 
  from {{ source('aws_billing', var('aws')['billing_table']) }}
),

standardized as (
  select
    -- Core billing period and account fields
    {{ map_column('aws', 'bill_billing_period_start_date') }},
    {{ map_column('aws', 'bill_billing_period_end_date') }},
    {{ map_column('aws', 'bill_payer_account_id') }},
    {{ map_column('aws', 'bill_payer_account_name') }},
    {{ map_column('aws', 'line_item_usage_account_id') }},
    {{ map_column('aws', 'bill_invoice_id') }},
    {{ map_column('aws', 'bill_invoicing_entity') }},
    {{ map_column('aws', 'bill_billing_entity') }},
    
    -- Service and resource identification
    {{ map_column('aws', 'product_servicecode') }},
    {{ map_column('aws', 'product_servicename') }},
    {{ map_column('aws', 'product_product_family') }},
    {{ map_column('aws', 'line_item_resource_id') }},
    {{ map_column('aws', 'product_region') }},
    {{ map_column('aws', 'product_region_code') }},
    {{ map_column('aws', 'product_availability_zone') }},
    {{ map_column('aws', 'product_location') }},
    
    -- Usage and timing
    {{ map_column('aws', 'line_item_usage_start_date') }},
    {{ map_column('aws', 'line_item_usage_end_date') }},
    {{ map_column('aws', 'line_item_usage_type') }},
    {{ map_column('aws', 'line_item_usage_amount') }},
    {{ map_column('aws', 'line_item_normalized_usage_amount') }},
    {{ map_column('aws', 'pricing_unit') }},
    
    -- Cost fields
    {{ map_column('aws', 'line_item_unblended_cost') }},
    {{ map_column('aws', 'line_item_unblended_rate') }},
    {{ map_column('aws', 'line_item_blended_cost') }},
    {{ map_column('aws', 'line_item_blended_rate') }},
    {{ map_column('aws', 'line_item_net_unblended_cost') }},
    {{ map_column('aws', 'pricing_public_on_demand_cost') }},
    {{ map_column('aws', 'pricing_public_on_demand_rate') }},
    {{ map_column('aws', 'line_item_currency_code') }},
    {{ map_column('aws', 'pricing_currency') }},
    
    -- Line item details
    {{ map_column('aws', 'line_item_line_item_type') }},
    {{ map_column('aws', 'line_item_line_item_description') }},
    {{ map_column('aws', 'line_item_operation') }},
    {{ map_column('aws', 'line_item_legal_entity') }},
    
    -- Reservation and Savings Plans
    {{ map_column('aws', 'reservation_reservation_a_r_n') }},
    {{ map_column('aws', 'reservation_effective_cost') }},
    {{ map_column('aws', 'reservation_amortized_upfront_cost_for_usage') }},
    {{ map_column('aws', 'reservation_amortized_upfront_fee_for_billing_period') }},
    {{ map_column('aws', 'reservation_recurring_fee_for_usage') }},
    {{ map_column('aws', 'reservation_unused_quantity') }},
    {{ map_column('aws', 'reservation_unused_recurring_fee') }},
    
    {{ map_column('aws', 'savings_plan_savings_plan_a_r_n') }},
    {{ map_column('aws', 'savings_plan_savings_plan_effective_cost') }},
    {{ map_column('aws', 'savings_plan_savings_plan_rate') }},
    {{ map_column('aws', 'savings_plan_used_commitment') }},
    {{ map_column('aws', 'savings_plan_amortized_upfront_commitment_for_billing_period') }},
    {{ map_column('aws', 'savings_plan_recurring_commitment_for_billing_period') }},
    
    -- Product details
    {{ map_column('aws', 'product_sku') }},
    {{ map_column('aws', 'product_operation') }},
    {{ map_column('aws', 'product_usagetype') }},
    {{ map_column('aws', 'product_fee_code') }},
    {{ map_column('aws', 'product_fee_description') }},
    
    -- Pricing details
    {{ map_column('aws', 'pricing_term') }},
    {{ map_column('aws', 'pricing_purchase_option') }},
    {{ map_column('aws', 'pricing_offering_class') }},
    {{ map_column('aws', 'pricing_lease_contract_length') }},
    
    -- Tags and metadata
    {{ map_column('aws', 'resource_tags') }},
    
    -- Add provider identifier for multi-cloud unification
    'aws' as provider
    
  from source_data
)

select * from standardized