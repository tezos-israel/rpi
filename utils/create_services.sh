#!/bin/bash
function create_service_files(){
    DATA_DIR=$1
    user=$2
    baker=$3
    proto=$4
    
    SERVICES_DIR="$DATA_DIR/services"
    TEMPLATES_DIR="$SCRIPT_DIR"/services
    
    mkdir -p "$SERVICES_DIR"
    
    services_templates=$(find "$TEMPLATES_DIR"/*.template -printf "%f\n")
    
    for f in $services_templates
    do
        sed "s/\$USER/$user/g" "$TEMPLATES_DIR/$f" | sed "s/\$BAKER_ALIAS/$baker/g" | sed "s/\$PROTO/$proto/g" > "$SERVICES_DIR/${f/\.template/""}"
    done
}
