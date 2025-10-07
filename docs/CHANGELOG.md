# Rimidi KG Repository Changelog

## vNext — LLM + Automation Rebuild
- Sunny prompt modularized for dynamic context loading (Product / Platform Architecture / Shared CRM)
- n8n weekly schema-sync workflow implemented
- Validator and governance metadata integrated



## vNext (2025-10-06) - Schema Rebuild
- Node labels: kept 13, renamed 1, merged 0, retired 9, added 8 new entries
- Relationship types: kept 25, renamed 2, merged 0, retired 3
- Key vocabulary changes:
  1. Introduced `DataService` nodes to model ETL and data platform jobs replacing domains/feeders.
  2. Added `Reporting` and `Observability` surfaces to distinguish analytics packages from telemetry tooling.
  3. Expanded integration taxonomy with `IntegrationPartner`, `EMRIntegration`, and `DeviceIntegration` roles.
  4. Renamed `Implementation` to `DeploymentType` to capture reusable deployment archetypes.
  5. Recontextualized governance edges (`GOVERNS`, `REQUESTED_BY`, `APPROVED_BY`) around teams, actors, and release versions.


## 0.4.0 - Device & Interop Modeling
- Added patient device ingestion, EHR interoperability, disease view experience, and data export use cases with supporting services in `data/infra.yaml` and `data/seed.cypher`.
- Captured integration partners (Dexcom, Abbott, Smart Meter, Xealth, Baxter, Cerner, NextGen, athenahealth) via `Integration` nodes and `INTEGRATES_WITH` edges.
- Documented business logic, prompts, and queries for the new functional areas, including patient chart subnavs and telehealth vendor enablement.

## 0.3.0 - Release Notes Alignment
- Modeled product capabilities, services, and use cases derived from 2024-2025 release notes in `data/infra.yaml`, `data/seed.cypher`, and `data/business_logic.yaml`.
- Added billing, analytics, API, and collaboration services plus audit-ready domains and collections.
- Refreshed prompts, queries, and documentation to guide Sunny/n8n in reasoning about release-driven functionality.

## 0.2.0 - Service & Data Ecosystem Expansion
- Captured Rimidi business services, infrastructure primitives, domains, collections, feeders, analytics surfaces, and seeds in `data/infra.yaml`.
- Extended business logic mappings with use cases and service touchpoints in `data/business_logic.yaml`.
- Updated schema files, AI context, queries, and playbooks to reflect the expanded taxonomy and governance tags.

## 0.1.0 - Scaffold
- Initialized repo structure for schema, data, AI context, queries, docs, and tooling.
- Added seed dataset and example Cypher queries.
- Drafted initial contribution and playbook documentation.
