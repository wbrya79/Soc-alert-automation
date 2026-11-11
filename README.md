# Soc-alert-automation
Soc alert automation and incident triage using Powershell, n8n, webhooks, and Discord.
# SOC Alert Automation and Incident Triage with n8n

**A hands-on security automation project demonstrating event ingestion, alert triage, human-in-the-loop decision-making, and simulated incident response using PowerShell, n8n, and Discord.**

## Project Overview

This project explores foundational Security Operations Center (SOC) and Security Orchestration, Automation, and Response (SOAR) concepts through a self-hosted automation environment.

Using PowerShell, I generated simulated endpoint security alerts and transmitted them as JSON payloads to an authenticated n8n webhook. The workflow extracts relevant event information, evaluates alert severity, and sends high-severity detections to Discord for analyst review.

An analyst can approve or decline a proposed response. Approved source IP addresses are recorded in an n8n Data Table representing a simulated blocklist.

**The objective was not to reproduce an enterprise SOC environment, but to gain practical experience with the technologies, integrations, and decision-making processes that support security automation.**

## Technologies Used

| Technology | Purpose |
|---|---|
| PowerShell | Simulated security alert generation |
| n8n | Workflow orchestration and conditional processing |
| Webhooks / HTTP POST | Security event ingestion |
| JSON | Structured security event exchange |
| Discord | Analyst notification and approval |
| n8n Data Tables | Simulated IP blocklist |
| Debian Linux VPS | Self-hosted automation infrastructure |

## Workflow Architecture

```text
PowerShell Alert Simulation
           |
           v
Authenticated n8n Webhook
           |
           v
Extract Security Event Fields
           |
           v
Evaluate Alert Severity
           |
      High Severity?
           |
          Yes
           |
           v
Discord Security Notification
           |
           v
Analyst Approval Required
           |
      Approved?
       /     \
     Yes      No
      |        |
      v        v
Record IP    No Blocklist
in Data      Update
Table
```

## Implementation

### Security Event Generation

Created a PowerShell script that constructs a simulated endpoint detection and sends structured JSON data to an n8n webhook.

The payload includes the detection source, severity, hostname, username, source IP address, and detection description.

The example uses CrowdStrike as a simulated event source. No live CrowdStrike EDR integration is implemented.

### Automated Alert Processing

Configured an n8n webhook with header-based authentication to receive HTTP POST requests.

An Edit Fields node extracts event attributes, and an IF node checks whether the alert severity equals `high`.

This demonstrates the basic principle of using structured security data and conditional logic to determine which events require further attention.

### Analyst Notification and Approval

Integrated Discord to present high-severity alerts with relevant event details and request an analyst decision.

The analyst can select **Add to Blocklist** or **Ignore**.

The workflow evaluates the response before proceeding, demonstrating a human-in-the-loop approval mechanism.

### Simulated Incident Response

When the analyst approves the action, the workflow records the source IP address in an n8n Data Table.

This represents a proposed containment action without modifying network infrastructure.

**No firewall rules are created, no endpoints are isolated, and no actual network traffic is blocked.**

## Project Screenshots

### n8n Workflow Overview

![Workflow Overview](screenshots/workflow-overview.png)

*Visual overview of the six-node automation workflow.*

### Discord Security Alert

![Discord Alert](screenshots/discord-alert.png)

*Simulated high-severity detection presented for analyst review.*

### Workflow Execution

![Successful Execution](screenshots/successful-execution.png)

*Execution view showing the automated processing sequence.*

### Simulated IP Blocklist

![Simulated Blocklist](screenshots/simulated-blocklist.png)

*Data Table used to record approved source IP addresses.*

## How This Relates to Real-World Security Operations

Although this project uses simulated data and simplified response logic, several of its underlying concepts are relevant to operational security environments.

| Project Implementation | Real-World Security Concept |
|---|---|
| PowerShell-generated security alert | Endpoint telemetry collected from EDR or SIEM platforms |
| n8n webhook ingestion | Event ingestion through APIs, integrations, or message pipelines |
| Severity-based IF condition | Alert classification, correlation, and prioritization |
| Discord notification | Analyst notification through security consoles or collaboration platforms |
| Analyst approval buttons | Human authorization for sensitive response actions |
| Simulated IP blocklist | Documenting or initiating an authorized containment decision |

These comparisons illustrate conceptual similarities, not equivalent functionality or production readiness.

In a production environment, severity alone would not establish that an event is malicious or justify blocking an IP address. Analysts would typically consider detection context, supporting telemetry, asset criticality, threat intelligence, potential business impact, and established response procedures.

## Project Scope and Limitations

This project intentionally simplifies several aspects of enterprise security operations.

**Simulated detection data:** Alerts are generated using a PowerShell script rather than collected from an operational EDR platform.

**Basic alert classification:** The workflow evaluates a supplied severity value rather than performing advanced correlation, behavioral analysis, or independent threat validation.

**Simplified analyst review:** Discord provides a demonstration of approval-based response. It does not replace a security case-management system or comprehensive investigation process.

**Simulated containment:** Approved IP addresses are stored in a Data Table. The workflow does not enforce firewall policies or perform endpoint containment.

**Limited production safeguards:** The implementation does not demonstrate a complete production control set, such as comprehensive input validation, role-based authorization, resilient error handling, centralized audit logging, or high-availability architecture.

These limitations are intentional. The focus is on understanding workflow orchestration, data exchange, conditional processing, and analyst-controlled response.

## Technical Skills Demonstrated

### Security Operations and Incident Response
- Security event ingestion and triage
- Alert severity classification
- Analyst-driven response decisions
- Understanding of containment workflows
- Recognition of automation limitations and operational risks

### Scripting and Automation
- PowerShell scripting
- JSON data formatting
- HTTP POST requests
- Webhook-based application integration
- Conditional workflow logic
- Multi-step automation design

### Infrastructure and Troubleshooting
- Self-hosted n8n deployment on a Linux VPS
- Webhook authentication configuration
- Discord application integration
- Workflow execution troubleshooting
- Data storage using n8n Data Tables

## Security Considerations

The workflow uses header-based authentication for incoming webhook requests.

For a production implementation, additional security controls would be necessary, including properly validated HTTPS connections, secure credential management, payload validation, authorization controls, monitoring, and audit logging.

The public repository should contain only sanitized configuration files and example values. Real authentication secrets, API tokens, passwords, and encryption keys must not be committed.

## Future Improvements

To expand this project toward a more realistic security operations implementation, future development could include:

1. Integrating an actual EDR or SIEM data source.
2. Enriching alerts with threat intelligence and contextual information.
3. Adding event correlation, deduplication, and risk-based prioritization.
4. Implementing case management and audit trails.
5. Improving error handling, input validation, and authentication.
6. Integrating an authorized firewall API with approval controls and rollback procedures.
7. Testing failure scenarios and documenting operational recovery procedures.

## Project Files

```text
soc-alert-automation-n8n/
|
|-- README.md
|-- workflow.json
|-- cyber-alert.ps1
|
`-- screenshots/
    |-- workflow-overview.png
    |-- discord-alert.png
    |-- successful-execution.png
    `-- simulated-blocklist.png
```

The public workflow file demonstrates the automation structure. Importing it into another environment requires configuring the necessary credentials, webhook authentication, Discord resources, and Data Table.

## What I Learned

Building this project strengthened my understanding of how security events can move between systems and how automation can support incident response processes.

I gained practical experience with PowerShell scripting, JSON payloads, webhooks, conditional logic, third-party integrations, and self-hosted infrastructure.

The project also reinforced an important distinction: **automating an action is not the same as validating that the action is appropriate.** Effective security automation requires reliable data, sufficient investigative context, appropriate authorization, and safeguards against unintended consequences.

While this implementation is not a production SOC solution, it demonstrates my ability to configure, integrate, troubleshoot, and explain technologies relevant to security operations.

## Acknowledgments

This project was developed as a guided hands-on learning exercise using a cybersecurity automation tutorial. The implementation involved configuring and troubleshooting the workflow in a self-hosted environment.


---

**Disclaimer:** This repository is an educational demonstration. Security detections, analyst decisions, and containment outcomes are simulated and should not be interpreted as production security controls.
