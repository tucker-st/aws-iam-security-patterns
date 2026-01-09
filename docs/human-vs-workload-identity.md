# Human vs Workload Identity in AWS

Cloud security failures frequently originate from **confused or overlapping identity boundaries**.
In AWS, humans and workloads serve fundamentally different purposes and must be treated as
**distinct identity domains** with different trust, privilege, and lifecycle characteristics.

This document explains **why human and workload identities must be separated**, the risks of
conflating them, and secure design patterns for managing each.

---

## 1. Identity Domains Defined

### Human Identity
Human identities represent **people** interacting with AWS for administrative,
operational, or investigative purposes.

Characteristics:
- Interactive access
- Session-based
- Federated (SSO, IdP-backed)
- Audited per individual
- Subject to least privilege and time-bound access

Examples:
- Cloud administrators
- Security engineers
- Incident responders
- Auditors (read-only)

---

### Workload Identity
Workload identities represent **non-human systems** that require AWS access
to perform automated tasks.

Characteristics:
- Non-interactive
- Persistent or recurring
- Scoped to a specific function
- No direct login capability
- Designed to operate without human intervention

Examples:
- EC2 instances
- Kubernetes pods (IRSA)
- Lambda functions
- CI/CD pipelines

---

## 2. Why Separation Is Mandatory

Treating human and workload identities as interchangeable introduces several risks:

- **Privilege amplification**  
  Workload roles often require broader service access than any single human should have.

- **Audit ambiguity**  
  Actions cannot be reliably attributed to a person if humans can assume workload roles.

- **Credential misuse**  
  Human access patterns increase the likelihood of credential exposure when reused for automation.

- **Incident response degradation**  
  Investigations are slowed when logs do not clearly distinguish human actions from system behavior.

Identity separation is therefore both a **security control** and an **operational necessity**.

---

## 3. Human Identity Design Patterns

### Federated Access Only
Humans should access AWS exclusively through:
- SSO / identity federation
- Role assumption
- Short-lived sessions

Direct IAM users with long-lived credentials should be avoided except in narrowly
controlled break-glass scenarios.

---

### Role-Based Access
Human access should be expressed through:
- Clearly named roles
- Job-function-aligned permissions
- Explicit trust policies
- Limited session duration

Humans should **never** be granted permissions directly via inline policies
attached to identities.

---

### Permission Boundaries for Humans
Permission boundaries should be used to:
- Prevent privilege escalation
- Enforce organizational policy
- Constrain misconfigured role permissions

Boundaries are especially important in environments where roles are created
or modified frequently.

---

## 4. Workload Identity Design Patterns

### Instance Roles (EC2)
Workloads running on EC2 should use:
- Instance profiles
- Narrow service permissions
- Explicit trust policies tied to the service

Static credentials embedded in configuration files or AMIs must be avoided.

---

### IAM Roles for Service Accounts (IRSA)
Kubernetes workloads should use IRSA to:
- Bind AWS permissions to Kubernetes service accounts
- Avoid node-wide credential exposure
- Enforce least privilege at the pod level

IRSA trust policies should:
- Reference a specific OIDC provider
- Scope access to a single namespace and service account
- Avoid wildcard conditions

---

### No Human Assumption of Workload Roles
Humans should not assume workload roles for:
- Debugging
- Testing
- Convenience

If human inspection is required, create a **separate, read-only inspection role**
with equivalent visibility but without execution permissions.

---

## 5. Common Failure Modes

The following patterns frequently appear in incident reviews:

- Humans assuming workload roles during troubleshooting
- Shared roles used by both CI/CD pipelines and administrators
- Overly broad trust policies (`"*"` principals)
- Workloads using credentials originally issued to humans
- Long-lived sessions for identities that should be ephemeral

Each of these failures collapses identity boundaries and increases blast radius.

---

## 6. Audit and Compliance Considerations

Clear separation between human and workload identity supports:

- Accurate attribution of actions
- Reduced scope during incident investigations
- Stronger evidence for auditors
- Cleaner POA&M development

From an RMF perspective, identity separation directly supports:
- AC (Access Control)
- IA (Identification and Authentication)
- AU (Audit and Accountability)

---

## 7. Design Summary

| Principle | Rationale |
|---------|-----------|
| Separate human and workload identities | Prevents privilege confusion |
| Federate all human access | Improves auditability |
| Use short-lived credentials | Limits exposure |
| Scope workload trust narrowly | Reduces blast radius |
| Never reuse identities | Preserves accountability |

---

## 8. Relationship to Other Patterns

This document should be read alongside:
- `iam-policy-design.md`
- `permission-boundaries.md`
- `break-glass-access.md`

Together, these patterns form a **coherent identity security model**
for cloud environments requiring strong operational and audit discipline.
