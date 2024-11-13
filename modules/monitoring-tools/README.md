<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.22.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_channels"></a> [channels](#input\_channels) | Channel variable that contains `error` and `warn` as keys | `map(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of Google Cloud Platform. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The token required for notifications to Slack.<br>    The variable is required for monitoring. | `string` | n/a | yes |
| <a name="input_target"></a> [target](#input\_target) | The target information for monitoring.<br>    `base_value` is used to calculate a numeric value based on the target resource.<br>    Specifically, it is used to obtain a percentage, as in `floor(base_value * threshold.value)`. | <pre>object({<br>    title         = string<br>    metric        = string<br>    resource_type = string<br>    label         = string<br>    name          = string<br>    filter        = string<br>    reducer       = string<br>    aligner       = string<br>    base_value    = optional(number, 1)<br>    threshold = map(<br>      object({<br>        value  = number<br>        window = string<br>      })<br>    )<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list. |
| <a name="output_policies"></a> [policies](#output\_policies) | Alert policies name object. |
<!-- END_TF_DOCS -->