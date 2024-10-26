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
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.22.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service_identity) | resource |
| [google_cloud_run_v2_service_iam_member.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_cloudfunctions2_function.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_compute_network.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_iam_member.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.data](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_object.functions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [archive_file.functions](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dataflow"></a> [dataflow](#input\_dataflow) | The Dataflow parameters | <pre>object({<br/>    dataflow = object({<br/>      name              = string<br/>      gcsPath           = optional(string, "gs://dataflow-templates/2024-01-30-01_RC00/GCS_Avro_to_Cloud_Spanner")<br/>      temp_gcs_location = string<br/>      parameters = object({<br/>        instanceId = string<br/>        databaseId = string<br/>        inputDir   = string<br/>        subnetwork = string<br/>      })<br/>      sa = object({<br/>        id = string<br/>      })<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_functions"></a> [functions](#input\_functions) | The Cloud Functions parameter for creating Dataflow jobs,<br/>    using gcsPath as the Google-provided template available in the public GCS bucket | <pre>object({<br/>    name                             = string<br/>    bucket                           = string<br/>    max_instance_count               = optional(number, 1)<br/>    min_instance_count               = optional(number, 0)<br/>    available_memory                 = optional(string, "512Mi")<br/>    timeout_seconds                  = optional(number, 60)<br/>    max_instance_request_concurrency = optional(number, 80)<br/>    available_cpu                    = optional(number, 1)<br/>    sa = object({<br/>      id = string<br/>    })<br/>    event = object({<br/>      sa = object({<br/>        id = string<br/>      })<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_gcs"></a> [gcs](#input\_gcs) | The GCS parameters to receive aggregate data | <pre>object({<br/>    lifecycle_rule = object({<br/>      age    = number<br/>      action = string<br/>    })<br/>  })</pre> | <pre>{<br/>  "lifecycle_rule": {<br/>    "action": "Delete",<br/>    "age": 90<br/>  }<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the Dataflow | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the Project | `string` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | Service account for the resource storing the data | <pre>object({<br/>    sa = object({<br/>      email = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Settings for VPC | <pre>object({<br/>    network = object({<br/>      name = string<br/>    })<br/>    subnetwork = object({<br/>      name          = string<br/>      ip_cidr_range = string<br/>    })<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataflow"></a> [dataflow](#output\_dataflow) | Configs of Dataflow |
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list. |
| <a name="output_functions"></a> [functions](#output\_functions) | Configs of Cloud Functions |
<!-- END_TF_DOCS -->
