# Break-Glass Access in AWS IAM

Break-glass access refers to **predefined emergency access mechanisms**
used to regain control of cloud environments during exceptional conditions,
such as identity provider outages, misconfiguration, or security incidents.

Break-glass access is not a convenience feature.
It is an **availability and recoverability control** that must be designed,
documented, and governed with the same rigor as preventive security controls.

---

## 1. Why Break-Glass Access Is Required

Modern AWS environments commonly depend on:
- External identity providers (IdPs)
- Federated authentication
- Automated role provisioning

When these dependencies fail, **administrative access may be lost entirely**.

Break-glass access exists to:
- Restore administrative control
- Contain active incidents
- Recover from misconfiguration
- Support continuity of operations

The absence of a break-glass mechanism is itself a **systemic risk**.

---

## 2. Break-Glass vs Day-to-Day Access

Break-glass access differs from normal access in several ways:

| Attribute | Day-to-Day Access | Break-Glass Access |
|--------|------------------|-------------------|
| Usage frequency | Regular | Rare |
| Authentication | Federated | Strong local controls |
| Session duration | Short | Explicitly limited |
| Privilege level | Role-aligned | Elevated but constrained |
| Audit expectations | Routine | Heightened scrutiny |

Break-glass access must remain **separate and distinct** from normal access paths.

---

## 3. Break-Glass Design Objectives

A well-designed break-glass mechanism must satisfy:

- **Availability** — usable during identity or control-plane failures
- **Security** — protected against unauthorized use
- **Auditability** — all usage clearly attributable and reviewable
- **Containment** — limited scope and blast radius
- **Governance** — documented ownership and approval processes

Failure in any of these areas undermines the control.

---

## 4. Identity Model for Break-Glass Access

Break-glass access should be implemented as:

- A small number of dedicated IAM roles
- Explicit trust policies
- Strong authentication requirements
- No reuse of day-to-day identities

Break-glass identities must not be:
- Shared
- Used for routine tasks
- Embedded in automation
- Granted standing access

---

## 5. Authentication Controls

Strong authentication is mandatory for break-glass access.

Recommended controls include:
- Hardware-based MFA
- Restricted source IPs
- Explicit session duration limits
- Manual role assumption

Break-glass credentials should be stored and protected using
organizationally approved secure storage mechanisms.

---

## 6. Authorization Scope

Break-glass roles should:
- Grant only the permissions required for recovery
- Exclude unnecessary service access
- Avoid blanket administrative permissions when possible
- Be constrained by permission boundaries

Even in emergencies, **least privilege still applies**.

---

## 7. Activation and Usage Controls

Break-glass usage should require:
- Explicit intent (manual action)
- Clear justification
- Limited duration
- Post-use review

Where feasible, access should be:
- Enabled only when needed
- Automatically revoked after use
- Logged and alerted on in near real time

---

## 8. Logging and Monitoring

All break-glass activity must be:
- Fully logged (e.g., CloudTrail)
- Easily distinguishable from normal activity
- Actively monitored

Alerts should trigger on:
- Role assumption
- Privilege changes
- Sensitive actions performed under break-glass roles

Break-glass usage should always be treated as a **security event**.

---

## 9. Audit and Compliance Considerations

From a governance perspective, break-glass access supports:
- Availability objectives
- Incident response readiness
- Business continuity planning

From an RMF perspective, break-glass access contributes to:
- AC (Access Control)
- IA (Identification and Authentication)
- CP (Contingency Planning)
- IR (Incident Response)
- AU (Audit and Accountability)

Auditors typically expect:
- Documented procedures
- Evidence of control testing
- Demonstrated logging and review

---

## 10. Common Failure Modes

Break-glass mechanisms frequently fail due to:

- Roles that are never tested
- Credentials that expire or are lost
- Overly broad permissions
- Lack of monitoring
- Cultural resistance to using emergency controls

Untested break-glass access is **non-functional by definition**.

---

## 11. Operational Testing

Break-glass access should be:
- Tested periodically
- Tested during controlled exercises
- Verified after identity changes
- Included in incident response planning

Testing should validate both:
- Technical functionality
- Procedural readiness

---

## 12. Design Summary

| Principle | Rationale |
|--------|-----------|
| Break-glass access is required | Supports availability |
| Separation from normal access | Preserves audit clarity |
| Strong authentication | Prevents abuse |
| Explicit activation | Reduces accidental use |
| Logging and review | Ensures accountability |

---

## 13. Relationship to Other Documents

This document should be read alongside:
- `human-vs-workload-identity.md`
- `permission-boundaries.md`
- `iam-policy-design.md`

Together, these patterns ensure that **emergency access exists**
without undermining the overall identity security model.
