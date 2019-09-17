
-- Welcome to your first dbt model!
-- Did you know that you can also configure models directly within
-- the SQL file? This will override configurations stated in dbt_project.yml

-- Try changing 'view' to 'table', then re-running dbt
{{ config(materialized='table') }}


select name,count(*) from recomendacao_app."produtos"
group by name
order by 2 desc
limit 10