# Terraform IAM Identity Baseline – Run Guide

This document describes how to run Terraform for the IAM identity baseline example contained in this repository.

It covers: directory context, Terraform initialization, plan review, apply execution, validation, and cleanup.

This guide assumes the Terraform configuration already exists in the repository.

---

## Requirements

Before running Terraform:

- Terraform version 1.5 or newer must be installed
- AWS credentials must be configured (SSO or short-lived credentials recommended)
- You must have permission to create IAM roles and IAM policies
- Do not run this example in a production account

---

## Directory Context

All Terraform commands must be executed from the following directory:

```
cd terraform/examples/identity-baseline
```

Verify location:

```
pwd
```

Expected output should end with:

```
terraform/examples/identity-baseline
```

---

## Terraform Initialization

Initialize the Terraform working directory and providers:

```
terraform init
```

This command must be run:
- before the first plan or apply
- after upgrading Terraform
- after removing the `.terraform` directory

---

## Required Variable Values

You must substitute the following placeholders in the commands below:

- `<ACCOUNT_ID>` – AWS account number
- `<TRUSTED_ROLE>` – trusted principal role ARN (commonly an SSO role)
- `<OIDC_PROVIDER_HOSTPATH>` – OIDC provider host/path (no `https://`)
- `<MFA_NAME>` – MFA device name for break-glass access

---

## Terraform Plan

Always generate and review a plan before applying changes.

```
terraform plan \
  -var="human_trusted_principal_arn=arn:aws:iam::<ACCOUNT_ID>:role/<TRUSTED_ROLE>" \
  -var="oidc_provider_arn=arn:aws:iam::<ACCOUNT_ID>:oidc-provider/<OIDC_PROVIDER_HOSTPATH>" \
  -var="oidc_provider_url=<OIDC_PROVIDER_HOSTPATH>" \
  -var="k8s_namespace=default" \
  -var="k8s_service_account=app-sa" \
  -var="break_glass_mfa_serial_arn=arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_NAME>"
```

During review, confirm:
- only IAM roles and IAM policies are planned
- permission boundaries are attached where expected
- no IAM users or access keys are created
- trust policies do not use wildcard principals

---

## Terraform Apply

Apply the configuration only after reviewing the plan:

```
terraform apply \
  -var="human_trusted_principal_arn=arn:aws:iam::<ACCOUNT_ID>:role/<TRUSTED_ROLE>" \
  -var="oidc_provider_arn=arn:aws:iam::<ACCOUNT_ID>:oidc-provider/<OIDC_PROVIDER_HOSTPATH>" \
  -var="oidc_provider_url=<OIDC_PROVIDER_HOSTPATH>" \
  -var="k8s_namespace=default" \
  -var="k8s_service_account=app-sa" \
  -var="break_glass_mfa_serial_arn=arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_NAME>"
```

When prompted, type `yes` to confirm.

On success, Terraform will output:
- human role ARN
- workload (IRSA) role ARN
- break-glass role ARN

---

## Outputs

To view Terraform outputs after apply:

```
terraform output
```

---

## Optional Validation

Optional validation using AWS CLI:

```
aws sts get-caller-identity
```

Validation should be read-only and must not modify resources.

---

## Terraform Destroy

When finished, remove all resources created by this example:

```
terraform destroy \
  -var="human_trusted_principal_arn=arn:aws:iam::<ACCOUNT_ID>:role/<TRUSTED_ROLE>" \
  -var="oidc_provider_arn=arn:aws:iam::<ACCOUNT_ID>:oidc-provider/<OIDC_PROVIDER_HOSTPATH>" \
  -var="oidc_provider_url=<OIDC_PROVIDER_HOSTPATH>" \
  -var="k8s_namespace=default" \
  -var="k8s_service_account=app-sa" \
  -var="break_glass_mfa_serial_arn=arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_NAME>"
```

Confirm destruction when prompted.

Expected result:
- all IAM roles and policies created by the example are removed
- Terraform reports successful destruction

---

## Execution Notes

- Always run `terraform plan` before `terraform apply`
- Use short-lived AWS credentials whenever possible
- Treat IAM changes as security-sensitive
- Destroy example resources when testing is complete

