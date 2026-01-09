# 🔐 AWS IAM Security Patterns

Identity is the **primary security boundary** in cloud environments.

This repository documents **security-first IAM design patterns** for **Amazon Web Services (AWS)**, focused on **least privilege, auditability, and operational survivability** — not convenience or speed.

It is intended for:

- Cloud security engineers  
- Platform security teams  
- ISSOs and compliance-focused practitioners  
- Engineers transitioning from traditional infrastructure security to cloud  

---

## 🚀 Start Here

**Choose your path depending on your goal:**

- **Understand IAM security concepts and design decisions**  
  → `docs/`

- **Deploy a runnable IAM identity baseline (Terraform)**  
  → `TERRAFORM_IDENTITY_BASELINE_RUN_GUIDE.md`

- **Review Terraform implementation patterns**  
  → `terraform/`

This repository is designed to be **read first, executed second**.

---

## 🎯 Purpose

This repository demonstrates **how to design and operate IAM securely**
in real-world cloud environments by explicitly separating:

- Human access  
- Workload identity  
- Trust relationships  
- Privilege boundaries  
- Emergency (break-glass) access  

All patterns emphasize:

- Explicit trust  
- Minimal privilege  
- Clear blast-radius containment  
- Audit readiness  

---

## 🧠 Design Principles

- **Identity is the perimeter**  
- **Deny by default**  
- **Humans and workloads are not interchangeable**  
- **Trust policies are security controls**  
- **Auditability is a feature, not an afterthought**  
- **Emergency access must exist — and must be controlled**  

---

## 🔑 Core Identity Domains

### 👤 Human Identity
- Role-based access (no standing admin users)
- Session duration control
- Explicit permission boundaries
- MFA-enforced access patterns

Implemented in:
- `terraform/humans/`

---

### ⚙️ Workload Identity
- EC2 instance roles
- IAM Roles for Service Accounts (IRSA)
- Narrow, explicit trust relationships
- No static credentials

Implemented in:
- `terraform/workloads/`

---

### 🧱 Guardrails
- Deny-by-default policy patterns
- Mandatory logging and enforcement
- Explicit service access constraints

Implemented in:
- `terraform/guardrails/`

---

### 🚨 Emergency (Break-Glass) Access
- Predefined emergency roles
- Strong authentication requirements
- Logging and alerting
- Manual, deliberate activation

Implemented in:
- `terraform/break-glass/`

---

## 📚 Documentation Map

Conceptual and security rationale documents live in `docs/` and are best read in the following order:

| Document | Purpose |
|--------|--------|
| `human-vs-workload-identity.md` | Prevent common privilege mistakes |
| `identity-boundaries.md` | Define blast-radius control through identity |
| `iam-policy-design.md` | Write policies humans can reason about |
| `permission-boundaries.md` | Enforce least privilege at scale |
| `break-glass-access.md` | Survive outages without violating controls |
| `common-iam-failures.md` | Learn from real-world mistakes |
| `audit-and-rmf-considerations.md` | Map IAM to audit & compliance expectations |

---

## 🛠️ Infrastructure as Code Approach

All examples use **Terraform** and intentionally follow strict rules:

- No wildcard trust relationships  
- No unmanaged IAM policies  
- No static credentials  
- Explicit separation of identity domains  

Terraform in this repository is **illustrative and security-focused** — not copy-paste production modules.

---

## 🧩 Runnable Example: Identity Baseline

A composed, runnable example is provided under:

```
terraform/examples/identity-baseline/
```

This example demonstrates how the documented patterns can be combined into a **cohesive IAM identity baseline**, suitable for lab environments, security review, or controlled internal testing.

Deployment instructions are provided in:

- `TERRAFORM_IDENTITY_BASELINE_RUN_GUIDE.md`

---

## 🧠 Relationship to Other Repositories

This repository is intended to complement a broader cloud security learning path, including:

- AWS Cloud Security Foundations — baseline AWS security concepts  
- AWS EKS Secure Foundations — workload identity via IRSA  
- Secure IaC Foundations — change control and guardrails  
- RMF Operational Playbooks — audit and compliance alignment  

Together, these repositories demonstrate **end-to-end cloud identity and security competence**.

---

## ⚠️ What This Repository Is Not

- Not a certification cram guide  
- Not a GUI walkthrough  
- Not a multi-cloud abstraction  
- Not an application development example  

The goal is **security clarity and reasoning**, not feature coverage.

---

## 📌 Disclaimer

Examples are intentionally minimal and security-focused.  
They must be reviewed, adapted, and approved before use in any production environment.
