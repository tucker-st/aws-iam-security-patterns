# Identity Boundaries in AWS

In cloud environments, **identity defines the security perimeter**.
Traditional network-based trust models are insufficient on their own;
access is ultimately governed by who or what an identity is allowed to do.

Identity boundaries are the mechanisms used to **define, separate, and contain**
the scope of actions an identity may perform.

This document describes how identity boundaries function in AWS and how they
are used to limit blast radius, preserve accountability, and support auditability.

---

## 1. What Is an Identity Boundary

An identity boundary is any control that limits:
- What an identity can do
- Where it can do it
- Under what conditions it can act

Boundaries do not grant access.
They **constrain access**, even when permissions are misconfigured elsewhere.

---

## 2. Identity as the Primary Security Boundary

In AWS, identities can:
- Bypass network controls
- Access resources across regions and accounts
- Act without interactive login

As a result, identity boundaries are often **more critical than network boundaries**
for controlling risk.

---

## 3. Types of Identity Boundaries

AWS environments commonly employ multiple boundary layers:

| Boundary Type | Function |
|--------------|----------|
| Trust policies | Control who can assume a role |
| Identity policies | Define intended permissions |
| Permission boundaries | Limit maximum permissions |
| Service control policies (SCPs) | Enforce organizational constraints |
| Conditions | Contextual enforcement (region, tags, endpoints) |

Effective security relies on **layering**, not any single mechanism.

---

## 4. Trust Policies as a Boundary

Trust policies define **who or what is allowed to assume a role**.
They are frequently overlooked as a security control.

Poorly scoped trust policies can:
- Allow unintended principals
- Enable cross-account abuse
- Collapse separation between identity domains

Trust policies should be:
- Explicit
- Minimal
- Free of wildcards
- Reviewed as security-critical configuration

---

## 5. Boundary Alignment with Identity Domains

Boundaries should align with identity purpose:

### Human Identities
- Constrained by permission boundaries
- Limited by session duration
- Restricted from mutating IAM configuration

### Workload Identities
- Scoped to a single function
- Prevented from accessing IAM APIs
- Isolated from human access paths

Boundary misalignment is a common source of privilege escalation.

---

## 6. Boundary Enforcement Through Conditions

Conditions provide **context-aware boundaries**.

Common uses include:
- Region restrictions
- VPC endpoint enforcement
- Resource tagging requirements
- Encryption enforcement

Conditions reduce the need for broad permissions while maintaining functionality.

---

## 7. Boundary Drift and Maintenance

Boundaries must be:
- Documented
- Reviewed periodically
- Updated intentionally

Unreviewed boundaries can become:
- Overly permissive
- Operationally blocking
- Misaligned with current architecture

Boundary drift undermines their effectiveness.

---

## 8. Audit and Compliance Considerations

Identity boundaries support:
- Clear privilege justification
- Reduced audit scope
- Stronger access narratives

From an RMF perspective, boundaries directly support:
- AC (Access Control)
- IA (Identification and Authentication)
- AU (Audit and Accountability)

Auditors expect boundaries to be **intentional and enforced**, not implicit.

---

## 9. Design Summary

| Principle | Outcome |
|---------|---------|
| Identity defines the perimeter | Reduces reliance on networks |
| Boundaries constrain permissions | Limits blast radius |
| Trust policies are security controls | Prevents unauthorized assumption |
| Layered boundaries | Defense in depth |

---

## 10. Relationship to Other Documents

This document complements:
- `human-vs-workload-identity.md`
- `permission-boundaries.md`
- `iam-policy-design.md`

Together, these documents define **how identity is constrained**
throughout the AWS environment.
