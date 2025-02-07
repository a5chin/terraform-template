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
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_vpc_access_connector.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vpc_access_connector) | resource |
| [google_cloud_run_v2_service.backend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |
| [google_cloud_run_v2_service.frontend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |
| [google_cloud_run_v2_service_iam_member.backend_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_cloud_run_v2_service_iam_member.frontend_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_compute_global_address.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_project_iam_member.backend_executor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.frontend_executor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.backend_executor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.backend_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.frontend_executor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_networking_connection.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend"></a> [backend](#input\_backend) | The backend settings | <pre>object({<br/>    name               = string<br/>    image              = string<br/>    max_instance_count = optional(number, 1)<br/>    min_instance_count = optional(number, 0)<br/>    concurrency        = optional(number, 80)<br/>    timeout_seconds    = optional(number, 60)<br/>    cpu                = optional(string, "1000m")<br/>    memory             = optional(string, "1024Mi")<br/>    env = object({<br/>      HOSTNAME   = string<br/>      DB_USER    = string<br/>      DB_PWD     = string<br/>      DB_NAME    = string<br/>      DB_TCPHOST = string<br/>      DB_PORT    = number<br/>    })<br/>    executor = object({<br/>      id = string<br/>      roles = optional(<br/>        set(string), [<br/>          "roles/cloudsql.client",<br/>          "roles/cloudtrace.agent",<br/>        ]<br/>      )<br/>    })<br/>    invoker = object({<br/>      ids = set(string)<br/>      emails = optional(<br/>        set(string), []<br/>      )<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_db"></a> [db](#input\_db) | The Cloud SQL settings | <pre>object({<br/>    instance_name = string<br/>    database_name = string<br/>    version       = optional(string, "db-f1-micro")<br/>    charset       = optional(string, "utf8mb4")<br/>    collation     = optional(string, "utf8mb4_unicode_ci")<br/>  })</pre> | n/a | yes |
| <a name="input_frontend"></a> [frontend](#input\_frontend) | The frontend settings | <pre>object({<br/>    name               = string<br/>    image              = string<br/>    max_instance_count = optional(number, 1)<br/>    min_instance_count = optional(number, 0)<br/>    concurrency        = optional(number, 80)<br/>    timeout_seconds    = optional(number, 60)<br/>    cpu                = optional(string, "1000m")<br/>    memory             = optional(string, "1024Mi")<br/>    executor = object({<br/>      id = string<br/>      roles = optional(<br/>        set(string), [<br/>          "roles/cloudtrace.agent",<br/>        ]<br/>      )<br/>    })<br/>    invoker = object({<br/>      ids = set(string)<br/>      emails = optional(<br/>        set(string), []<br/>      )<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of Google Cloud Platform. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_apis"></a> [enabled\_apis](#output\_enabled\_apis) | Already enabled APIs list |
<!-- END_TF_DOCS -->