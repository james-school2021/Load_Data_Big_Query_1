WITH user_transactions AS (

    SELECT 
                        896 as user_id, 12568001 as transaction_id, 1001 as product_id, '2021-03-02' as payment_date, 19.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12568002 as transaction_id, 1002 as product_id, '2021-03-02' as payment_date, 29.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12568003 as transaction_id, 1003 as product_id, '2021-03-02' as payment_date, 39.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12568004 as transaction_id, 2001 as product_id, '2021-03-02' as payment_date, 14.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12568005 as transaction_id, 8881 as product_id, '2021-03-03' as payment_date, 42.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12568006 as transaction_id, 9020 as product_id, '2021-03-03' as payment_date, 80.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12578004 as transaction_id, 3040 as product_id, '2021-03-03' as payment_date, 34.99 as total_cost
    UNION ALL SELECT 896 as user_id, 12588005 as transaction_id, 3041 as product_id, '2021-03-08' as payment_date, 34.99 as total_cost
),

   paypal_transactions as (
        select * from unnest([
        struct
        ('07/03/2021' as dt, 'Website Payment' as type, 'Completed' as status, 'USD' as currency,  19.99 as gross, 12568001 as itemId, 'Credit' as balanceimpact)
       ,('03/03/2021', 'Website Payment', 'Completed', 'USD',  29.99, 12568002, 'Credit')
       ,('03/03/2021', 'Website Payment', 'Completed', 'USD',  39.99, 12568003, 'Credit')
       ,('03/03/2021', 'Website Payment', 'Completed', 'USD',  14.99, 12568004, 'Credit')
       ,('05/03/2021', 'Website Payment', 'Completed', 'USD',  42.99, 12568005, 'Credit')
       ,('05/03/2021', 'Website Payment', 'Completed', 'USD',  80.99, 12568006, 'Credit')
       ,('05/03/2021', 'Website Payment', 'Completed', 'USD',  34.99, 12578004, 'Credit')
       ,('04/03/2021', 'Website Payment', 'Completed', 'USD',  34.99, 12588005, 'Credit')
        ]
        ) as t
   )


select pt.dt, status, gross as confirmed_revenue_usd 
from paypal_transactions pt
inner join user_transactions ut
on ut.transaction_id = pt.itemId
where status = 'Completed'




