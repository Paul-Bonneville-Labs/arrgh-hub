# Prisma Migration Safety Check

## Description
Validates Prisma migrations by comparing current branch schema against main branch production schema to ensure safe deployment.

## Implementation

### Step 1: Schema Comparison
1. **Compare schemas**: Generate diff between current branch schema and main branch schema
2. **Identify changes**: Show exactly what database changes will be made
3. **Flag conflicts**: Check if migrations assume schema state that doesn't match main

### Step 2: Migration Validation
1. **Check migration files**: Verify migration SQL matches schema changes
2. **Validate assumptions**: Ensure migrations don't drop non-existent columns or tables
3. **Test migration path**: Simulate applying migrations to main branch schema state

### Step 3: Safety Checks
1. **Backwards compatibility**: Warn about breaking changes
2. **Data loss risk**: Flag operations that could lose data
3. **Production readiness**: Verify migrations will succeed on main branch database state

### Step 4: Generate Report
1. **Migration summary**: List all changes that will be applied
2. **Risk assessment**: Categorize changes by risk level (safe/warning/danger)
3. **Action plan**: Provide clear next steps for safe deployment

## Usage
```bash
/prisma-migration-check
```

## Output Format
```
=== PRISMA MIGRATION SAFETY CHECK ===

BRANCH: feature/implement-notebooks
COMPARING TO: main

SCHEMA CHANGES:
✅ Safe: Add notebooks table
⚠️  Warning: Rename page_title to note_title 
❌ Risk: Drop page_title column (may not exist on main)

MIGRATION VALIDATION:
- Found 1 migration: 20250816062218_add_notebooks
- Migration assumes page_title column exists
- Main branch schema: page_title column status unknown

RECOMMENDATIONS:
1. Check if page_title exists on main branch production
2. Make column drop conditional: IF EXISTS
3. Test migration against main branch database

NEXT STEPS:
[ ] Fix migration to handle missing columns
[ ] Test locally against main schema
[ ] Deploy with confidence
```