-- client queries 

-- get IPO data of a stock given a stock identifier
select PricePerShare, NumShares from IPO 
where eventID = (select ID from Event where stockID = (select ID from Stock where Symbol = '{stock_symbol}') and Type = 'IPO');

-- get all IPO data 
select Stock.Symbol, IPO.PricePerShare, IPO.NumShares, Event.Date
from Stock inner join Event on Stock.ID = Event.stockID
inner join IPO on IPO.eventID = Event.ID;

-- get all bankruptcies 
select Stock.Symbol,Bankruptcy.FilingType, Event.Date 
from Event inner join on Event.stockID = Stock.ID 
inner join Bankruptcy on Bankruptcy.eventID = Event.ID; 

-- given a stock symbol find all analyst ratings for that particular stock symbol
select Date, Rating, TargetPrice from AnalystRating
where stockID = (select ID from Stock where Symbol = '{stock_symbol}');

-- given a stock symbol find all analyst ratings for that particular stock symbol with a particular rating
select Date, Rating, TargetPrice from AnalystRating
where stockID = (select ID from Stock where Symbol = '{stock_symbol}')
and Rating = '{rating}'; 

-- find all ratings an analyst has given 
select Stock.Symbol, AnalystRating.Date, AnalystRating.Rating, AnalystRating.TargetPrice
from AnalystRating inner join Stock on AnalystRating.stockID = Stock.ID
where analystID = '{analyst_uuid}';

-- find an analyst firm's name
select Firm.Name from Analyst
inner join Firm on Firm.ID = Analyst.firmID
where analyst.ID = '{analyst_uuid}';

-- get ALL financial data
select Stock.Symbol, FD.Year, FD.Revenue, FD.RevenueGrowth, FD.CostofRevenue, FD.GrossProfit, FD.RDExpenses, FD.SGAExpenses, FD.OperatingExpenses, FD.OperatingIncome, FD.InterestExpense
from Stock inner join FinancialData as FD on Stock.ID = FD.stockID;

-- get Financial data for a particular stock 
select Year, Revenue, RevenueGrowth, CostofRevenue, GrossProfit, RDExpenses, SGAExpenses, OperatingExpenses, OperatingIncome, InterestExpense
from FinancialData
where stockID = (select ID from Stock where Symbol = '{stock_symbol}');

-- get ALL Trading Data for a stock 
select Date, Volume, Open, High, Close, Low, AdjustedClose from 
TradingData where stockID = (select ID from Stock where Symbol = '{stock_symbol}');

-- compare two stocks side by side
select s1.Date as Date, s1.Volume as first_stock_volume, s1.Close as first_stock_price, s2.Volume as second_stock_volume, s2.Close as second_stock_price
from TradingData as s1 inner join TradingData as s2 on s1.Date = s2.Date
where s1.stockID = (select ID from Stock where Symbol = '{stock_symbol1}') and
s2.stockID = (select ID from Stock where Symbol = '{stock_symbol2}');

-- compute correlation of two stock symbols 
select CORR_S(s1.Close, s2.Close) as Spearman_Correlation_Coeff from 
TradingData as s1 inner join TradingData as s2 on s1.Date = s2.Date
where s1.stockID = (select ID from Stock where Symbol = '{stock_symbol1}') and
s2.stockID = (select ID from Stock where Symbol = '{stock_symbol2}');


