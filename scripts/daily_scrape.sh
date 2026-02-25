#!/bin/bash
# Daily Internship Scraping Script for Anthony Casseus
# Runs daily to check all sources for new Summer/Fall 2026 internships

echo "=== Daily Internship Search - $(date) ==="

# GitHub Repos (check for new commits/rows)
echo "Checking GitHub internship repos..."

# SimplifyJobs
curl -s "https://api.github.com/repos/SimplifyJobs/Summer2026-Internships/commits?since=$(date -d '1 day ago' -I)" | grep -q '"sha"' && echo "NEW: SimplifyJobs repo updated"

# pittcsc
curl -s "https://api.github.com/repos/pittcsc/Summer2026-Internships/commits?since=$(date -d '1 day ago' -I)" | grep -q '"sha"' && echo "NEW: pittcsc repo updated"

# Wellfound (AngelList) - AI/ML/Cyber/SWE
echo "Checking Wellfound..."
# Note: Requires scraping or API access

echo "=== Daily Check Complete ==="
echo "Next check: $(date -d '+1 day')"
