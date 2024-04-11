function aws-cleanup
  echo "Removing old AWS credentials..."
  set -e HS_AWS_ACCESS_KEY_ID
  set -e HS_AWS_SECRET_ACCESS_KEY
  set -e HS_AWS_SESSION_TOKEN
  set -eU HS_AWS_ACCESS_KEY_ID
  set -eU HS_AWS_SECRET_ACCESS_KEY
  set -eU HS_AWS_SESSION_TOKEN
end
