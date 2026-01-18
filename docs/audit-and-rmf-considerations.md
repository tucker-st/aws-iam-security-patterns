# Audit and RMF Considerations for AWS IAM

This document explains how the IAM patterns in this repository support **auditability**, **risk management**, and **defensible security decisions** in regulated or compliance-driven environments.

It is written for:
- Security engineers and architects
- ISSOs / compliance practitioners
- Auditors and reviewers who need to understand *intent*, not just configuration

The guidance here aligns conceptually with the **Risk Management Framework (RMF)** while remaining practical for modern cloud-native environments.

---

## Why IAM Is Central to Audit and RMF

In cloud environments, **identity replaces the traditional network perimeter**.

From an audit and RMF perspective, IAM is where reviewers expect to see:
- Clear authorization boundaries
- Explicit trust relationships
- Least-privilege enforcement
- Traceability of administrative actions
- Documented exception handling (e.g., emergency access)

Weak IAM design typically results in:
- Excessive blast radius
- Inability to attribute actions to principals
- Compensating controls that are difficult to justify
- Audit findings that persist across assessment cycles

---

## Mapping IAM to RMF Control Objectives

This repository does **not** claim formal compliance with any framework.
Instead, it demonstrates **technical patterns that support common RMF objectives**.

### Identify (Risk Context)

IAM patterns help define:
- Who can access the environment
- What actions they can perform
- Under what conditions access is granted

Relevant concepts:
- Human vs workload identity separation
- Explicit trust policies
- Permission boundaries as blast-radius controls

---

### Protect (Preventive Controls)

Preventive controls are enforced through:
- Deny-by-default policies
- Narrowly scoped IAM permissions
- Permission boundaries on human roles
- Explicit `sts:AssumeRole` trust relationships

These controls reduce the likelihood of:
- Privilege escalation
- Lateral movement through IAM
- Accidental over-permissioning

---

### Detect (Auditability and Visibility)

IAM design directly impacts detection capability.

Patterns in this repository support detection by:
- Ensuring all access flows through roles (not static credentials)
- Enabling consistent CloudTrail attribution
- Avoiding shared or long-lived credentials
- Making role intent human-readable and reviewable

Detection is not treated as a compensating control for weak IAM;
it is treated as a **verification mechanism** for strong IAM design.

---

### Respond (Containment and Recovery)

Emergency access (“break-glass”) is treated as a **designed capability**, not an exception.

Break-glass patterns in this repository emphasize:
- Predefined emergency roles
- Strong authentication requirements
- Explicit activation steps
- Logging and post-event review

This approach supports:
- Operational survivability
- Documented deviation handling
- After-action audit review

---

### Recover (Lessons Learned)

IAM structures that are:
- Modular
- Explicit
- Documented

make it easier to:
- Perform access reviews
- Adjust boundaries after incidents
- Demonstrate continuous improvement to auditors

---

## Evidence an Auditor Should Be Able to Obtain

Well-designed IAM enables auditors to answer the following questions quickly:

- Who can administer this environment?
- How is human access authenticated and authorized?
- How are workloads authenticated?
- Where are privilege boundaries enforced?
- How is emergency access handled?
- Can actions be attributed to individual principals?
- Are permissions understandable without reverse engineering?

This repository is intentionally structured so that these answers are visible in:
- Terraform code
- Trust policies
- Documentation
- Naming conventions

---

## IAM Design Decisions That Reduce Audit Risk

The following design decisions directly reduce audit and RMF risk:

- Separation of human and workload identities
- Elimination of static credentials
- Role assumption with explicit trust
- Permission boundaries for humans
- Deny-by-default guardrails
- Predefined emergency access paths

Each of these decisions trades *convenience* for *defensibility* — a trade auditors generally favor.

---

## Common Audit Failure Modes (and How These Patterns Help)

| Failure Mode | Mitigation Pattern |
|-------------|-------------------|
| Overly broad IAM policies | Permission boundaries |
| Shared administrator accounts | Role-based access |
| Unattributable actions | Mandatory role assumption |
| Emergency access chaos | Predefined break-glass roles |
| Excessive compensating controls | Strong preventive IAM design |

---

## What Auditors Typically Care About (and What They Don’t)

Auditors usually care about:
- Intentional design
- Consistency
- Repeatability
- Traceability
- Documented exceptions

They usually care less about:
- The exact AWS service used
- Novel tooling
- Over-optimization

This repository is intentionally conservative and explicit to align with that reality.

---

## Using This Repository in an RMF Context

This repository can be used as:
- A reference architecture during control selection
- Technical evidence during assessments
- A discussion aid with ISSOs and auditors
- A baseline for internal security standards

It should be paired with:
- Organizational policy
- Logging and monitoring strategy
- Formal risk acceptance processes

---

## Important Disclaimer

Nothing in this repository constitutes formal compliance guidance.

All patterns must be:
- Reviewed
- Approved
- Adapted

within the context of your organization’s risk posture, policies, and authorization boundaries.
