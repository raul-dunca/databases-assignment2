ALTER TABLE Teams
DROP COLUMN tRegion;

INSERT INTO Teams (tid,tName,tCreated,oid)
values (7,'Fnatic','2011-03-11','1')

INSERT INTO Teams(tid,tName,oid,lid,tCreated)
values (1,'SK Telecom T1',2,2,'2014-12-21')

INSERT INTO Leagues(lid,LName,LDifficulty,LPrize)
values (5,'North American Championship','easy','55000')

INSERT INTO Teams(tid,tName,oid,lid,tCreated)
values (3,'Team Liquid',2,2,'2014-12-21')


UPDATE Teams
SET oid = null
WHERE tid =3

UPDATE Players
SET pRealName = 'Martin Nordahl Hansen'
WHERE pid =4

INSERT INTO Owners(oid,oName,oEmail,oDob)
values (2,'Tyler One','tyler.o@gmail.com','1995-03-07')

INSERT INTO Leagues(lid,LName,LDifficulty,LPrize)
values (2,'Korea Championship','hard','100000')

INSERT INTO Partners(Paid,PaName,PaRevenue)
values(3,'Logitech G',5000)

INSERT INTO Partners(Paid,PaName,PaRevenue)
values(5,'Razer',8000)

INSERT INTO Is_Partner(tid,Paid,Since)
values(1,1,'2016-05-26')

INSERT INTO Is_Partner(tid,Paid,Since)
values(1,3,'2017-02-26')

INSERT INTO Is_Partner(tid,Paid,Since)
values(123,3,'2016-08-14')

INSERT INTO Is_Partner(tid,Paid,Since)
values(123,5,'2016-08-14')

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(3,'Faker',1,'Mid','Lee Sang-hyeok','Korea','1996-06-07')

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(4,'Wunder',7,'Top','	Martin Nordahl Hansen','Denmark','1998-11-09')

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(5,'Gumayusi',1,'Adc','Lee Min-hyeong','Korea','2002-02-09')

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(6,'Zeus',1,'Top','Choi Woo-je','Korea','2004-01-31')

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(7,'Targamas',123,'Support','Raphaël Crabbé','Belgium','2000-07-1')

INSERT INTO Coaches(coid,CoName,tid,CoEmail,CoDaob)
values(2,'Felix Lengel',1,'felix.len@gmail.com','1992-05-02')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(4,'Ezreal','Marksman','Medium')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(5,'Nami','Enchanter','Medium')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(6,'Blitzcrank','Tank','Medium')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(7,'Azir','Mage','Hard')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(8,'Jayce','Fighter','Medium')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(9,'Renekton','Fighter','Medium')

INSERT INTO Champions(Cid,CName,CRole,CDifficulty)
values(10,'Draven','Marksman','Hard')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(1,3,7,5,0,3,'Lose')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(1,3,7,5,0,3,'Lose')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(1,6,9,0,8,3,'Lose')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(1,5,4,3,4,1,'Lose')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(2,4,8,3,2,2,'Lose')


INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(2,3,3,12,3,8,'Win')

INSERT INTO Match_Details(Mid,Pid,Cid,MHkills,MHdeaths,MHassists,MHoutcome)
values(2,6,9,3,1,2,'Win')

INSERT INTO Abilities(abid,AbName,Cid,AbType,AbManaCost,AbColldown)
values(2,'Arise',7,'W',40,9)

INSERT INTO Abilities(abid,AbName,Cid,AbType,AbManaCost,AbColldown)
values(5,'Mystic Shot',4,'Q',25,8)

INSERT INTO Abilities(abid,AbName,Cid,AbType,AbManaCost,AbColldown)
values(3,'Shifting Sands',7,'E',60,22)

INSERT INTO Abilities(abid,AbName,Cid,AbType,AbManaCost,AbColldown)
values(4,'Spinning Axe',10,'Q',45,12)

INSERT INTO Partners(Paid,PaName,PaRevenue)
values(1,'CEVA',5000)

DELETE from Is_Partner 
WHERE tid=1 and Paid=1

UPDATE Partners
SET PaRevenue = 2000
WHERE PaRevenue<1000;

DELETE from Teams 
WHERE tName is NULL

UPDATE Is_Partner
SET Since = null
WHERE Paid IN(
Select p.Paid  From Partners P
WHERE P.PaRevenue BETWEEN 0 AND 3000
)

UPDATE Teams
SET tCreated = null
WHERE tName LIKE '^[a-z]%';

/* a) */
SELECT DISTINCT pRealName 
FROM  Players
WHERE pRole='Mid' or pRole='Top'

SELECT *
FROM Champions
WHERE CRole='Tank'
Union
SELECT *
From Champions
Where CRole='Fighter'

/* b) */
SELECT * 
FROM  Players
WHERE pRole='Mid'
INTERSECT
SELECT * 
FROM Players
WHERE pNationality='Korea'

SELECT *
FROM Teams
WHERE tid IN (
SELECT tid
FROM Is_Partner
WHERE Paid=1
)

/* c) */
SELECT DISTINCT pNickname
FROM Players
WHERE pid NOT IN (
SELECT Pid
FROM Match_Details
WHERE MHoutcome='Lose')

SELECT *
FROM Champions
EXCEPT
SELECT *
FROM Champions
WHERE Cid IN
(SELECT Cid
FROM Match_Details)

/* d) */
SELECT P.pNickname,P.pRole,T.tid,(SELECT COUNT(*) FROM Players WHERE P.pTeam>2) as Cnt
FROM Players P INNER JOIN Teams T ON T.tid=P.pTeam
INNER JOIN Leagues L ON T.lid=L.lid
WHERE L.LPrize>2000

SELEct * FROM Players
SELECT * FROM Leagues
SELECT * FROM Teams

SELECT P.pNickname, C.CName,MD.MHkills,MD.MHdeaths,MD.MHassists,((MD.MHkills+MD.MHassists)/MD.MHdeaths) as KDA,M.MLength,MD.MHoutcome 
FROM Match_Details MD LEFT JOIN 
Players P ON P.pid=MD.Pid 
LEFT JOIN Matches M ON M.Mid=MD.Mid
LEFT JOIN Champions C ON C.Cid=MD.Cid

SELECT *
FROM Coaches C RIGHT JOIN Teams T ON C.tid=T.tid;

SELECT *
FROM Teams T FULL JOIN Owners O ON T.oid=O.oid;

/* e) */

Select * 
FROM Players
WHERE pid IN
(
SELECT pid
FROM Match_Details
WHERE (
(MHkills+MHassists)/MHdeaths >3)            
)

Select * 
FROM Players
WHERE pid IN
(SELECT pid
FROM Match_Details 
WHERE Cid IN (
SELECT Cid
FROM Champions
WHERE CDifficulty='Medium' and CRole='Marksman')     
)

/* f) */

SELECT * 
FROM TEAMS T
WHERE EXISTS(
SELECT * FROM Is_Partner P
WHERE Since<'2015-06-26' AND T.tid=P.tid         
)

SELECT DISTINCT TOP 5  P.pRealName							
FROM Players P
WHERE EXISTS (
SELECT *
FROM Match_Details MD
WHERE MD.Pid=P.pid 
)
ORDER BY P.pRealName;                             -


/* g) */

SELECT TOP 5 P.pNickname,T.tName,P.pDob              
FROM (
Leagues L  JOIN Teams T on L.lid=T.lid and L.LName='European Championship'
JOIN Players P ON T.tid=P.pTeam)
ORDER BY P.pDob DESC                             

SELECT C.CName, M.MServer            
FROM (
Matches M Join Match_Details MD on M.Mid=MD.Mid
RIGHT JOIN Champions C ON MD.Cid=C.Cid
)
 
 /* h) */
 
 SELECT P.pid,P.pNickname,P.pRole
 FROM Players P
 WHERE P.pid IN (
 SELECT MD.Pid
 FROM Match_Details MD
 GROUP BY MD.Pid
 HAVING 1=(                        
SELECT COUNT(*)
FROM Match_Details MD2
WHERE MD2.Pid= MD.Pid)
)

SELECT P.Paid, MIN(P.Since) as OldestPartner
FROM Is_Partner P
GROUP BY P.Paid
HAVING 1<(
SELECT COUNT(*)
FROM Is_Partner P2
WHERE P.Paid=P2.Paid
)

 SELECT COUNT(P.pid) as NrofPlayers, P.pRole,MAX(P.pDob) as YoungestOnRole
FROM Players P
GROUP BY P.pRole


SELECT MD.Cid, AVG((MD.MHkills+MD.MHassists)/MD.MHdeaths) as AvgKda
FROM Match_Details MD
GROUP BY MD.Cid
HAVING AVG((MD.MHkills+MD.MHassists)/MD.MHdeaths) >5

/* i) */

--1)
SELECT *,((MD.MHkills+MD.MHassists)/MD.MHdeaths) as KDA
FROM Match_Details MD 
WHERE MD.MHdeaths=ANY
(
SELECT MD2.MHdeaths 
FROM Match_Details MD2 
WHERE MD2.Cid=8
)

--Rewrite
SELECT *,((MD.MHkills+MD.MHassists)/MD.MHdeaths) as KDA
FROM Match_Details MD 
WHERE MD.MHdeaths IN
(
SELECT MD2.MHdeaths 
FROM Match_Details MD2 
WHERE MD2.Cid=8
)

--2)
SELECT *
FROM Players P
WHERE P.pDob>ALL
(
SELECT P2.pDob
FROM Players P2
WHERE P2.pTeam=123
)

--Rewrite
SELECT *
FROM Players P
WHERE P.pDob >
(
SELECT MAX(P.pDob)
FROM Players P
WHERE P.pTeam=123
)

--3)
SELECT * 
FROM Partners P
WHERE P.PaRevenue<>ALL
(
SELECT P2.PaRevenue 
FROM  Is_Partner Pa2  JOIN Partners P2 ON Pa2.Paid=P2.Paid
WHERE Pa2.Since>'2015-01-01'
)

--Rewrite
SELECT * 
FROM Partners P
WHERE P.PaRevenue NOT IN
(
SELECT P2.PaRevenue 
FROM  Is_Partner Pa2  JOIN Partners P2 ON Pa2.Paid=P2.Paid
WHERE Pa2.Since>'2015-01-01'
)

--4)
SELECT *
FROM Abilities A
WHERE A.AbColldown>ANY
(
SELECT A2.AbColldown
FROM Abilities A2
WHERE A2.AbType='Q'
)

--Rewrite
SELECT *
FROM Abilities A
WHERE A.AbColldown>
(
SELECT MIN(A2.AbColldown)
FROM Abilities A2
WHERE A2.AbType='Q'
)


SELECT * FROM Players
SELECT * FROM Champions
SELECT * FROM Match_Details
SELECT * FROM Matches

SELECT * FROM Teams
SELECT * FROM Owners
SELECT * FROM Partners
SELECT * FROM Is_Partner
SELECT * FROM Players
SELECT * FROM Coaches
SELECT * FROM Leagues
SELECT * FROM Champions
SELECT * FROM Match_Details
SELECT * FROM Matches
SELECT * FROM Abilities
SELECT * FROM Champions