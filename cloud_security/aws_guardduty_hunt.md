# AWS GuardDuty Threat Hunt – Unusual API Call

This cloud security investigation demonstrates how I triaged an unusual AWS GuardDuty alert involving suspicious API usage. The goal was to validate whether this activity was malicious, misconfigured, or expected behavior.

---

## 🎯 GuardDuty Alert

- **Title:** UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration
- **Severity:** High
- **Account:** Redacted (lab account)
- **Region:** us-west-2
- **Resource:** EC2 instance i-0a1234567890b1234
- **API Called:** `GetCallerIdentity`, `ListBuckets`, `DescribeInstances`

---

## 🔎 Investigation Steps

### 1. Confirm GuardDuty Finding

- Finding Type: `UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration`
- Trigger: EC2 instance calling STS or IAM APIs from an **unusual IP** not aligned with VPC

---

### 2. Pivot to CloudTrail

Search for matching events around the time of the finding:

- Filter:
  - `eventSource`: `sts.amazonaws.com` or `iam.amazonaws.com`
  - `sourceIPAddress`: IP flagged in GuardDuty
  - `userIdentity.sessionContext.sessionIssuer.type`: `Role`

Look for:

- Calls to `GetCallerIdentity` and `AssumeRole`
- Signs of reconnaissance: `ListBuckets`, `DescribeInstances`, `GetObject`

---

### 3. Check VPC Flow Logs

Validate whether outbound connections went to suspicious IPs:

- Traffic from flagged EC2 to the internet?
- Ports: 22, 443, or unusual high ports?

---

### 4. Analyze Context

- Instance was exposed via misconfigured security group (0.0.0.0/0 on port 80)
- Instance metadata was accessible due to outdated IAM role policies
- Attacker used SSRF to grab instance credentials from metadata endpoint

---

## 📌 Outcome

- Activity confirmed as malicious
- IAM role was overly permissive (S3 full access, EC2 read access)
- Role revoked, instance terminated
- GuardDuty finding archived after remediation
- Detection rules added to monitor metadata access and outbound traffic

---

## 🧠 Lessons Learned

- GuardDuty's findings are a great early signal, but **CloudTrail validation is critical**
- Always monitor for high-value API calls (`GetCallerIdentity`, `ListBuckets`) from unexpected roles or IPs
- Enforce metadata v2 and restrict IAM roles via trust policy conditions

---

## 🔧 Tools Used

- AWS GuardDuty
- AWS CloudTrail
- VPC Flow Logs
- Splunk for centralized log analysis

---

> This investigation was recreated in a lab environment for portfolio and education purposes.

