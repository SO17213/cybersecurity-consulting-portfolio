# Security Operations Center (SOC)

This section highlights my experience supporting 24/7 SOC environments, including Tier 1–3 responsibilities, tooling, metrics, and real-world escalations.

---

## 🔸 Key Responsibilities

- **Alert triage and analysis** using Splunk, CrowdStrike Falcon, Proofpoint TAP, and Netskope.
- **Incident escalation and response** based on severity and playbook triggers.
- **Detection tuning**: Creating Jira tickets to Detection Engineering to reduce false positives and improve fidelity.
- **Dashboard creation** in Splunk and Kibana for leadership visibility on key SOC metrics.
- **Threat hunting** across AWS, Okta, macOS, and Windows environments.

---

## 🔸 Example Workflow: Suspicious Login Alert

**Tool**: Okta + Splunk + CrowdStrike

1. Alert triggered for Okta login from unusual IP.
2. Checked CrowdStrike sensor activity on corresponding endpoint.
3. Queried Splunk logs for related access attempts and file activity.
4. Confirmed user was traveling — marked as benign and documented.

---

## 🔸 Tools Used in SOC

- **Splunk Cloud / ES**
- **Kibana (Elasticsearch)**
- **CrowdStrike Falcon NGSIEM**
- **Google SecOps (Chronicle)**
- **QRadar SIEM**
- **Proofpoint**
- **Netskope**
- **Jamf Protect**
- **AWS GuardDuty / CloudTrail**

---

## 📊 Reporting & Metrics

- SLA tracking of alert closures
- Daily SOC summaries
- Executive reporting dashboards (KPI counts, alert types, user activity)

