# Memory Analysis with Volatility 3

This is a sample forensic case study analyzing a memory image from a Windows system. The investigation was conducted in a lab environment using Volatility 3.

---

## Case Background

- Scenario: Suspicious behavior reported on a Windows 10 system. Memory captured using `winpmem`.
- Goal: Identify evidence of malware, persistence, and lateral movement.

---

## Tools Used

- Volatility 3
- Image: win10-memory.raw
- Environment: Kali Linux / Remnux

---

## Analysis Steps

1. Verify Image Info

Command:
volatility3 -f win10-memory.raw windows.info

- Verified profile and kernel base

2. List Running Processes

Command:
volatility3 -f win10-memory.raw windows.pslist

- Found svchost.exe running from a suspicious path:
  C:\Users\Public\svchost.exe

3. Check Network Connections

Command:
volatility3 -f win10-memory.raw windows.netscan

- Outbound connection to 92.255.57.58 on port 443 — listed on AbuseIPDB

4. Dump Suspicious Process

Command:
volatility3 -f win10-memory.raw -p <PID> windows.dumpfiles.DumpFiles --dump-dir ./dump

- Extracted binary for further analysis (flagged as AsyncRAT by VirusTotal)

---

## Findings Summary

| Finding             | Description                                                      |
|---------------------|------------------------------------------------------------------|
| Suspicious Process | svchost.exe in user directory, unusual parent-child behavior     |
| Malicious IP       | *.*.*.* – known C2 infrastructure                           |
| Extracted Malware  | Confirmed AsyncRAT sample with remote access functionality       |

---

## Lessons Learned

- Importance of live memory in identifying stealthy malware
- Value of network artifact correlation
- Volatility’s usefulness in rapid triage and malware extraction

---

This was recreated in a test lab with synthetic or public images. No client or employer data is included.

