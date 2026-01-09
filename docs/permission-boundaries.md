# Permission Boundaries in AWS IAM

Permission boundaries are a **preventive security control** used to limit the
maximum permissions an IAM role or user can ever obtain, regardless of how
its attached policies change over time.

They are not a convenience feature.  
They exist to **contain blast radius**, **prevent privilege escalation**, and
**enforce organizational intent** in environments where IAM configuration
changes are frequent.

---

## 1. What a Permission Boundary Is

A permission boundary is an IAM policy that defines the **upper limit**
of permissions an identity can exercise.

Effective permissions are calculated as:

> **Allowed actions = (Identity policies) ∩ (Permission boundary)**

If an action is not allowed by the boundary, it is denied — even if explicitly
granted elsewhere.

Permission boundaries do **not** grant access on their own.
They only constrain what can be granted.

---

## 2. Why Permission Boundaries Are Necessary

In real environments, IAM policies evolve continuously:
- Roles are reused
- Policies are modified
- Teams change
- Automation introduces configuration drift

Without boundaries, a single misconfigured policy can result in:
- Privilege escalation
- Lateral movement
- Unintended administrative access

Permission boundaries exist to **make certain failures non-catastrophic**.

---

## 3. Boundary vs Policy vs SCP

| Mechanism | Purpose | Scope |
|--------|-------|------|
| Identity Policy | Grants permissions | Role / user |
| Permission Boundary | Limits permissions | Role / user |
| SCP | Limits permissions | Account / OU |

Boundaries are most effective when used **in combination** with SCPs:
- SCPs enforce coarse-grained organizational rules
- Boundaries enforce fine-grained role-level limits

---

## 4. When to Use Permission Boundaries

Permission boundaries are strongly recommended for:

- Human-access roles
- Delegated administrative roles
- CI/CD roles
- Roles created by automation
- Any role that can attach or modify policies

They are especially valuable when IAM role creation is **not centrally controlled**.

---

## 5. Human Identity Boundaries

For human-access roles, boundaries should:
- Prevent IAM administration unless explicitly required
- Block role creation or policy attachment by default
- Restrict access to sensitive services (e.g., KMS, IAM, Organizations)

This ensures humans cannot grant themselves broader access through policy changes,
even accidentally.

---

## 6. Workload Identity Boundaries

For workload roles, boundaries should:
- Restrict services to a known set
- Prevent access to IAM and identity-modifying APIs
- Block cross-account role assumption unless explicitly required

Workload boundaries help ensure that:
- Compromised workloads cannot escalate privileges
- Compromised credentials have limited impact

---

## 7. Boundary Design Principles

Effective permission boundaries share common traits:

- **Deny by default**
- Explicitly allow only required services
- Avoid wildcards in sensitive services
- Prevent IAM mutation actions unless justified
- Remain stable over time

Boundaries should change **less frequently** than identity policies.

---

## 8. Common Failure Modes

The following mistakes frequently undermine boundary effectiveness:

- Using boundaries that are too permissive
- Reusing the same boundary for unrelated roles
- Allowing IAM modification actions inside the boundary
- Treating boundaries as optional or advisory
- Applying boundaries inconsistently

A boundary that allows `iam:*` is functionally meaningless.

---

## 9. Audit and Compliance Considerations

Permission boundaries support:

- Demonstrable least privilege
- Reduced audit scope
- Stronger change control narratives
- Clear evidence of preventive controls

From an RMF perspective, boundaries directly support:
- AC (Access Control)
- CM (Configuration Management)
- IA (Identification and Authentication)

Auditors typically view boundaries as a **positive maturity indicator**
when they are documented and consistently applied.

---

## 10. Operational Guidance

- Define a small number of standardized boundaries
- Apply boundaries by default during role creation
- Monitor for roles without boundaries
- Review boundaries during security assessments
- Document boundary intent and ownership

Permission boundaries are most effective when treated as
**security infrastructure**, not optional configuration.

---

## 11. Design Summary

| Principle | Outcome |
|--------|--------|
| Boundaries define maximum privilege | Prevents escalation |
| Policies define intent | Enables flexibility |
| Boundaries change slowly | Improves stability |
| Consistent application | Reduces risk |

---

## 12. Relationship to Other Documents

This document complements:
- `human-vs-workload-identity.md`
- `iam-policy-design.md`
- `break-glass-access.md`

Together, these patterns provide layered protection
against identity-based failure modes in AWS environments.
