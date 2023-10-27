SELECT PRIVILEGE as p1
FROM sys.dba_sys_privs
WHERE grantee = ''     --USERNAME
UNION
SELECT PRIVILEGE as p1
FROM dba_role_privs rp JOIN role_sys_privs rsp ON (rp.granted_role = rsp.role)
WHERE rp.grantee = ''  --USERNAME