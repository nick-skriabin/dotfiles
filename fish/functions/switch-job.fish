function switch-job
    set selected_job $(jobs | fzf | awk '{print "%"$1}')
    echo $selected_job
    fg $selected_job
end
