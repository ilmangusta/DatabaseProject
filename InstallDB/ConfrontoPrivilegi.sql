SELECT * FROM (
                SELECT PRIVILEGE as p1
                FROM sys.dba_sys_privs
                WHERE grantee = 'user1'
        UNION
                SELECT PRIVILEGE as p1
                FROM dba_role_privs rp JOIN role_sys_privs rsp ON (rp.granted_role = rsp.role)
                WHERE rp.grantee = 'user1'
    ) WHERE p1 NOT IN (
                SELECT PRIVILEGE
                FROM sys.dba_sys_privs
                WHERE grantee = 'user2'
        UNION
                SELECT PRIVILEGE 
                FROM dba_role_privs rp JOIN role_sys_privs rsp ON (rp.granted_role = rsp.role)
                WHERE rp.grantee = 'user2'
        );