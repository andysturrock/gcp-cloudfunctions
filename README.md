# GCP Cloud Functions V2 - TypeScript & Terraform

This project provides a boilerplate for developing and deploying **Google Cloud Functions (V2)** using **TypeScript** and **Terraform**.

## Features

- **TypeScript**: Modern development experience with strongly typed code.
- **Node.js 22**: Configured to run on the latest Long Term Support (LTS) runtime.
- **Terraform**: Infrastructure-as-code for consistent and repeatable deployments.
- **Automated Bundling**: A custom build script (`src/build.js`) packages the compiled JavaScript and dependencies into a ZIP file ready for deployment.

## Project Structure

- `src/`: Contains the Cloud Function source code.
    - `ts-src/`: TypeScript source files.
    - `build.js`: Custom script to zip the function code and modules.
- `terraform/`: Terraform configurations to provision the GCP resources (Bucket, Storage Object, and Cloud Function).

## Getting Started

### Prerequisites

- Node.js 22
- Terraform
- Google Cloud SDK (authenticated)

### Development

1.  **Install dependencies**:
    ```bash
    cd src
    npm install
    ```

2.  **Build the project**:
    This compiles the TypeScript and creates `dist/function-source.zip`.
    ```bash
    npm run build
    ```

### Deployment

1.  **Initialize Terraform**:
    ```bash
    cd terraform
    terraform init
    ```

2.  **Deploy**:
    ```bash
    terraform apply -var="project=YOUR_PROJECT_ID" -var="region=YOUR_REGION"
    ```

## Usage

Once deployed, the function will return a "Hello World" message. You can pass a name parameter:
- `https://[FUNCTION_URL]/?name=YourName`