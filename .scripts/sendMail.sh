#!/usr/bin/env bash

sendEmail -f sidney.oliveira.projeto@zohomail.com \
  -t  sidneyoliveirajunior@gmail.com \
  -s smtp.zoho.com:587 \
  -u "Teste via terminal" \
  -m "Email enviado com o sendEmail!" \
  -xu sidney.oliveira.projeto@zohomail.com \
  -xp '112PUwwnt8eM' \
  -o tls=yes
  
