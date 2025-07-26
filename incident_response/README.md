# Incident Response

This section covers real-world examples, processes, and methodologies used during cybersecurity incidents. It highlights skills in triage, containment, eradication, recovery, and post-incident lessons learned.

---

## 🔸 Example 1: Ransomware Containment and Recovery

**Scenario**: Multiple endpoints showed signs of file encryption and ransom notes.

**Actions Taken**:
- Identified initial entry via phishing attachment using email gateway logs (Proofpoint).
- Queried endpoint behaviors through CrowdStrike and isolated infected systems.
- Retrieved IOCs and added to firewall blocklists and EDR custom IOAs.
- Engaged backup team to restore encrypted files from last known good snapshot.
- Conducted root cause analysis and created a communication brief to leadership.

**Outcome**: Incident contained within 45 minutes, no major data loss.

---

## 🔸 Example 2: AWS EC2 Compromise via Leaked Credentials

**Scenario**: AWS GuardDuty triggered alert for cryptocurrency mining on EC2.

**Actions Taken**:
- Verified mining activity using CloudWatch and instance metrics.
- Captured disk image and memory snapshot of the EC2 for forensics.
- Terminated instance and revoked exposed IAM credentials.
- Enabled stricter SCPs and configured detection rules in Splunk Cloud for similar patterns.

**Outcome**: Fast containment and forensic capture. Root cause was GitHub credential leakage.

---

## 🧩 Tools Used

- CrowdStrike Falcon
- Splunk Cloud & Enterprise Security
- AWS GuardDuty & CloudTrail
- Proofpoint TAP
- Microsoft Defender for Endpoint
- Chronicle / Google SecOps

---

## 📘 Additional Skills

- SLA-driven case management using ServiceNow & Jira
- Evidence preservation procedures
- Stakeholder communication during incidents
- Post-Incident Reporting (PIR) and action items

---


