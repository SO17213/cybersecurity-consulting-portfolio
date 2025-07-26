# Okta MFA Bypass Attempt – Detection Use Case

This detection is designed to identify potential MFA bypass attempts in Okta. This can happen via legacy protocols, misconfigured policies, or attacker abuse of trusted IPs or session hijacking.

---

## 🎯 Objective

Detect when an MFA requirement was skipped or not enforced during user login — especially from suspicious locations or risky devices.

---

## 🔍 SPL Logic (Splunk)

Search:

index=okta eventType=system.authentication.auth  
| eval auth_result=coalesce(outcome.result, "unknown")  
| where auth_result="SUCCESS" AND authenticationContext.externalSessionId!="" AND NOT authenticationContext.authenticationStep=2  
| stats count by user, authenticationContext.authenticationStep, client.geographicalContext.country, client.userAgent.rawUserAgent, outcome.reason

---

## 🧪 What This Detects

- MFA step skipped (authenticationStep != 2)
- Successful login
- No enforcement of second factor even with session present

---

## 🧠 Triage Process

1. **Check if user has MFA exclusions or conditional access**  
2. **Review IP and user agent** – unexpected geo? device fingerprint?
3. **Correlate with CrowdStrike or other EDR logs for device behavior**
4. **Review Okta system logs for rule changes or admin action around the time**

---

## ⚙️ Tuning Recommendations

- Exclude service accounts or test users
- Add allowlist for company IPs (if MFA is not enforced internally)
- Tune by country or device type if known to be noisy

---

## 📌 Detection Type

- **MITRE Technique:** T1556.006 (Modify Authentication Process)
- **Severity:** Medium–High depending on volume and impact
- **Type:** Identity-based detection

---

## 🧠 Lessons Learned

- Session identifiers may allow bypass without triggering full login
- Important to monitor both login events AND session patterns
- Multi-tool correlation (Okta + endpoint + network) is key

---

> This rule was developed using Okta logs in a Splunk Cloud environment and tuned based on real use cases.

