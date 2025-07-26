# Security Automation

This section outlines my experience building security automation to reduce manual workload, accelerate response, and improve detection fidelity using SOAR platforms, scripting, and native integrations.

---

## 🔧 Tools & Platforms Used

- **Google SecOps (Chronicle SOAR)**
- **Jira Automation**
- **CrowdStrike Fusion**
- **AWS Lambda**
- **Python & PowerShell**
- **Slack + Webhooks**

---

## ⚙️ Example 1: Auto-Resolve Informational Cases from Threat Intel

**Platform**: CrowdStrike Fusion

**Goal**: Automatically close low-severity "Custom IOC Domain" cases that come from Netskope Threat Exchange.

**Workflow**:
- Trigger: New case opened in Falcon
- Condition: If detection type contains "Custom IOC" and domain reputation is `Informational`
- Action: Add comment, tag case, and auto-resolve

**Impact**: Reduced noise by 60%, freeing up analyst time for critical triage.

---

## ⚙️ Example 2: Jira Automation for Alert Categorization

**Platform**: Jira + Splunk

**Goal**: Automatically tag and resolve repetitive detection tickets (e.g., `Login_Failure_to_Disabled_Account`)

**Logic**:
- Trigger: Case created
- Conditions: Summary match, label = low
- Actions: Add comment, link to parent Jira, auto-resolve

**Outcome**: Eliminated 100+ low-fidelity alerts weekly.

---

## ⚙️ Example 3: Slack to Chronicle Case Integration

**Goal**: When a new message is posted in a Webex/Slack channel, auto-update the corresponding Chronicle case.

**Tools Used**:
- Webex bot or Slack App
- Google SecOps webhook
- AWS Lambda as middleware

**Outcome**: Replaced manual status updates with real-time chat-to-case sync, reducing miscommunication.

---

## 💡 Lessons Learned

- Automation should never skip human validation for high-severity events.
- Use tags and case context to group related alerts and escalate meaningfully.
- Regular tuning and feedback loops ensure automation keeps pace with changing threat landscape.

