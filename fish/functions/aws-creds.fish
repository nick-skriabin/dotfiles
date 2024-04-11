function aws-creds
  set creds $(aws configure export-credentials --profile sandbox_dev --format process)

  set AWS_ACCESS_KEY_ID (echo $creds | jq -r '.AccessKeyId')
  set AWS_SECRET_ACCESS_KEY (echo $creds | jq -r '.SecretAccessKey')
  set AWS_SESSION_TOKEN (echo $creds | jq -r '.SessionToken')

  echo "" > "$HOME/.config/fish/conf.d/hs_aws.fish"

  echo "Setting AWS credentials in fish config..."
  echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
  echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
  echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"

  echo "set -Ux HS_AWS_ACCESS_KEY_ID \"$AWS_ACCESS_KEY_ID\";" >> "$HOME/.config/fish/conf.d/hs_aws.fish"
  echo "set -Ux HS_AWS_SECRET_ACCESS_KEY \"$AWS_SECRET_ACCESS_KEY\";" >> "$HOME/.config/fish/conf.d/hs_aws.fish"
  echo "set -Ux HS_AWS_SESSION_TOKEN \"$AWS_SESSION_TOKEN\";" >> "$HOME/.config/fish/conf.d/hs_aws.fish"

  aws-cleanup

  source "$HOME/.config/fish/config.fish"
end
