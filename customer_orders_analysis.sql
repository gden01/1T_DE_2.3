-- Создаем временную таблицу "CustomerTotalOrders" с общей суммой заказов для каждого клиента
WITH CustomerTotalOrders AS (
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        SUM(o.TotalAmount) AS TotalOrderAmount
    FROM
        Customers c
    INNER JOIN
        Orders o ON c.CustomerID = o.CustomerID
    GROUP BY
        c.CustomerID, c.FirstName, c.LastName
),
-- Вычисляем среднюю общую сумму заказов всех клиентов
AverageTotalOrderAmount AS (
    SELECT
        AVG(TotalOrderAmount) AS AvgTotalAmount
    FROM
        CustomerTotalOrders
)
-- Выбираем клиентов и их заказы, у которых общая сумма заказов превышает среднюю
SELECT
    cto.FirstName,
    cto.LastName,
    o.OrderID,
    o.TotalAmount
FROM
    CustomerTotalOrders cto
INNER JOIN
    Orders o ON cto.CustomerID = o.CustomerID
CROSS JOIN
    AverageTotalOrderAmount
WHERE
    cto.TotalOrderAmount > AvgTotalAmount
-- Сортируем результаты по общей сумме заказов клиентов и общей сумме заказов внутри каждого клиента
ORDER BY
    cto.TotalOrderAmount DESC, o.TotalAmount DESC;
