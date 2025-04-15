-- MySQL version
UPDATE orders o
JOIN branch_locator bl ON bl.branch_number = o.original_branch_number
SET o.related_branch_locator_id = bl.id
WHERE o.original_branch_number IS NOT NULL 
  AND o.original_branch_number != '' 
  AND (o.related_branch_locator_id IS NULL OR o.related_branch_locator_id != bl.id);

-- SQL Server version
UPDATE o
SET o.related_branch_locator_id = bl.id
FROM orders o
INNER JOIN branch_locator bl ON bl.branch_number = o.original_branch_number
WHERE o.original_branch_number IS NOT NULL 
  AND o.original_branch_number != '' 
  AND (o.related_branch_locator_id IS NULL OR o.related_branch_locator_id != bl.id);
