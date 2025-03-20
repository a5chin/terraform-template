<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.4.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.7.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 6.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service_iam_member.scheduler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_cloud_scheduler_job.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_cloudfunctions2_function.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_project_iam_member.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.scheduler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [archive_file.functions](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_functions"></a> [functions](#input\_functions) | The config for the Cloud Run Functions | <pre>object({<br/>    name                             = string<br/>    bucket                           = string<br/>    runtime                          = optional(string, "python312")<br/>    entry_point                      = optional(string, "http_handler")<br/>    max_instance_count               = optional(number, 1)<br/>    min_instance_count               = optional(number, 0)<br/>    available_memory                 = optional(string, "256M")<br/>    timeout_seconds                  = optional(number, 60)<br/>    max_instance_request_concurrency = optional(number, 80)<br/>    available_cpu                    = optional(string, "1")<br/>    sa = object({<br/>      id    = string<br/>      roles = optional(set(string), [])<br/>    })<br/>    environment_variables = optional(<br/>      map(string), {<br/>        "LOG_EXECUTION_ID" = true<br/>      }<br/>    )<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the Cloud Scheduler | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the Project | `string` | n/a | yes |
| <a name="input_scheduler"></a> [scheduler](#input\_scheduler) | The config for the Cloud Scheduler | <pre>object({<br/>    name      = string<br/>    schedule  = string<br/>    time_zone = optional(string, "Asia/Tokyo")<br/>    body      = optional(map(string), {})<br/>    sa = object({<br/>      id = string<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list |
<!-- END_TF_DOCS -->