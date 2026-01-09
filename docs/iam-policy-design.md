# IAM Policy Design in AWS

IAM policies are the **mechanism by which intent is expressed** in AWS.
They define what an identity is allowed to do, under what conditions, and
within what scope.

Poorly designed policies introduce ambiguity, privilege escalation risk,
and operational fragility. Well-designed policies enable **least privilege,
auditability, and predictable behavior**, even as environments evolve.

This document outlines design principles and patterns for writing IAM policies
that support secure, operable cloud environments.

---

## 1. Policy Design Objectives

Effective IAM policy design should:

- Express **clear intent**
- Minimize privilege
- Prevent unintended expansion of access
- Support audit and investigation
- Remain understandable over time

Policies should be written for **humans to reason about**, not merely
for systems to enforce.

---

## 2. Types of IAM Policies

AWS supports multiple policy mechanisms, each serving a distinct purpose:

| Policy Type | Purpose |
|------------|---------|
| Identity-based policies | Grant permissions to identities |
| Resource-based policies | Control access to specific resources |
| Permission boundaries | Limit maximum permissions |
| Service control policies (SCPs) | Enforce organizational constraints |

Policy design must account for how these mechanisms **interact**, not
treat them in isolation.

---

## 3. Separation of Intent and Constraint

A core design principle is separating:
- **Intent** — what the role is meant to do
- **Constraint** — what the role must never do

Intent is expressed through identity and resource policies.  
Constraint is enforced through permission boundaries and SCPs.

This separation ensures:
- Policies can evolve without violating security posture
- Misconfigurations are contained
- Reviews are simpler and more reliable

---

## 4. Role-Centric Policy Design

Policies should be attached to **roles**, not users.

Role-centric design enables:
- Federated human access
- Workload identity
- Session-based credentials
- Centralized trust management

Roles should be:
- Narrowly scoped
- Purpose-specific
- Clearly named
- Versioned through Infrastructure as Code

---

## 5. Least Privilege as an Ongoing Process

Least privilege is not a one-time configuration.

Effective approaches include:
- Start with minimal permissions
- Observe required actions through logging
- Iteratively refine policies
- Remove unused permissions

Policies should avoid speculative permissions added “just in case”.

---

## 6. Use of Conditions

Conditions are one of the most powerful — and underused — policy tools.

Common condition patterns include:
- Restricting access by region
- Limiting access to specific VPC endpoints
- Enforcing encryption requirements
- Binding access to specific resource tags

Conditions allow policies to be **precise without being verbose**.

---

## 7. Avoiding Wildcards

Wildcards (`*`) significantly increase risk when used indiscriminately.

Guidelines:
- Avoid wildcards in sensitive services (IAM, KMS, Organizations)
- Prefer action-level granularity where feasible
- Use wildcards only when scope is already constrained by conditions

When wildcards are required, document why.

---

## 8. Policy Size and Readability

IAM policies have size limits, but readability is the more important constraint.

Policies should:
- Be modular
- Group related actions
- Avoid duplication
- Include comments when intent is non-obvious

If a policy cannot be understood during an incident, it is operationally deficient.

---

## 9. Policy Versioning and Change Control

Policy changes should be treated as **security-relevant configuration changes**.

Recommended practices:
- Manage policies via Infrastructure as Code
- Require review for changes
- Version policies explicitly
- Track rationale for permission additions

Change history is often as important as the policy itself.

---

## 10. Interaction with Permission Boundaries

Policies should be written assuming:
- Boundaries are always present
- Boundaries may be more restrictive than intended permissions

Designing policies with boundaries in mind prevents unexpected denials
and reinforces defense-in-depth.

---

## 11. Break-Glass Policy Considerations

Policies attached to break-glass roles should:
- Be minimal but sufficient for recovery
- Exclude routine operational permissions
- Be reviewed separately from normal roles
- Change infrequently

Break-glass policies are **exception-handling tools**, not general-purpose roles.

---

## 12. Common Policy Design Failures

Frequent issues observed in policy reviews include:
- Overly broad permissions
- Accumulated permissions without justification
- Mixed human and workload permissions
- Lack of conditions
- Policies that implicitly grant administrative access

Each of these failures increases blast radius and complicates audits.

---

## 13. Audit and Compliance Considerations

From an audit perspective, well-designed policies:
- Clearly map permissions to job functions
- Support evidence collection
- Reduce scope during reviews
- Simplify incident investigation

From an RMF perspective, policy design supports:
- AC (Access Control)
- CM (Configuration Management)
- AU (Audit and Accountability)

Policies should be documented as part of the system security posture.

---

## 14. Design Summary

| Principle | Outcome |
|---------|---------|
| Separate intent from constraint | Prevents escalation |
| Role-centric design | Improves accountability |
| Least privilege by iteration | Reduces risk |
| Use conditions | Improves precision |
| Manage via IaC | Enables control and auditability |

---

## 15. Relationship to Other Documents

This document complements:
- `human-vs-workload-identity.md`
- `permission-boundaries.md`
- `break-glass-access.md`

Together, these documents form a **coherent IAM design framework**
for secure and auditable AWS environments.
