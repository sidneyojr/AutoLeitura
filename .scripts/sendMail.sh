#!/usr/bin/env bash
sendEmail -f sidney.oliveira.projeto@zohomail.com \
  -t  sidneyoliveirajunior@gmail.com \
  -s smtp.zoho.com:587 \
  -u "Teste via Pipeline" \
  -m "Email enviado com o sendEmail! com Gihub actions" \
  -a $ARTEFATO \
  -xu sidney.oliveira.projeto@zohomail.com \
  -xp '112PUwwnt8eM' \
  -o tls=yes

