SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' COLLATE Latin1_General_BIN
  AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^a-zA-Z0-9_.-]%' COLLATE Latin1_General_BIN;