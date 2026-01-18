# Documentation Index

This directory contains the conceptual and security-rationale documents that explain **why** the Terraform patterns in this repository are structured the way they are.

If you only read a few documents, start with the first three in the “Recommended Reading Order”.

---

## Recommended Reading Order (Most People)

1. **Human vs Workload Identity** — `human-vs-workload-identity.md`  
   Establishes the core separation that prevents the most common IAM failures.

2. **Identity Boundaries** — `identity-boundaries.md`  
   Explains blast-radius containment using identity as the boundary.

3. **IAM Policy Design** — `iam-policy-design.md`  
   Practical guidance for writing policies that humans can reason about and auditors can review.

4. **Permission Boundaries** — `permission-boundaries.md`  
   How to enforce least privilege at scale and prevent privilege creep.

5. **Break-Glass Access** — `break-glass-access.md`  
   How to design emergency access that is survivable, controlled, and reviewable.

6. **Common IAM Failures** — `common-iam-failures.md`  
   Real-world failure modes and how the patterns in this repo avoid them.

7. **Audit & RMF Considerations** — `audit-and-rmf-considerations.md`  
   How these patterns support auditability and RMF-style risk management expectations.

---

## Reading Paths

### For Security Engineers
- `human-vs-workload-identity.md`
- `iam-policy-design.md`
- `permission-boundaries.md`
- `common-iam-failures.md`

### For Platform / DevOps Engineers
- `human-vs-workload-identity.md`
- `identity-boundaries.md`
- `break-glass-access.md`

### For ISSOs / Auditors / Compliance Reviewers
- `audit-and-rmf-considerations.md`
- `identity-boundaries.md`
- `permission-boundaries.md`
- `break-glass-access.md`

---

## How These Docs Map to Terraform

These documents describe the intent behind the Terraform implementation:

- **Humans** → `../terraform/humans/`
- **Workloads** → `../terraform/workloads/`
- **Guardrails** → `../terraform/guardrails/`
- **Break-glass** → `../terraform/break-glass/`
- **Runnable baseline example** → `../terraform/examples/identity-baseline/`  
  (Execution guide: `../TERRAFORM_IDENTITY_BASELINE_RUN_GUIDE.md`)

---

## Conventions Used in This Repo

- **Humans** authenticate via SSO / federated identity and **assume roles**.
- **Workloads** use **roles** (instance profiles, IRSA) and do **not** use static credentials.
- **Trust policies** are treated as **security controls**, not boilerplate.
- **Permission boundaries** are used to contain blast radius and reduce audit risk.
- **Break-glass** access exists by design and is intentionally controlled.

---

## Document List (Alphabetical)

- `audit-and-rmf-considerations.md`
- `break-glass-access.md`
- `common-iam-failures.md`
- `human-vs-workload-identity.md`
- `iam-policy-design.md`
- `identity-boundaries.md`
- `permission-boundaries.md`
