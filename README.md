# 🔐 AWS IAM Security Patterns

Identity is the **primary security boundary** in cloud environments.

This repository documents **security-first IAM design patterns** for
Amazon Web Services, focused on **least privilege, auditability, and
operational survivability** — not convenience or speed.

It is intended for:
- Cloud security engineers
- Platform security teams
- ISSOs and compliance-focused practitioners
- Engineers transitioning from traditional infrastructure security to cloud

---

## 🎯 Purpose

This repository demonstrates **how to design and operate IAM securely**
in real-world cloud environments by separating:

- Human access
- Workload identity
- Trust relationships
- Privilege boundaries
- Emergency access

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
- **Emergency access must exist — and be controlled**

---

## 🔑 Core Identity Domains

### 👤 Human Identity
- Federated access (SSO)
- Role-based access
- Session duration control
- Explicit permission boundaries

### ⚙️ Workload Identity
- Instance roles
- IAM Roles for Service Accounts (IRSA)
- Narrow trust relationships
- No static credentials

### 🧱 Guardrails
- Deny-by-default patterns
- Mandatory logging
- Explicit service access constraints

### 🚨 Emergency (Break-Glass)
- Predefined emergency roles
- Strong authentication requirements
- Logging and alerting
- Manual, deliberate activation

---

## 📚 Documentation Map

| Document | Purpose |
|--------|--------|
| identity-boundaries.md | Define blast-radius control through identity |
| human-vs-workload-identity.md | Prevent common privilege mistakes |
| iam-policy-design.md | Write policies humans can reason about |
| permission-boundaries.md | Enforce least privilege at scale |
| break-glass-access.md | Survive outages without violating controls |
| audit-and-rmf-considerations.md | Map IAM to compliance expectations |
| common-iam-failures.md | Learn from real-world mistakes |

---

## 🛠️ Infrastructure as Code

All examples use **Terraform** and follow these rules:

- No wildcard trust relationships
- No unmanaged policies
- No static credentials
- Explicit separation of identity domains

Terraform examples are **illustrative**, not drop-in production modules.

---

## 🧩 Relationship to Other Repositories

This repository complements:

- **AWS Cloud Security Foundations** — baseline AWS security concepts
- **AWS EKS Secure Foundations** — workload identity via IRSA
- **Secure IaC Foundations** — change control and guardrails
- **RMF Operational Playbooks** — compliance and audit alignment

Together, these repositories demonstrate **end-to-end cloud security competence**.

---

## ⚠️ What This Repository Is Not

- Not a certification cram guide
- Not a GUI walkthrough
- Not a multi-cloud abstraction
- Not an app development example

The goal is **security clarity**, not feature coverage.

---

## 🔎 Recruiter Signal

This repository answers one question clearly:

> *“Does this person understand identity as the foundation of cloud security?”*

---

## 📌 Disclaimer

Examples are intentionally minimal and security-focused.
They must be adapted and reviewed before use in production environments.


