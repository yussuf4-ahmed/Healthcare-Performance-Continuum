# **Healthcare Performance Continuum | Case Study**

## **Project Overview**
This is a comprehensive Business Intelligence project designed to provide executive leadership with a single source of truth for clinical quality, operational efficiency, and resource allocation. The project successfully transformed messy, siloed operational and clinical data into three highly actionable dashboards.


## Table of Contents
- [Overview](#-project-overview)
- [Business Challenge](#business-challenge)
- [Business Goal](#business-goal)
- [Methodology](#methodology)
- [Technology Used](#technology-used)
- [Dashboard 1: Overview Dashboard](#dashboard-1-overview-dashboard)
  - Business Questions, Insights & Recommendations
- [Dashboard 2: Readmission Dashboard](#dashboard-2-readmission-dashboard)
  - Business Questions, Insights & Recommendations
- [Dashboard 3: Operations Dashboard](#dashboard-3-operations-dashboard)
  - Business Questions, Insights & Recommendations
- [Next Step — Implementation Roadmap](#next-step-—-implementation-roadmap)
- [Project Link](#project-link)

## Business Challenge
The organization struggled with disconnected data sources (Patients, Readmissions, Hospital Operations), which obscured the relationships between resources, process failures, and patient outcomes.

This fragmentation prevented the organization from answering two high-stakes questions:

1. **Is insufficient staffing directly causing administrative bottlenecks?**  
2. **When is the most critical time to intervene after discharge to prevent readmission?**

## Business Goal
To develop a unified, full-stack Data Analytics platform that could:

1. **Validate/Invalidate** the core hypothesis regarding resource scarcity and process delays.  
2. **Quantify** the true risk profile of patients post-discharge to optimize clinical intervention strategy.  
3. **Establish** clear KPIs for service performance, such as wait times and utilization rates.

## Methodology
The project followed an end-to-end data analytics workflow:

1. **Data Engineering (SQL):** Used **SQL Server** for initial data warehousing and cleansing, standardizing date/time fields, and enforcing integrity across the three disparate source tables.  
2. **Exploratory Analysis (Python):** Performed **EDA** to confirm initial hypotheses, validating the negative correlation between staff count and discharge delays and establishing the structure for the 10-bin readmission risk grouping.  
3. **Modeling & Visualization (Power BI & DAX):** Built a robust Star Schema model, created complex **DAX measures** (e.g., Readmission Rate (%), Staff to Bed Ratio), and designed three interconnected dashboards for final insight delivery.

## Technology Used
- **Data Engineering:** SQL Server  
- **Exploratory Analysis:** Python (Pandas, NumPy, Matplotlib)  
- **Business Intelligence:** Power BI Desktop (DAX)

## Dashboard 1: Overview Dashboard

![Overview Dashboard](Dashboard%20Screenshots/Overview%20Dashboard.jpg)

### Business Questions, Insights & Recommendations

**1. What is the overall volume of patients served during this period?**  
- **Insight:** The facility served **2,000 patients** over the combined 2023–2024 period. With only six staff, this reflects a consistently high workload of roughly 1,000 patients per year.  
- **Recommendation:** Hire additional clinical staff or part-timers to reduce workload pressure. Implement digital triage and appointment systems to maintain quality with growing demand.

**2. How efficiently are we managing patient stays, and is our average duration meeting targets?**  
- **Insight:** The facility maintained a stable **Average Length of Stay (ALOS)** of 5.68 days across all departments. Most departments show efficient throughput between 5.5–5.7 days, while Surgery and “Unknown” categories are slightly higher.  
- **Recommendation:** Investigate surgery delays (pre-op wait, imaging time, post-op bed turnover). Standardize discharge protocols across departments. Remove or fix “Unknown” categories to improve accuracy.

**3. What is our new patient acquisition rate, and what proportion of our patients are using our services for the first time?**  
- **Insight:** **29% of all patients** were first-time visitors, while 71% were returning patients. This shows strong patient trust and retention.  
- **Recommendation:** Increase outreach programs to raise first-time visits to at least 35%. Strengthen referral partnerships with clinics and pharmacies. Promote preventive checkup packages to attract new patients.

**4. How is patient demand changing over time, and are there any seasonal or cyclical trends we need to plan for?**  
- **Insight:** Monthly admissions show consistent patterns across both years, with peaks in **July–October** and dips in **May–June**. These trends reflect true annual cycles in patient demand.  
- **Recommendation:** Schedule more staff during high-demand months (July–October). Use low-demand months (May–June) for staff training, facility maintenance, and system upgrades.

**5. Which departments are experiencing the highest workload and require the most immediate resource allocation?**  
- **Insight:** Top departments by 2-year patient volume:
  1. Emergency – 497 patients  
  2. General Medicine – 409 patients  
  3. Cardiology – 397 patients  
  These three departments handle over 50% of all patients.  
- **Recommendation:** Add staff or rotate personnel into Emergency and General Medicine. Introduce fast-track pathways in Emergency for minor cases. Prioritize equipment upgrades for these high-demand units.

**6. Which departments are outliers in patient throughput efficiency?**  
- **Insight:** The Surgery department shows a higher ALOS of **6.0 days** and the Unknown category shows **6.1 days**. All other departments are within the efficient range (5.5–5.7 days).  
- **Recommendation:** Analyze surgical workflow delays (OR scheduling, recovery room lag). Fix EMR categorization issues causing “Unknown” entries. Implement Lean process improvements for surgical discharge.

**7. What is the current distribution of our patient payer mix, and what are the financial implications?**  
- **Insight:** The payer mix is well-balanced:
  1. Private Insurance – 45%  
  2. Government Insurance – 41%  
  3. Self-pay – 14%  
  This provides revenue stability, with private insurance offering the highest margins.  
- **Recommendation:** Expand private insurance partnerships to increase high-margin patients. Streamline claims processing to avoid reimbursement delays. Offer flexible self-pay options (installments, mobile payments).

## Dashboard 2: Readmission Dashboard

![Readmission Dashboard](Dashboard%20Screenshots/Readmission%20Dashboard.jpg)

### Business Questions, Insights & Recommendations

**1. What is our current readmission rate?**  
- **Insight:** Readmission Rate = **25.0%**.

**2. What is the total number of patients who have been readmitted during this period?**  
- **Insight:** Total Readmissions = **500**.  
- **Recommendation:** Use the 500-count to calculate cost impact (extra bed-days × cost/day) to build the business case for prevention programs.

**3. How quickly are discharge process issues manifesting (average days before readmission)?**  
- **Insight:** Average Days Before Readmission ≈ **61.58 days**. The trend shows early clustering near 30–40 days plus a later spike around 100+ days.  
- **Recommendation:** Implement tiered post-discharge follow-ups (48–72 hr call, 7–30 day clinic review, 90 day check) and measure which interval reduces readmissions most.

**4. What is the maximum risk level among our readmitted patients?**  
- **Insight:** Maximum Risk Level displayed = **10**. Risk bucket 10 has the highest observed readmission proportion (~6.5% on the dashboard chart).  
- **Recommendation:** Prioritize patients scored 8–10 for intensive case management and validate/calibrate the scoring model (see Q6).

**5. What are the most common and actionable reasons driving readmissions?**  
- **Insight:** Top reasons (by %):
  1. Complication — 8.2%  
  2. Infection — 6.1%  
  3. Other — 4.2%  
  4. Medication Issue — 3.9%  
  5. Follow-up Care — 2.1%  
- **Recommendation:** Launch targeted bundles: infection prevention (SSI bundles, antibiotic stewardship), robust medication reconciliation before discharge, and 48–72 hour follow-up calls to catch complications early.

**6. How effective is our previous risk scoring tool at identifying patients who are actually readmitted?**  
- **Insight:** The readmission rate increases with higher risk scores (positive correlation). Risk 10 has the highest observed readmission proportion — this suggests the tool is predictive.  
- **Recommendation:** Perform formal validation (AUC/ROC, sensitivity, precision@k). If performance is acceptable, operationalize thresholds (e.g., risk ≥8 → auto case manager assignment). If not, retrain with additional features.

**7. Which departments have the highest readmission failure rates?**  
- **Insight:** By share:
  1. Unknown — 38%  
  2. Emergency — 27%  
  3. Pulmonology — 27%  
  4. Surgery — 26%  
  5. Cardiology — 24%  
  6. General Medicine — 23%  
  7. Orthopedics — 21%  
- **Recommendation:** Immediately fix EMR coding for “Unknown.” Audit discharge workflows in Emergency, Pulmonology, and Surgery (patient education, follow-up scheduling, discharge checklists).

**8. Which chronic patient populations are driving the largest volume of readmissions?**  
- **Insight:** Readmission rates by condition:
  1. COPD — 28%  
  2. None — 28% (investigate for missing flags)  
  3. Kidney Disease — 26%  
  4. Diabetes — 24%  
  5. Heart Disease — 22%  
  6. Hypertension — 22%  
- **Recommendation:** Create condition-specific post-discharge pathways (e.g., COPD telemonitoring, renal follow-up, diabetes coaching). Resolve “None” classification (data quality) to know whether these are truly low-comorbidity cases or missing data.

**9. What is the temporal pattern of readmissions — are they clustering in the first 30 days?**  
- **Insight:** There is a clear cluster rising up to ~30–40 days (peak ≈ 2.6%), indicating an early cluster, plus a second spike at ~100–110 days. Average is ~61.6 days but early clustering is real.  
- **Recommendation:** Prioritize early post-discharge follow-up (within 7–30 days) for high-risk patients and chronic populations. Track readmission rates by time bins (0–7, 8–30, 31–90, 90+) to measure intervention impact.

## Dashboard 3: Operations Dashboard

![Operations Dashboard](Dashboard%20Screenshots/Operations%20Dashboard.jpg)

### Business Questions, Insights & Recommendations

**1. What is the hospital's average patient wait time, and how does this compare to our service-level target?**  
- **Insight:** The dashboard shows an **Average Waiting Time = 37** (units appear to be minutes). If your target is *< 30 minutes*, we are currently missing the target by ~7 minutes.  
- **Recommendation:** Implement a fast-track for minor cases, use queuing triage (digital or RN-led), and monitor wait time by hour to deploy flexible staffing during peaks. Set a short-term target to reduce to ≤30 minutes within 60–90 days and measure progress weekly.

**2. What is the hospital's current average bed utilization rate, and are we operating near maximum capacity?**  
- **Insight:** Overall **Bed Utilization Rate = 68%**. This is below an overcrowding threshold like **85%**, so the hospital is not at critical capacity.  
- **Recommendation:** Continue monitoring daily occupancy; 68% gives operational flexibility. However, watch department-level hotspots — localized high utilization can still cause flow issues even when the hospital-wide rate is moderate.

**3. Administrative Bottlenecks: What is the total volume of discharge delays across the hospital?**  
- **Insight:** **Total Discharge Delays = 29** (KPI on the dashboard).  
- **Recommendation:** Triage those 29 cases by cause (paperwork, transport, pharmacy hold, bed cleaning). Aim to reduce delays by 50% in 90 days using discharge coordinators, morning discharge huddles, and a digital discharge checklist to ensure meds and transport are prebooked.

**4. Which specific departments are experiencing the highest bed utilization rates?**  
- **Insight:** Department-level bars show the highest utilization in:
  - Emergency ~80%  
  - Pulmonology ~76%  
  - Orthopedics ~75%  
  - General Medicine ~67%  
  - Cardiology ~52%  
  - Surgery ~51%  
  These are localized constraints primarily affecting Emergency, Pulmonology, and Orthopedics.  
- **Recommendation:** Focus surge capacity plans and additional bed/space allocation for Emergency, Pulmonology and Orthopedics. Consider short-stay units or step-down beds to relieve pressure during peaks.

**5. Are high wait times correlated with long treatment times in specific departments?**  
- **Insight:** The stacked bars (Waiting vs Treatment Time) indicate departments with both elevated wait and treatment times (e.g., Emergency shows high treatment time ~187 and wait ~70), while some departments have moderate waits but long treatment (or vice versa). This suggests correlation in certain units (not uniform across the hospital).  
- **Recommendation:** For departments where wait and treatment time are both high (Emergency, Pulmonology), target clinical process improvements (triage-to-treatment workflows, rapid diagnostics). Where wait is high but treatment short, add front-line triage personnel; where treatment is long, investigate clinical throughput (diagnostics, specialist consult delays).

**6. Is our staff-to-bed ratio appropriate across departments?**  
- **Insight:** Staff-to-bed chart shows variance: Surgery (~2.8), Cardiology (~2.7), Pulmonology (~2.6) have higher ratios; Emergency (~1.4), Orthopedics and General Medicine (~0.8) appear lower. Some departments may be under-resourced per bed.  
- **Recommendation:** Rebalance staff allocation — consider shifting float nurses to Emergency and General Medicine during peaks. Use staff-to-bed thresholds to plan hiring: target minimum nurse-to-bed levels for high-acuity departments and pilot cross-training to fill low-ratio gaps.

**7. Which departments are the primary drivers of discharge delays?**  
- **Insight:** The Staff Count vs Discharge Delays chart shows discharge delays concentrated in a few departments (the line markers show higher delays for departments like General Medicine and Surgery in the chart). Exact labeling suggests higher delays where staff counts are lower or processes are weak.  
- **Recommendation:** Audit discharge workflows in the named high-delay departments (start with the ones showing the highest delay markers). Implement morning discharge targets, pharmacy prioritization for discharge meds, and dedicated transport coordination.

**8. Is there a clear relationship between a department's staff count and frequency of discharge delays?**  
- **Insight:** The visual (Staff Count vs Discharge Delays) suggests a mixed relationship: some departments with higher staff counts still show several delays (indicating process issues beyond staff numbers), while others with low staff-to-bed ratios have higher delays indicating resource-driven backlog. In short — both staffing and process quality matter.  
- **Recommendation:** Combine staffing adjustments with process fixes. Run a quick correlation analysis (staff-per-bed vs delays) to quantify the relationship, then apply a two-track approach:
  1. Operational — reallocate or hire where staff shortages correlate strongly with delays.  
  2. Process — implement Lean interventions where delays persist despite adequate staffing.

## NEXT STEP — Implementation Roadmap
To build on the findings from all three dashboards, the next phase of this project should focus on Operational Execution, Predictive Modeling, and Continuous Monitoring:

### 1. Implement Data-Driven Interventions
Use the insights from the dashboards to design targeted action plans:
- Reduce peak waiting times by introducing triage streamlining and hourly resource allocation.  
- Address readmission drivers through improved discharge planning and chronic-care follow-up protocols.  
- Resolve administrative bottlenecks by redesigning discharge workflows and clarifying staff responsibilities.  

**Pilot departments:** Emergency, Pulmonology, Orthopedics, Cardiology.

### 2. Build a Predictive Readmission Risk Model
Using the readmission dataset, develop a machine-learning model to:
- Predict which patients are likely to be readmitted.  
- Flag high-risk diagnoses (e.g., heart failure, COPD).  
- Provide early alerts to clinicians to intervene before readmission happens.

**Modeling tools expected:** SQL for feature extraction, Python for modeling, Power BI for deployment dashboards.

### 3. Create a Real-Time Monitoring System
Integrate the dashboards into a real-time reporting cycle so leadership can:
- Track bed utilization hour-by-hour.  
- View discharge delays daily.  
- Monitor readmission KPIs weekly.

**Deployment options:**  
- Power BI Service (auto-refresh dashboard)  
- SQL Server scheduled refresh  
- Optional Supabase triggers (if building internally)

### 4. Conduct a Root-Cause Analysis Workshop
Bring clinical teams, operations managers, and administrators together to:
- Validate dashboard findings.  
- Identify workflow inefficiencies not visible in the data.  
- Co-design solutions with the people who handle these issues daily.

This guarantees your recommendations lead to actual behavior change.

### 5. Build Version 2.0 of the Dashboard Suite
Enhance the dashboards with:
- Department-level drill-downs  
- Predictive KPIs (not just descriptive)  
- Benchmarking against previous years or similar hospitals  
- Automated alerts for:
  - High wait time spikes  
  - Low staff-to-bed ratios  
  - High readmission days

This turns dashboards into a decision-support tool, not just reporting.

### 6. Present a 90-Day Improvement Plan
Summarize everything into one operational roadmap:
- **30 days:** Implement workflow changes + automate data refresh  
- **60 days:** Launch predictive modeling + department training  
- **90 days:** Release Dashboard Suite 2.0 + measure impact


