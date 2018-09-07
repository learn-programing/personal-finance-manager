#!/usr/bin/env bash -e

# Script works correctly only on clean database - will fail if any entry already exists (e.g. account name)

# Register user
curl --request POST --url http://localhost:8088/users/register --header 'Authorization: Basic cGtvbGFjejpQaW9EZXYxMDEx' --header 'Cache-Control: no-cache' --header 'Content-Type: application/json' --header 'Postman-Token: b331a4d8-3a61-4192-ba4a-e3b3289342a6' --data '{"firstName":"Piotr","lastName":"Kołacz","username":"piotr","password":"piotr123"}'

# Add accounts
ACCOUNT_ALIOR_PLN=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 0, \"name\": \"kantor Alior - PLN\"}")
echo "$ACCOUNT_ALIOR_PLN"

ACCOUNT_ALIOR_USD=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 85980, \"name\": \"kantor Alior - USD\"}")
echo "$ACCOUNT_ALIOR_USD"

ACCOUNT_ALIOR_EUR=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 2617.22, \"name\": \"kantor Alior - EUR\"}")
echo "$ACCOUNT_ALIOR_EUR"

ACCOUNT_ALIOR_GBP=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 0, \"name\": \"kantor Alior - GBP\"}")
echo "$ACCOUNT_ALIOR_GBP"

ACCOUNT_IDEA=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 14374.23, \"name\": \"Idea Bank\"}")
echo "$ACCOUNT_IDEA"

ACCOUNT_IKE=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 12789.00, \"name\": \"IKE\"}")
echo "$ACCOUNT_IKE"

ACCOUNT_IKZE=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 5115.60, \"name\": \"IKZE\"}")
echo "$ACCOUNT_IKZE"

ACCOUNT_CASH=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 193.42, \"name\": \"Gotówka\"}")
echo "$ACCOUNT_CASH"

ACCOUNT_CASH_EUR=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": 84.43, \"name\": \"Gotówka - euro\"}")
echo "$ACCOUNT_CASH_EUR"

ACCOUNT_ANIA_BALANCE=$(curl -X POST "http://localhost:8088/accounts" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"balance\": -6411.46, \"name\": \"Ania - rozliczenie\"}")
echo "$ACCOUNT_ANIA_BALANCE"

# Add categories
CATEGORY_INCOME=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Przychody\"}")
echo "$CATEGORY_INCOME"

CATEGORY_CHILD=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Dziecko\"}")
echo "$CATEGORY_CHILD"

CATEGORY_BILLS=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Rachunki\"}")
echo "$CATEGORY_BILLS"

CATEGORY_TRANSFER=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Przelewy między kontami\"}")
echo "$CATEGORY_TRANSFER"

CATEGORY_MONTH_SUMMARY=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Rozliczenie miesiąca\"}")
echo "$CATEGORY_MONTH_SUMMARY"

CATEGORY_FOOD_OUTSIDE=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Jedzenie\"}")
echo "$CATEGORY_FOOD_OUTSIDE"

CATEGORY_DIVING=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Nurkowanie\"}")
echo "$CATEGORY_DIVING"

CATEGORY_HEALTH=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Leki i lekarze\"}")
echo "$CATEGORY_HEALTH"

CATEGORY_COSMETICS=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Kosmetyki\"}")
echo "$CATEGORY_COSMETICS"

CATEGORY_TRANSPORT=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Transport\"}")
echo "$CATEGORY_TRANSPORT"

CATEGORY_CURRENCY_EXCHANGE=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Wymiana walut\"}")
echo "$CATEGORY_CURRENCY_EXCHANGE"

CATEGORY_ACCOMMODATION=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Wyjazdy - noclegi\"}")
echo "$CATEGORY_ACCOMMODATION"

CATEGORY_ENTERTAINMENT=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Rozrywka\"}")
echo "$CATEGORY_ENTERTAINMENT"

CATEGORY_PHONE=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Telefon\"}")
echo "$CATEGORY_PHONE"

CATEGORY_SHOPPING=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Zakupy\"}")
echo "$CATEGORY_SHOPPING"

CATEGORY_SHOPPING_FOOD=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Zakupy - jedzenie\"}, \"parentCategoryId\": $CATEGORY_SHOPPING}")
echo "$CATEGORY_SHOPPING_FOOD"

CATEGORY_RENOVATION=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Remont domu\"}")
echo "$CATEGORY_RENOVATION"

CATEGORY_INCOME_CROSSOVER=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Crossover\", \"parentCategoryId\": $CATEGORY_INCOME}")
echo "$CATEGORY_INCOME_CROSSOVER"

CATEGORY_INCOME_OTHER=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Inne Przychody\", \"parentCategoryId\": $CATEGORY_INCOME}")
echo "$CATEGORY_INCOME_OTHER"

CATEGORY_COMPANY_COSTS=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Koszty prowadzenia firmy\"}")
echo "$CATEGORY_COMPANY_COSTS"

CATEGORY_COMPANY_ZUS=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"ZUS\", \"parentCategoryId\": $CATEGORY_COMPANY_COSTS}")
echo "$CATEGORY_COMPANY_ZUS"

CATEGORY_COMPANY_ACCOUNTANT=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Księgowość\", \"parentCategoryId\": $CATEGORY_COMPANY_COSTS}")
echo "$CATEGORY_COMPANY_ACCOUNTANT"

CATEGORY_COMPANY_INCOME_TAX=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Podatek dochodowy\", \"parentCategoryId\": $CATEGORY_COMPANY_COSTS}")
echo "$CATEGORY_COMPANY_INCOME_TAX"

CATEGORY_COMPANY_VAT=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"VAT\", \"parentCategoryId\": $CATEGORY_COMPANY_COSTS}")
echo "$CATEGORY_COMPANY_VAT"

CATEGORY_COMPANY_LEASING=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Leasing samochodu\", \"parentCategoryId\": $CATEGORY_COMPANY_COSTS}")
echo "$CATEGORY_COMPANY_LEASING"

CATEGORY_CAR=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Samochód\"}")
echo "$CATEGORY_CAR"

CATEGORY_CAR_FUEL=$(curl -X POST "http://localhost:8088/categories" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"Paliwo\", \"parentCategoryId\": $CATEGORY_CAR}")
echo "$CATEGORY_CAR_FUEL"

# Transactions - January
curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_INCOME_CROSSOVER, \"date\": \"2018-01-04\", \"description\": \"Crossover 18-24.12\", \"price\": 7165.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_INCOME_OTHER, \"date\": \"2018-01-04\", \"description\": \"Idea Bank Premia\", \"price\": 50.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_COMPANY_ZUS, \"date\": \"2018-01-05\", \"description\": \"ZUS - Styczeń\", \"price\": -473.20}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_COMPANY_INCOME_TAX, \"date\": \"2018-01-15\", \"description\": \"Podatek dochodowy Q4 2017\", \"price\": -5746.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_COMPANY_VAT, \"date\": \"2018-01-15\", \"description\": \"VAT Q4 2017\", \"price\": -759}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_INCOME_CROSSOVER, \"date\": \"2018-01-18\", \"description\": \"Crossover Interviews - Grudzień\", \"price\": 985.19}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_CURRENCY_EXCHANGE, \"date\": \"2018-01-03\", \"description\": \"USD -> EUR\", \"price\": -3582.51}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_CURRENCY_EXCHANGE, \"date\": \"2018-01-03\", \"description\": \"USD -> EUR\", \"price\": 3513.57}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CURRENCY_EXCHANGE, \"date\": \"2018-01-03\", \"description\": \"USD -> EUR - Ania zwrot\", \"price\": 34.47}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-06\", \"description\": \"Noclegi Gran Canaria\", \"price\": -4418.60}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-06\", \"description\": \"Noclegi Gran Canaria - Ania zwrot\", \"price\": 2209.30}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_DIVING, \"date\": \"2018-01-07\", \"description\": \"Nurkowanie - Top Diving Gran Canaria\", \"price\": -542.72}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-06\", \"description\": \"Jedzenie\", \"price\": -195.04}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-06\", \"description\": \"Jedzenie - Ania zwrot\", \"price\": 97.52}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-08\", \"description\": \"Audioteka\", \"price\": -19.90}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-10\", \"description\": \"Noclegi Fuerteventura - zaliczka\", \"price\": 979.23}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_TRANSPORT, \"date\": \"2018-01-10\", \"description\": \"Prom Fuerteventura\", \"price\": -565.28}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-06\", \"description\": \"Prom Fuerteventura\", \"price\": 282.64}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_DIVING, \"date\": \"2018-01-14\", \"description\": \"Nurkowanie - Las Palmas Gran Canaria\", \"price\": -468.31}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_CURRENCY_EXCHANGE, \"date\": \"2018-01-13\", \"description\": \"USD -> EUR\", \"price\": -985.18}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_CURRENCY_EXCHANGE, \"date\": \"2018-01-13\", \"description\": \"USD -> EUR\", \"price\": 950.14}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_COMPANY_ACCOUNTANT, \"date\": \"2018-01-09\", \"description\": \"Księgowy - Styczeń\", \"price\": -123.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_COMPANY_LEASING, \"date\": \"2018-01-26\", \"description\": \"Leasing - styczeń\", \"price\": -2308.97}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_COMPANY_LEASING, \"date\": \"2018-01-26\", \"description\": \"Leasing - styczeń - Ania zwrot\", \"price\": 1154.49}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_PHONE, \"date\": \"2018-01-18\", \"description\": \"Telefon\", \"price\": -21.34}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_CAR_FUEL, \"date\": \"2018-01-26\", \"description\": \"Paliwo\", \"price\": -239.50}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CAR_FUEL, \"date\": \"2018-01-26\", \"description\": \"Paliwo - Ania zwrot\", \"price\": 119.75}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_SHOPPING, \"date\": \"2018-01-26\", \"description\": \"Zakupy\", \"price\": -150}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_SHOPPING, \"date\": \"2018-01-26\", \"description\": \"Zakupy - Ania zwrot\", \"price\": 75}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_INCOME_CROSSOVER, \"date\": \"2018-01-18\", \"description\": \"Crossover 01-07.01\", \"price\": 7165.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-06\", \"description\": \"Jedzenie\", \"price\": -135.68}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-06\", \"description\": \"Jedzenie - Ania zwrot\", \"price\": 67.84}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-10\", \"description\": \"Noclegi Fuerteventura \", \"price\": -979.23}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_DIVING, \"date\": \"2018-01-21\", \"description\": \"Nurkowanie - North Gran Canaria\", \"price\": -148.40}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_USD, \"categoryId\": $CATEGORY_INCOME_CROSSOVER, \"date\": \"2018-01-25\", \"description\": \"Crossover 08-14.01\", \"price\": 7165.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Alior PLN\", \"price\": -27.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_PLN, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Alior PLN\", \"price\": 27.00}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_IDEA, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Ania PLN\", \"price\": -4398.50}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Ania PLN\", \"price\": 4398.50}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ALIOR_EUR, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Ania PLN\", \"price\": 546.90}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Przelew Ania PLN\", \"price\": -546.9}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_CASH_EUR, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Gotowka Ania EUR\", \"price\": 21.57}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_TRANSFER, \"date\": \"2018-01-25\", \"description\": \"Gotowka Ania EUR\", \"price\": -21.57}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CHILD, \"date\": \"2018-01-31\", \"description\": \"Wydatki na dziecko\", \"price\": -34.11}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_BILLS, \"date\": \"2018-01-31\", \"description\": \"Rachunki\", \"price\": -811.68}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CAR, \"date\": \"2018-01-31\", \"description\": \"Wymiana szyby\", \"price\": -1351.79}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CAR, \"date\": \"2018-01-31\", \"description\": \"Inne wydatki\", \"price\": -20.15}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CAR_FUEL, \"date\": \"2018-01-31\", \"description\": \"Paliwo\", \"price\": -125.25}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_CAR, \"date\": \"2018-01-31\", \"description\": \"Parkingi\", \"price\": -15.42}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_TRANSPORT, \"date\": \"2018-01-31\", \"description\": \"Promy\", \"price\": -254.36}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_ACCOMMODATION, \"date\": \"2018-01-31\", \"description\": \"Noclegi Fuerta\", \"price\": -2064.96}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_FOOD_OUTSIDE, \"date\": \"2018-01-31\", \"description\": \"Jedzenie - restauracje\", \"price\": -342.33}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_SHOPPING_FOOD, \"date\": \"2018-01-31\", \"description\": \"Jedzenie - zakupy\", \"price\": -667.52}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_HEALTH, \"date\": \"2018-01-31\", \"description\": \"Lekarstwa\", \"price\": -166.72}"

curl -X POST "http://localhost:8088/transactions" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"accountId\": $ACCOUNT_ANIA_BALANCE, \"categoryId\": $CATEGORY_HEALTH, \"date\": \"2018-01-31\", \"description\": \"Kosmetyki\", \"price\": -10.97}"
