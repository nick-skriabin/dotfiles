function corne-unzip
    set firmware_path "$HOME/Downloads/firmware"
    set firmware_file "$firmware_path.zip"
    rm -rf $firmware_path
    unzip $firmware_file -d $firmware_path
    rm $firmware_file
end
