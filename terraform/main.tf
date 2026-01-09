terraform {
  required_providers {
    google = "~> 6.0"
  }
}

variable "project" {
  type = string
  description = "GCP project ID"
}

variable "region" {
  type = string
  description = "GCP region"
}

provider google {
  project = var.project
  region = var.region
}

provider "google-beta" {
   project = var.project
}

resource "google_storage_bucket" "bucket" {
  name     = "${var.project}-gcf-source"  # Every bucket name must be globally unique
  location = "EU"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "source_zip" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "../src/dist/function-source.zip"  # Add path to the zipped function source code
}

resource "google_cloudfunctions2_function" "hello" {
  provider = google-beta
  name = "function-v2-example"
  location = "europe-west2"
  description = "Hello World function"

  build_config {
    runtime = "nodejs22"
    entry_point = "helloHttp"  # Set the entry point 
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.source_zip.name
      }
    }
  }

  service_config {
    max_instance_count  = 1
    available_memory    = "256M"
    timeout_seconds     = 60
  }
}

output "function_uri" { 
  value = google_cloudfunctions2_function.hello.service_config[0].uri
}