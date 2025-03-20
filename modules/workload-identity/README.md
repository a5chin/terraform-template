<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pool"></a> [pool](#input\_pool) | The workload identity pool configuration. | <pre>object({<br/>    id           = string<br/>    display_name = optional(string, null)<br/>    description  = optional(string, "Managed by Terraform")<br/>  })</pre> | n/a | yes |
| <a name="input_pool_provider"></a> [pool\_provider](#input\_pool\_provider) | The workload identity pool provider configuration. | <pre>object({<br/>    id                  = optional(string, null)<br/>    display_name        = optional(string, null)<br/>    description         = optional(string, "Managed by Terraform")<br/>    attribute_condition = string<br/>    attribute_mappings = optional(<br/>      map(string), {<br/>        "google.subject" = "assertion.sub"<br/>    })<br/>    attribute_claims = optional(<br/>      set(string), []<br/>    )<br/>    issuer_uri = optional(string, "https://token.actions.githubusercontent.com")<br/>  })</pre> | n/a | yes |
| <a name="input_principals"></a> [principals](#input\_principals) | The workload identity pool provider principals. | <pre>list(<br/>    object({<br/>      service_account = string<br/>      subject         = optional(string)<br/>      group           = optional(string)<br/>      attribute = optional(object({<br/>        name  = string<br/>        value = string<br/>      }))<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID of Google Cloud Platform. | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The project number of Google Cloud Platform. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list |
| <a name="output_workload_identity_pools"></a> [workload\_identity\_pools](#output\_workload\_identity\_pools) | The ID Workload Identity Pools |
<!-- END_TF_DOCS -->