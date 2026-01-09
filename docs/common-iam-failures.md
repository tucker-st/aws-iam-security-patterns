# Common IAM Failures in AWS Environments

Most cloud security incidents do not result from novel attacks.
They result from **repeated, well-understood IAM failures**.

This document captures common IAM failure patterns observed during
incident response, audits, and security reviews, along with the
underlying causes that enable them.

---

## 1. Overly Broad Trust Policies

Examples:
- Wildcard principals (`"Principal": "*"`)
- Unrestricted cross-account access
- Shared trust across unrelated workloads

Impact:
- Unauthorized role assumption
- Lateral movement across accounts
- Loss of accountability

Trust policies are often the **first point of failure**.

---

## 2. Mixing Human and Workload Access

Examples:
- Humans assuming workload roles for debugging
- CI/CD pipelines using human roles
- Shared roles for automation and administration

Impact:
- Audit ambiguity
- Credential exposure
- Privilege escalation

Human and workload identities must remain distinct.

---

## 3. Absence of Permission Boundaries

Examples:
- Roles without boundaries
- Boundaries applied inconsistently
- Boundaries that allow IAM modification

Impact:
- Uncontrolled privilege growth
- Escalation through misconfigured policies
- Increased audit findings

A boundary that does not constrain is ineffective.

---

## 4. Long-Lived Credentials

Examples:
- IAM users with access keys
- Embedded credentials in code
- Unrotated keys for automation

Impact:
- Credential leakage
- Undetected compromise
- Persistent unauthorized access

Short-lived credentials should be the default.

---

## 5. Overuse of Wildcards

Examples:
- `Action: "*"`
- `Resource: "*"` without conditions
- Broad administrative policies for convenience

Impact:
- Expanded blast radius
- Reduced visibility into intent
- Increased incident scope

Wildcards should be rare and justified.

---

## 6. Inadequate Logging and Attribution

Examples:
- CloudTrail disabled or incomplete
- Shared roles without session tagging
- No differentiation between human and workload actions

Impact:
- Delayed detection
- Impaired incident response
- Weak audit evidence

Lack of attribution is itself a security failure.

---

## 7. Unused or Legacy Roles

Examples:
- Roles created for temporary projects
- Deprecated automation identities
- Unreviewed access paths

Impact:
- Expanded attack surface
- Unknown trust relationships
- Audit scope inflation

Unused roles should be removed.

---

## 8. Untested Break-Glass Access

Examples:
- Emergency roles never exercised
- Expired MFA devices
- Missing credentials during incidents

Impact:
- Loss of administrative access
- Extended outages
- Operational failure during incidents

Break-glass access that is not tested is non-functional.

---

## 9. Root Account Mismanagement

Examples:
- Root access keys enabled
- MFA not enforced
- Root used for routine operations

Impact:
- Irreversible compromise risk
- Audit failure
- Loss of trust in security posture

Root access should be minimized and controlled.

---

## 10. Design Summary

| Failure Pattern | Root Cause |
|---------------|-----------|
| Broad trust | Convenience over control |
| Identity mixing | Lack of separation |
| No boundaries | Missing preventive controls |
| Long-lived credentials | Legacy practices |
| Untested emergency access | Operational neglect |

---

## 11. Relationship to Other Documents

This document reinforces:
- `identity-boundaries.md`
- `human-vs-workload-identity.md`
- `permission-boundaries.md`
- `break-glass-access.md`

Together, these documents describe **how IAM fails**
and how those failures can be prevented.
