# README

## Calling the token creation endpoint

`curl -i -X POST http://localhost:3000/api/v1/cards -H "Content-Type: application/json" --data-binary @spec/support/fixtures/sample_card.json`

> This will return a token which you will use to charge the CC.

## Calling the charge endpoint

`curl -i -X POST http://localhost:3000/api/v1/charges -H "Content-Type: application/json" --data-binary @spec/support/fixtures/sample_charge.json`
