[![Build and Deploy to Azure Functions](https://github.com/Latzox/crc-backend/actions/workflows/build-and-deploy-pipeline.yml/badge.svg)](https://github.com/Latzox/crc-backend/actions/workflows/build-and-deploy-pipeline.yml)

# Cloud Resume Challenge - Backend

This repository contains the backend code for the Cloud Resume Challenge using Azure Functions.

## Project Overview

The Cloud Resume Challenge is a hands-on project to demonstrate your skills in cloud computing. For more details, visit the [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/azure/).

This project is divided into three repositories:
- [crc-frontend](https://github.com/latzox/crc-frontend): Contains the frontend code.
- [crc-backend](https://github.com/latzox/crc-backend): Contains the backend code.
- [crc-deploy](https://github.com/latzox/crc-deploy): Contains the infrastructure as code.

## Structure

- `function_app.py`: The main function app code.
- `host.json`: Configuration file for the function app.
- `requirements.txt`: Python dependencies required for the function app.

## Deployment

Instructions for deploying the function app to Azure using Azure Functions Core Tools.

1. **Login to Azure:**

    ```bash
    az login
    ```

2. **Create a new function app in Azure:**

    ```bash
    az functionapp create --resource-group <ResourceGroupName> --consumption-plan-location <Location> --runtime python --runtime-version 3.9 --functions-version 3 --name <FunctionAppName> --storage-account <StorageAccountName>
    ```

3. **Deploy using Azure Functions Core Tools:**

    ```bash
    func azure functionapp publish <FunctionAppName>
    ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
