# 🔍 Sub Trace

A **fast, clean, and reliable penetration testing automation tool** for **subdomain enumeration** and **alive host discovery**, built for bug bounty hunters, red teamers, and cybersecurity students.

Sub Trace combines multiple industry‑standard tools into a **single, interactive workflow**, producing **deduplicated, DNS‑resolved subdomains** and **clean, HTTPS‑preferred alive URLs** — ready for further exploitation.

> ⚡ Built with simplicity, speed, and real‑world recon in mind.

---

## ✨ Features

### 🧭 Subdomain Enumeration (`subs.sh`)

* Enumerates subdomains using **multiple trusted sources**
* Supports **single domain** and **multiple domain list** modes
* Automatic **deduplication**
* **DNS resolution** to filter only valid domains
* Organized output per project

### 🌐 Alive Host Detection (`alive.sh`)

* Probes subdomains using **httpx**
* Detects:

  * HTTP status codes
  * Page titles
  * Technologies
* Scans multiple ports:

  * `80, 443, 8080, 8000, 8443`
* Automatically **prefers HTTPS over HTTP**
* Produces a **clean, minimal alive URL list**

### 📁 Clean Project Structure

```
Targets/
└── project-name/
    ├── subs.txt           # All discovered subdomains
    ├── resolved.txt       # DNS-resolved subdomains
    ├── httpx-full.txt     # Full httpx output
    └── alive.txt          # Clean alive URLs (HTTPS preferred)
```

---

## 🛠️ Requirements

Make sure the following tools are installed and available in your `$PATH`:

* `subfinder`
* `assetfinder`
* `findomain`
* `amass`
* `dnsx`
* `httpx`
* `jq`
* `curl`

> 💡 Recommended: Install via **ProjectDiscovery** and Go tooling for best performance.

---

## 🚀 Installation

```bash
git clone https://github.com/Siddiq-Ahmad/anonysubs.git
cd Sub Traces
chmod +x subs.sh alive.sh
```

---

## 🧪 Usage

### 1️⃣ Subdomain Enumeration

```bash
./subs.sh
```

Choose:

* `1` → Scan a single domain
* `2` → Scan a list of domains from a file

📌 Output is automatically saved under:

```
Targets/<project-name>/
```

---

### 2️⃣ Alive Host Detection

```bash
./alive.sh
```

* Uses `subs.txt` from the selected project
* Runs httpx with optimized flags
* Outputs:

  * Full scan results
  * Clean alive URLs only

---

## 🔐 Why Sub Traces?

✔ Combines **best recon tools** into one flow
✔ Eliminates duplicate noise
✔ Keeps results **organized per project**
✔ Prefers **real, exploitable HTTPS targets**
✔ Beginner‑friendly, yet **professional‑grade**

Perfect for:

* Bug bounty reconnaissance
* Penetration testing engagements
* Learning real‑world recon workflows

---

## 📌 Example Workflow

```bash
./subs.sh      # Enumerate & resolve subdomains
./alive.sh     # Find alive targets
```

Result → A clean list of alive endpoints ready for

---

## 👨‍💻 Author

**Siddiq Ahmad**
Student • Independent Security Researcher

> "recon is not a phase — it’s the foundation."

---

## ⚠️ Disclaimer

This tool is intended **for educational purposes and authorized security testing only**.

❌ Do **NOT** use against systems you do not own or have explicit permission to test.

The author takes **no responsibility** for misuse.

---
## 🔗 Connect with Me
<p align="left"> <a href="https://www.linkedin.com/" target="_blank"> <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white"/> </a> <a href="https://www.instagram.com/" target="_blank"> <img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/> </a> <a href="https://your-portfolio-website.com" target="_blank"> <img src="https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=firefox&logoColor=white"/> </a> </p>

## ⭐ Support

If you find this project useful:

* ⭐ Star the repository
* 🐞 Report issues
* 🤝 Contribute improvements

Happy hunting! 🐞⚔️
