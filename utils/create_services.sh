#!/bin/bash
function create_service_files(){
    DATA_DIR=$1
    user=$2
    baker=$3
    proto=$4
    
    TEMPLATES_OUT="$DATA_DIR/templates"
    mkdir -p "$TEMPLATES_OUT"
    
    services_templates=$(find ./services/*.template -printf "%f\n")
    
    for f in $services_templates
    do
        sed "s/\$USER/$user/g" "./services/$f" | sed "s/\$BAKER_ALIAS/$baker/g" | sed "s/\$PROTO/$proto/g" > "$TEMPLATES_OUT/${f/\.template/""}"
    done
}
