# Enterprise DevSecOps Terraform Repo

> **AGENT DIRECTIVE:** This file is the absolute source of truth for architectural engineering. Any AI agent (Planning, Writing, or Executing) operating within this repository **MUST** adhere strictly to the constraints, structures, and schemas defined below. Failure to align with these protocols will result in pipeline failure.

---

## 🏗️ 1. Core Architectural Layout & Structuring
This repository utilizes a strict **two-tier Caller/Definition model** to maximize module reusability while ensuring multi-environment safety.

### **The Two Tiers:**
1. **`modules/<service-name>/`**: 
   - Contains raw, highly reusable, baseline Terraform definitions (e.g. `modules/ec2`, `modules/rds`).
   - Does **not** contain specific environment names, tags, or hardcoded values.
   - Must expose generalized `variables.tf`.
   - Must output relevant ARNs and IDs in `outputs.tf`.

2. **`accounts/<environment_type>/<env>/<service-name>/`**:
   - Contains the **"Caller"** configurations (e.g. `accounts/nonprod/dev/ec2`).
   - Acts as an instantiation of the reusable modules.
   - Passes exact values using dynamic variables to the `source = "../../../../modules/<service>"` block.
   - Contains the `backend.tf` linking to the live environment state.

---

## 🔒 2. Variables & The 3-Tier Inheritance Matrix
To secure variables globally while preventing code duplication, the Agent MUST structure variables in three discrete layers:

* **Layer 1:** `accounts/<environment_type>/account.tfvars` (Global Variables like Cost Center, Target AWS Region, baseline tags)
* **Layer 2:** `accounts/<environment_type>/<env>/env.tfvars` (Environment-specific variables like Instance Types, KMS IDs, subnet definitions)
* **Layer 3:** `<target_dir>/variables.tf` (Service-specific variables natively evaluated during module execution)

### ⚠️ Execution Bound:
If the agent defines a new variable inside an account's `main.tf`, the agent **must** map its default value or inject it cleanly into the hierarchical `env.tfvars`/`account.tfvars` layers so it is centrally managed.

---

## 🛡️ 3. Strict State Preservation & Anti-Destruction Rules
This repository strictly enforces **Non-Destructive Operations**.

- **NEVER** overwrite an existing `main.tf`, `providers.tf`, or `variables.tf` if it already contains production code.
- Always natively **APPEND** new resources, modules, or variables to existing files.
- If appending, you must respect the existing indentation, syntax flow, and stylistic structures.
- Provider configurations (`aws`, `azurerm`, etc.) exist **exactly once**. If a `providers.tf` already exists and contains the required provider, the agent must inherit it and **never duplicate the block**.

---

## 📚 4. Documentation Protocol (`terraform-docs`)
Every module and caller directory must remain human-readable.
- Whenever a `variables.tf` or `outputs.tf` file is modified within the `modules/` layer, the agent must execute the `terraform-docs` CLI command to automatically rebuild the `README.md` injection block inside that target directory.
- Variables must include a highly descriptive `description = "..."` field, ensuring the auto-generated documentation creates context for external developers.

---

## 🚦 5. Automated CI/CD DevSecOps Constraints
This repository natively blocks unauthorized or insecure infrastructure from merging to `develop` or `main`. Code authored by agents must pass the following checks natively:
1. `terraform fmt -check -recursive` (Format Compliance)
2. **Tfsec Security Scanner** (`tfsec . --soft-fail --minimum-severity CRITICAL`)
3. **Infracost Multi-Tier Financial Breakdown** (Cost mapping verification)

Agents must structure resource blocks (e.g. S3 Buckets, RDS clusters) with baseline security configurations, such as KMS Encryption natively turned on, to avoid triggering `CRITICAL` vulnerability flags from Tfsec.
