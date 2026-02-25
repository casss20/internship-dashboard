# DUPLICATE PREVENTION SYSTEM
# Anthony Casseus Internship Tracker

## Duplicate Detection Rules

### Check Order (Run in sequence):

**CHECK 1: Same Job URL**
- Does this exact Job URL already exist in tracker?
- → **SKIP** if yes
- Log reason: "Same Job URL already exists"

**CHECK 2: Same Company + Role**
- Does Company + Role Title combination already exist?
- → **SKIP** if yes  
- Log reason: "Same Company + Role combination exists"

**CHECK 3: Same Company, Different Role**
- Does this Company exist with a different role?
- → **FLAG for review**
- Log reason: "Company exists with different role"

**CHECK 4: Applied Within 6 Months**
- Has it been less than 6 months since applied to this company?
- → **FLAG for review**
- Log reason: "Applied to this company within last 6 months"

**CHECK 5: Cooling Off Period (90 days)**
- Was this company rejected within last 90 days?
- → **COOLING OFF** - Do not apply
- Calculate: Eligible again on [rejection date + 90 days]
- Log reason: "Cooling off period until [date]"

---

## Edge Cases

| Scenario | Action |
|----------|--------|
| Same company, same role, different location | **SKIP** - treat as duplicate |
| Same company, same role, different term (Summer vs Fall) | **APPLY** - treat as separate |
| Same job on multiple platforms (LinkedIn + Greenhouse) | **APPLY ONCE** - log both URLs |
| Role title slightly different, same URL | **SKIP** - URL check catches it |
| Role title same, different URLs | **FLAG** - manual review needed |

---

## When Duplicate Detected

### SKIP Action:
1. Add to "Skipped Duplicates" sheet
2. Record: Date, Company, Role, URL, Reason, Original App ID, Original Date
3. Send Telegram: "⚠️ Skipped duplicate: [Company] - [Role] — already applied on [date]"
4. Do NOT apply

### FLAG Action:
1. Add to "Flagged for Review" sheet
2. Record: Date, Company, Role, URL, Reason, Existing App ID, Existing Role
3. Send Telegram: "🚩 Flagged for review: [Company] - [Role] — [reason]"
4. Wait for user approval before applying

### COOLING OFF Action:
1. Update "Cooling Off Until" column in main tracker
2. Send Telegram: "❄️ Cooling off: [Company] — eligible again on [date]"
3. Do NOT apply until date passes

---

## New Tracker Columns

| Column | Purpose |
|--------|---------|
| Application ID | Unique ID (APP-001, APP-002, etc.) |
| Duplicate Check | Status: Passed / Flagged / Skipped / Cooling Off |
| Rejection Date | When rejection received (for cooling off calc) |
| Cooling Off Until | Date when can apply again (90 days after rejection) |

---

## Sheets

1. **Applications** - Main tracker with all applications
2. **Summary** - Metrics and statistics
3. **Skipped Duplicates** - All skipped duplicates log
4. **Flagged for Review** - Items needing user decision

---

## Daily Audit Process

1. Scrape all sources for new opportunities
2. For each new posting found:
   - Run duplicate checks 1-5
   - If PASSED → Add to Applications queue
   - If SKIP → Add to Skipped Duplicates
   - If FLAG → Add to Flagged for Review
   - If COOLING OFF → Update tracker, skip
3. Report in daily Telegram:
   - New opportunities found: X
   - Duplicates skipped: X
   - Flagged for review: X
   - In cooling off: X

---

## Example Telegram Messages

**Skip:**
> ⚠️ Skipped duplicate: Scale AI - ML Research Intern — already applied on 2026-02-25

**Flag:**
> 🚩 Flagged for review: Google - Software Engineer — Company exists with different role (Data Science Intern)

**Cooling Off:**
> ❄️ Cooling off: Meta - Software Engineering Intern — eligible again on 2026-05-25

---

Last Updated: 2026-02-25
System Status: ACTIVE
