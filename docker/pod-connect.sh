#!/bin/zsh

# Default values
NAMESPACE=""
POD=""
CONTAINER="main"  # Default container name

# Help function
function show_help {
    echo "Usage: $0 -n NAMESPACE [-p POD] [-c CONTAINER]"
    echo ""
    echo "Options:"
    echo "  -n NAMESPACE   Kubernetes namespace"
    echo "  -p POD         Pod name pattern (optional, if not provided will list all pods)"
    echo "  -c CONTAINER   Container name (default: main)"
    echo "  -h             Show this help message"
    exit 1
}

# Parse command line arguments
while getopts "n:p:c:h" opt; do
    case $opt in
        n) NAMESPACE="$OPTARG" ;;
        p) POD="$OPTARG" ;;
        c) CONTAINER="$OPTARG" ;;
        h) show_help ;;
        *) show_help ;;
    esac
done

# Check required parameters
if [ -z "$NAMESPACE" ]; then
    echo "Error: Namespace is required."
    show_help
fi

# Load zsh aliases
source ~/.zshrc

# Get all pods in the namespace
if [ -z "$POD" ]; then
    # If no pod pattern provided, get all pods
    PODS=($(kaws get pods -n "$NAMESPACE" | tail -n +2 | awk '{print $1}'))
else
    # Get pods matching the pattern
    PODS=($(kaws get pods -n "$NAMESPACE" | grep "$POD" | awk '{print $1}'))
fi

# Check if any pods were found
if [ ${#PODS[@]} -eq 0 ]; then
    echo "Error: No pods found in namespace '$NAMESPACE'"
    if [ ! -z "$POD" ]; then
        echo "No pods matching pattern '$POD'"
    fi
    exit 1
fi

# If only one pod found, use it directly
if [ ${#PODS[@]} -eq 1 ]; then
    SELECTED_POD=${PODS[1]}
    echo "Only one pod found. Using: $SELECTED_POD"
else
    # Display menu for pod selection
    echo "Multiple pods found in namespace '$NAMESPACE':"
    for i in {1..${#PODS[@]}}; do
        echo "$i) ${PODS[$i]}"
    done
    
    # Prompt for selection
    echo ""
    echo -n "Select a pod (1-${#PODS[@]}): "
    read selection
    
    # Validate selection
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#PODS[@]} ]; then
        echo "Error: Invalid selection"
        exit 1
    fi
    
    SELECTED_POD=${PODS[$selection]}
fi

echo "Connecting to pod: $SELECTED_POD in namespace: $NAMESPACE, container: $CONTAINER"
kaws exec -it -n "$NAMESPACE" -c "$CONTAINER" "$SELECTED_POD" -- bash
