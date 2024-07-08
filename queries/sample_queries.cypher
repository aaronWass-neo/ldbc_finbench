

// Read Queries

// setting example parameters
:param companyId => "1177"
:param personId => "2036"

// 1 hop reads

match (p:Person)-[:INVEST]->(c:Company)
where p.personId = $personId
return p.personId, c.companyName

match (p:Person)-[:APPLY]->(l:Loan)
where p.personId = $personId
return l.loanId

// 2 hop reads 

match (p:Person)-[:APPLY]->(l:Loan)-[:DEPOSIT]->(a:Account)
where p.personId = $personId
return l.loanId, a.accountId

match (c:Company)-[:OWN]->(a:Account)-[r:REPAY]->(l:Loan)
where c.companyId = $companyId
return a.accountId, r.createTime, r.amount, l.loanId


// multi-hop & global reads 

// global query for finding most diverse Person investor
match (p:Person)-[:INVEST]->(c:Company)
return p.personId, count(c) order by count(c) desc limit 10 


// wildcard path query for a Person. Return count of  nodes within x hops from a person 
match (p:Person)-[*..5]->(x)
where p.personId = $personId
return count(x)