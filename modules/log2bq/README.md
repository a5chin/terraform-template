<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_table.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table) | resource |
| [google_logging_project_sink.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |
| [google_project_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigquery"></a> [bigquery](#input\_bigquery) | The bigquery settings | <pre>object({<br/>    dataset         = string<br/>    table           = string<br/>    view            = string<br/>    expiration_days = number<br/>  })</pre> | n/a | yes |
| <a name="input_logging"></a> [logging](#input\_logging) | n/a | <pre>object({<br/>    target = string<br/>    filter = string<br/>  })</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the Project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list |
<!-- END_TF_DOCS -->