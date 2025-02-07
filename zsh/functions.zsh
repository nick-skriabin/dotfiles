j() {
  job_name=$(jobs | fzf)

  echo $job_name
  if [[ -z $job_name ]];
  then
    return 0
  fi

  job_id=${$(echo $job_name | awk -F " " '{print $1}')//[!0-9]/}

  fg %$job_id
}
