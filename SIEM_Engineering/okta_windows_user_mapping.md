# Correlating Okta Logins with Windows Host Activity – SIEM Engineering Use Case

This use case demonstrates how I correlated user logins from Okta (SSO provider) with Windows endpoint activity to track lateral movement, identify compromised accounts, and improve investigative visibility.

---

## 🧠 Why This Matters

In many orgs:
- Identity logs (Okta) and endpoint logs (Windows) are stored in separate indexes
- Users log in via Okta, but lateral movement and persistence happen on the endpoint
- SOC analysts need a reliable way to map user → device → behavior

---

## 🔍 Log Sources

- **Okta** logs in: `index=okta`
- **macOS endpoint logs** in: `index=jamf`
- **Windows endpoint logs** in: `index=o365`

---

## 🧪 Goal

Match a user's login in Okta to:
- Their most recently used macOS or Windows device
- Username and hostname pairs for downstream correlation (e.g., file writes, process launches)

---

## 🔎 SPL Search – Combined User/Device Mapping

```spl
(
  index=okta
  | fields user
)
OR
(
  index=jampro OR index=o365
  | fields user, host
)
| search user!=""
| eval platform=if(index="jamf", "macOS", "Windows")
| stats dc(index) as sources_used values(platform) values(host) by user
| where sources_used>1

