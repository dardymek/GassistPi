#!/bin/bash

cd /home/${USER}

echo "Your Model-Id: ${MODEL_ID} Project-Id: ${PROJECT_ID} used for this project" >> modelid.txt

google-oauthlib-tool --scope https://www.googleapis.com/auth/assistant-sdk-prototype \
          --scope https://www.googleapis.com/auth/gcm \
          --save --headless --client-secrets ${GASSIST_CRED_FILENAME}

/home/${USER}/env/bin/python -u /home/${USER}/GassistPi/src/main.py --project_id ${PROJECT_ID} --device_model_id ${MODEL_ID}
