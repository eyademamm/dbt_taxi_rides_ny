{% macro get_payment_type(payment_type) %}
    case 
        when payment_type = 1 then 'credit card'
        when payment_type = 2 then 'cash'
        when payment_type = 3 then 'no charge'
        when payment_type = 4 then 'dispute'
        when payment_type = 5 then 'unknown'
    end
{% endmacro %}