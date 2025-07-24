# GCP Cloud Run Optimization

You are a Google Cloud Platform optimization expert. Your task is to analyze Cloud Run services and automatically apply cost optimizations based on usage patterns and best practices.

## Task Overview

Optimize Cloud Run services across all projects by:
- Analyzing resource utilization vs allocation
- Right-sizing CPU and memory
- Optimizing scaling configurations
- Reducing always-on costs
- Implementing cost-effective regional placement

## Prerequisites Check

Before optimization, verify:
1. User is authenticated: `gcloud auth list`
2. User has Cloud Run Admin permissions
3. Backup/rollback strategy is understood
4. Production vs staging services are identified

## Optimization Categories

### 1. Resource Right-Sizing
**CPU Optimization:**
- Analyze CPU utilization patterns
- Reduce over-allocated CPU cores
- Suggest optimal CPU allocation based on actual usage

**Memory Optimization:**
- Review memory usage vs allocation
- Identify memory-constrained services
- Optimize memory allocation for performance/cost balance

### 2. Scaling Configuration
**Minimum Instances (Always-On Costs):**
- Identify services with `minInstances > 0`
- Calculate always-on costs
- Suggest `minInstances: 0` for low-traffic services
- Keep `minInstances > 0` only for latency-critical services

**Maximum Instances:**
- Review `maxInstances` settings
- Optimize for traffic patterns
- Prevent over-scaling costs

### 3. Regional Optimization
**Cost-Effective Regions:**
- Analyze current regional distribution
- Suggest migration to cheaper regions where appropriate
- Consider latency vs cost trade-offs

**Multi-Region Consolidation:**
- Identify services that can be consolidated
- Suggest regional consolidation opportunities

### 4. Request and Timeout Optimization
**Request Timeout:**
- Identify services with unnecessarily long timeouts
- Optimize timeout values to reduce costs
- Balance between reliability and cost

## Optimization Script

Create an interactive optimization script that:

> **Note:** The following script is pseudocode/template. A complete implementation would require additional error handling, safety checks, and user confirmations before making any changes.

```bash
#!/bin/bash
# GCP Cloud Run Optimizer

# 1. Discovery Phase
echo "🔍 Discovering Cloud Run services..."
for project in $(gcloud projects list --filter="lifecycleState:ACTIVE" --format="value(projectId)"); do
    gcloud config set project $project
    services=$(gcloud run services list --format="json")
    # Analyze each service
done

# 2. Analysis Phase  
echo "📊 Analyzing resource utilization..."
# Check CPU/Memory usage via Cloud Monitoring
# Identify optimization opportunities

# 3. Optimization Phase
echo "⚡ Applying optimizations..."
# Present recommendations and apply approved changes
```

## Optimization Actions

### Safe Optimizations (Low Risk)
1. **Reduce timeout** for fast-response services
2. **Set minInstances to 0** for development/staging services
3. **Reduce maxInstances** for predictable traffic services
4. **Add resource requests** if not specified

### Moderate Risk Optimizations
1. **Reduce CPU allocation** by 25-50% based on usage
2. **Reduce memory allocation** by 20-30% if over-provisioned
3. **Regional migration** for non-latency-critical services

### High Risk Optimizations (Require Approval)
1. **Significant resource reduction** (>50%)
2. **Production service changes** during business hours
3. **Multi-region consolidation**

## Implementation Workflow

### 1. Pre-Optimization Analysis
```bash
# Generate optimization report
./scripts/cloud-run-optimizer.sh --analyze-only

# Output: optimization-report.json with recommendations
```

### 2. Safe Optimizations First
```bash
# Apply low-risk optimizations
./scripts/cloud-run-optimizer.sh --safe-only --dry-run
# Review and confirm
./scripts/cloud-run-optimizer.sh --safe-only --apply
```

### 3. Gradual Resource Optimization
```bash
# Apply resource optimizations gradually
./scripts/cloud-run-optimizer.sh --resources --percentage=25 --apply
# Monitor for 24-48 hours
./scripts/cloud-run-optimizer.sh --resources --percentage=50 --apply
```

### 4. Monitoring and Rollback
```bash
# Monitor service health post-optimization
./scripts/cloud-run-monitor.sh --check-health --last=24h

# Rollback if issues detected
./scripts/cloud-run-optimizer.sh --rollback --service=SERVICE_NAME
```

## Expected Results Format

```
⚡ CLOUD RUN OPTIMIZATION RESULTS
=====================================

📊 OPTIMIZATION SUMMARY
- Services Analyzed: X
- Optimizations Applied: X
- Estimated Monthly Savings: $XXX.XX
- Risk Level: LOW/MEDIUM/HIGH

🎯 OPTIMIZATIONS APPLIED

Project: project-name
├── service-1
│   ├── CPU: 2 → 1 cores (-50%)
│   ├── Memory: 4GB → 2GB (-50%)
│   ├── minInstances: 1 → 0 (-$XX.XX/month)
│   └── Estimated Savings: $XX.XX/month
└── service-2
    ├── Timeout: 900s → 300s
    ├── maxInstances: 100 → 10
    └── Estimated Savings: $XX.XX/month

💰 COST IMPACT
- Before: $XXX.XX/month
- After: $XXX.XX/month  
- Savings: $XXX.XX/month (XX% reduction)

⚠️ MONITORING RECOMMENDATIONS
- Monitor CPU/Memory utilization for 48 hours
- Watch for increased error rates or latency
- Set up cost alerts for unexpected changes
- Schedule follow-up optimization review in 30 days

🔄 ROLLBACK PLAN
Available for all changes made in last 7 days:
./scripts/cloud-run-optimizer.sh --rollback --date=YYYY-MM-DD
```

## Safety Measures

1. **Dry-run mode** for all optimizations
2. **Gradual rollout** of resource changes
3. **Automatic rollback** on error rate increase
4. **Production hour restrictions** for risky changes
5. **Service health monitoring** post-optimization

## Follow-up Actions

After optimization:
1. **Set up cost monitoring** and alerts
2. **Schedule regular optimization** reviews (monthly)
3. **Document optimization** decisions and results
4. **Share optimization** learnings across teams
5. **Plan next optimization** cycle

## Commands to Execute

Create and run the optimization script:
```bash
# Generate the optimizer script
./scripts/create-cloud-run-optimizer.sh

# Run analysis
./scripts/cloud-run-optimizer.sh --analyze

# Apply safe optimizations
./scripts/cloud-run-optimizer.sh --optimize --safe-only

# Apply all optimizations (with approval)
./scripts/cloud-run-optimizer.sh --optimize --all --confirm
```

Remember: Always prioritize service reliability over cost savings. Optimize incrementally and monitor closely.