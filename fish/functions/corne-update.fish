function corne-update
    set firmware_path "$HOME/Downloads/firmware/corne_$argv-nice_nano_v2-zmk.uf2"
    set kbd_path /Volumes/NICENANO
    cp $firmware_path $kbd_path
    rm $firmware_path
end
